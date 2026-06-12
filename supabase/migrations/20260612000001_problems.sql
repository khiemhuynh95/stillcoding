-- StillCoding — problems persistence
-- Mirrors the LeetCode list (/problems) + detail (/problem/{id}) shape so the
-- app can serve the browse list and problem pages from the DB instead of the
-- live API. The daily sync (see 0002_cron.sql + functions/sync-problems) keeps
-- this fresh: new problems are inserted, changed problems updated.

create extension if not exists pgcrypto;

create table if not exists public.problems (
  -- Identity (from the list endpoint; `id` == questionId).
  id                     text primary key,
  frontend_id            text not null,
  title                  text not null,
  title_slug             text not null unique,
  url                    text not null default '',
  difficulty             text not null,            -- 'Easy' | 'Medium' | 'Hard'
  paid_only              boolean not null default false,
  has_solution           boolean not null default false,
  has_video_solution     boolean not null default false,
  source                 text not null default 'leetcode',

  -- Detail (from /problem/{id}). Null until detail has been fetched.
  question_id            text,
  content                text,
  likes                  integer,
  dislikes               integer,
  stats                  jsonb,                    -- parsed ProblemStats
  similar_questions      jsonb,                    -- parsed array
  category_title         text,
  hints                  jsonb,                    -- string[]
  topic_tags             jsonb,                    -- [{ name, slug }]
  company_tags           jsonb,                    -- [{ name, slug }] | null

  -- Solution (per the user's request). Most are paid/locked: content is null
  -- and can_see_detail is false, but we persist whatever the API returns.
  solution_content       text,
  solution_can_see_detail boolean,

  -- Sync bookkeeping.
  list_hash              text,                     -- hash of the list fields; drives change detection
  detail_synced_at       timestamptz,             -- when detail was last fetched
  created_at             timestamptz not null default now(),
  updated_at             timestamptz not null default now()
);

create index if not exists problems_difficulty_idx on public.problems (difficulty);
create index if not exists problems_frontend_id_idx on public.problems (frontend_id);

-- Bump updated_at on any change.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists problems_set_updated_at on public.problems;
create trigger problems_set_updated_at
  before update on public.problems
  for each row execute function public.set_updated_at();

-- Audit log of each sync run (handy when the cron runs unattended).
create table if not exists public.sync_runs (
  id             bigint generated always as identity primary key,
  started_at     timestamptz not null default now(),
  finished_at    timestamptz,
  inserted       integer not null default 0,
  updated        integer not null default 0,
  detail_fetched integer not null default 0,
  total_seen     integer not null default 0,
  ok             boolean,
  error          text
);

-- Row Level Security: the public app (anon key) may read; only the service
-- role (used by the Edge Function) may write. The service role bypasses RLS,
-- so no write policy is needed.
alter table public.problems enable row level security;
alter table public.sync_runs enable row level security;

drop policy if exists "problems are public read" on public.problems;
create policy "problems are public read"
  on public.problems for select
  to anon, authenticated
  using (true);

drop policy if exists "sync_runs are public read" on public.sync_runs;
create policy "sync_runs are public read"
  on public.sync_runs for select
  to anon, authenticated
  using (true);
