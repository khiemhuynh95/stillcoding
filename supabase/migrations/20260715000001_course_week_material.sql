-- StillCoding — optional per-week markdown study material.
--
-- Course admins author markdown in the manage page; members read it on a
-- dedicated week page. Empty string means "no material" (the member-facing
-- link is hidden), avoiding null handling client-side.
--
-- Access model: no new policies needed. The existing "weeks readable by
-- members" select policy covers reads, and the "weeks managed by course
-- admin" FOR ALL policy (with the is_course_admin app-admin bypass) covers
-- writes to the new column.

alter table public.course_weeks
  add column if not exists material text not null default '';
