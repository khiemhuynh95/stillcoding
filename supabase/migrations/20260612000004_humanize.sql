-- Humanized problem variants.
--
-- The rewrite pass stores a renamed title + a ~10%-altered, newbie-friendly
-- description in *separate* columns so the originals stay intact and the daily
-- sync (which re-upserts the upstream title/content) can't clobber them. The
-- app prefers these when present: display_title ?? title, display_content ??
-- content. Curated multi-tags are written back into topic_tags in place (the
-- sync only rewrites topic_tags when a problem changes upstream).

alter table public.problems
  add column if not exists display_title   text,
  add column if not exists display_content text,
  add column if not exists humanized_at    timestamptz;

-- Drives resumable batching: process rows where humanized_at is null.
create index if not exists problems_humanized_at_idx
  on public.problems (humanized_at);
