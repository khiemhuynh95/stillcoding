# Supabase — problem persistence & daily sync

This folder persists the LeetCode problem catalog in Supabase and refreshes it
once a day. The Next.js app reads the browse list and problem detail from the
`problems` table (falling back to the live API when Supabase env vars are
unset).

```
supabase/
  migrations/
    20260612000001_problems.sql   # problems + sync_runs tables, RLS, updated_at trigger
    20260612000002_tags.sql       # tags table + GIN index on problems.topic_tags
    20260612000003_cron.sql       # pg_cron daily job that invokes the Edge Function
  functions/
    sync-problems/                # Edge Function: fetch API, diff, upsert
```

## How it works

1. **`sync-problems` Edge Function** fetches `GET /problems` from the
   leetcode-api, diffs it against the `problems` table (via a per-row hash of
   the list fields), and **inserts new** problems / **updates changed** ones.
2. For new, changed, or not-yet-detailed problems it also fetches
   `GET /problem/{id}` and persists `content`, `stats`, `topic_tags`, the
   `solution` field, etc. Detail fetches are capped per run (`?limit=`, default
   400) so the function stays within its time budget; the rest are picked up on
   the next run.
3. **pg_cron** invokes the function daily at 06:00 UTC. Each run is logged to
   `public.sync_runs`.

## One-time setup

Requires the [Supabase CLI](https://supabase.com/docs/guides/cli) linked to your
project (`supabase link --project-ref <ref>`).

```bash
# 0. Authenticate + link (interactive: browser login, then DB password)
supabase login
supabase link --project-ref <PROJECT_REF>

# 1. Apply all migrations (problems, tags, cron schedule)
supabase db push

# 2. Configure + deploy the Edge Function
supabase secrets set LEETCODE_API_BASE=https://leetcode-api-pied.vercel.app
supabase functions deploy sync-problems

# 3. Backfill the catalog now (full run; ~1700 detail fetches over a few invokes)
supabase functions invoke sync-problems
#   …repeat until sync_runs shows detail_fetched tapering to ~0, or hit it with
#   ?limit=2000 via curl + the service role key for a single big run.

# 4. Give the cron its secrets — run in the SQL editor (keeps them out of the CLI):
#      select vault.create_secret('https://<PROJECT_REF>.supabase.co', 'project_url');
#      select vault.create_secret('<SERVICE_ROLE_KEY>', 'service_role_key');
```

> `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` are injected into Edge Functions
> automatically — you don't set those yourself.

## Point the app at Supabase

In `.env.local` (and your Vercel project env):

```
NEXT_PUBLIC_SUPABASE_URL=https://<PROJECT_REF>.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon public key>
```

With these set, the browse list and problem pages read from Supabase. Leave them
blank to keep reading the live API.

## Operating

```sql
-- Recent sync runs
select * from public.sync_runs order by started_at desc limit 10;

-- Cron status / history
select * from cron.job;
select * from cron.job_run_details order by start_time desc limit 10;

-- Run a sync by hand (e.g. continue a backfill)
-- curl -X POST ".../functions/v1/sync-problems?limit=500" -H "Authorization: Bearer <SERVICE_ROLE_KEY>"
```

## Scope notes

- The cron syncs the **problem list + detail (incl. solution) + the topic tag
  list** (`tags` table, from `GET /tags`). The app serves the sidebar tags
  (`getTags`) and tag-filtered browsing (`getProblemsByTag`) from the DB.
- `getProblemsByTag` filters `problems.topic_tags`, which is only populated once
  a problem's detail has been synced — so run the full backfill (step 3) before
  relying on it. If the DB returns nothing for a tag the app falls back to the
  live API.
- Custom problems (`lib/customProblems.ts`) are merged in the app layer and are
  **not** written to Supabase.
