-- StillCoding — app admins see and manage ALL courses.
--
-- App admins (profiles.is_admin) are effectively enrolled everywhere: the two
-- RLS helper functions gain an is_app_admin() bypass, so every member-only
-- read policy and course-admin write policy opens up for them across all
-- courses — no course_members rows are materialized (nothing to keep in sync
-- when courses are created or admins are flagged, and admins don't pollute
-- leaderboards they aren't competing in).
--
-- Deliberately NOT bypassed: record_run still requires a real membership row,
-- so an app admin only earns points in courses they explicitly joined — and
-- the course_leaderboard view is driven by course_members, so admins without
-- a membership row don't appear in standings.

create or replace function public.is_course_member(cid uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from course_members
    where course_id = cid and user_id = auth.uid()
  ) or public.is_app_admin();
$$;

create or replace function public.is_course_admin(cid uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from course_members
    where course_id = cid and user_id = auth.uid() and role = 'admin'
  ) or public.is_app_admin();
$$;
