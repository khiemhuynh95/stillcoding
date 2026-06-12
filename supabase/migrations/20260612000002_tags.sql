-- Persist the topic tag list (from GET /tags) and make tag-filtered browsing
-- of the problems table fast.

create table if not exists public.tags (
  slug          text primary key,
  name          text not null,
  problem_count integer not null default 0,
  updated_at    timestamptz not null default now()
);

drop trigger if exists tags_set_updated_at on public.tags;
create trigger tags_set_updated_at
  before update on public.tags
  for each row execute function public.set_updated_at();

-- getProblemsByTag filters problems.topic_tags (jsonb) by slug containment;
-- a GIN index keeps that quick.
create index if not exists problems_topic_tags_idx
  on public.problems using gin (topic_tags);

alter table public.tags enable row level security;

drop policy if exists "tags are public read" on public.tags;
create policy "tags are public read"
  on public.tags for select
  to anon, authenticated
  using (true);
