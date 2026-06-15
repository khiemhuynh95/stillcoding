-- StillCoding — collaboration sessions
-- Backs the real-time co-editing feature (shareable link). Unlike the catalog
-- tables, this one is *client-writable*: it is the only table the anon app
-- writes to. Live keystrokes + cursors travel over Supabase Realtime Broadcast
-- (ephemeral, never touch this table); the row stores only a debounced base64
-- Yjs snapshot so late-joiners and reloads get the current buffer.
--
-- Security model: the id is unguessable and the link is a capability URL —
-- anyone holding it may read + edit. Anon insert is intentionally open for v1;
-- abuse is bounded by the unguessable id, a `doc` size cap, and retention: a
-- daily pg_cron job deletes sessions idle for 30 days (by `updated_at`, so an
-- active session keeps sliding forward). There are no accounts; collaborators
-- are identified only by an ephemeral display name + color held client-side.

create extension if not exists pgcrypto;

create table if not exists public.collab_sessions (
  id          text primary key,              -- unguessable, client-generated
  slug        text not null,                 -- problem this session edits
  language    text not null,                 -- locked for the session's life
  doc         text,                          -- base64 Yjs state snapshot (nullable until first save)
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),

  -- Bound the snapshot size (~256 KB binary ≈ ~350 KB base64). Keeps a single
  -- anonymous write from ballooning a row.
  constraint collab_doc_size check (doc is null or char_length(doc) <= 350000)
);

-- Supports the retention sweep (delete where updated_at < cutoff).
create index if not exists collab_sessions_updated_at_idx
  on public.collab_sessions (updated_at);

-- Bump updated_at on any change. Reuses the shared helper from the problems
-- migration (public.set_updated_at), which is created earlier in the history.
drop trigger if exists collab_sessions_set_updated_at on public.collab_sessions;
create trigger collab_sessions_set_updated_at
  before update on public.collab_sessions
  for each row execute function public.set_updated_at();

-- Row Level Security: the anon app may create, read, and update a session.
-- (No delete — sessions are reaped by the retention sweep below.) This is the
-- single client-write exception; every other public table stays read-only.
alter table public.collab_sessions enable row level security;

drop policy if exists "collab sessions are public insert" on public.collab_sessions;
create policy "collab sessions are public insert"
  on public.collab_sessions for insert
  to anon, authenticated
  with check (true);

drop policy if exists "collab sessions are public read" on public.collab_sessions;
create policy "collab sessions are public read"
  on public.collab_sessions for select
  to anon, authenticated
  using (true);

drop policy if exists "collab sessions are public update" on public.collab_sessions;
create policy "collab sessions are public update"
  on public.collab_sessions for update
  to anon, authenticated
  using (true)
  with check (true);

-- Realtime Broadcast (the live transport) does not require this table to be in
-- the realtime publication — broadcast messages are ephemeral and never read
-- Postgres changes here. The table exists purely for snapshot persistence.

-- Retention: daily at 06:30 UTC (just after the catalog sync), delete sessions
-- with no activity for 30 days. `updated_at` is bumped on every snapshot save,
-- so an actively edited session keeps sliding its cutoff forward and only truly
-- idle sessions are reaped. pg_cron is already enabled by the catalog cron
-- migration.
select cron.unschedule('reap-collab-sessions-daily')
where exists (select 1 from cron.job where jobname = 'reap-collab-sessions-daily');

select cron.schedule(
  'reap-collab-sessions-daily',
  '30 6 * * *',
  $$ delete from public.collab_sessions where updated_at < now() - interval '30 days' $$
);
