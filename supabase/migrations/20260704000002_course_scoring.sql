-- StillCoding — course scoring: the record_run RPC.
--
-- The ONLY write path into problem_progress (the table has no client write
-- policies). The browser reports each finished run — pass/fail (detected from
-- the unittest-style test report) and measured execution time — and this
-- function does the rest server-side: membership + course-content + timeline
-- checks, the failed-attempt counter, and the points formula, so the formula
-- lives in exactly one place. Trust model (accepted for the beta): the client
-- is trusted about WHAT happened in a run (passed / exec_ms); it is not
-- trusted to count attempts, compute points, or write rows.
--
-- Points, frozen at the FIRST passing run per (user, course, problem):
--   base        = 100 / 200 / 300 by problems.difficulty
--   penalty     = 10% of base per failed run before the pass, floored at 30%
--   speed bonus = up to 10% of base, linear from 2s (full) to 15s (none) —
--                 15s is the runners' watchdog cap
-- Runs outside the course timeline are a silent no-op (the UI shows the
-- course-ended state instead of a points toast).

create or replace function public.record_run(
  p_course_id uuid,
  p_slug text,
  p_passed boolean,
  p_exec_ms integer default null
)
returns public.problem_progress
language plpgsql security definer set search_path = public
as $$
declare
  base integer;
  ms integer;
  progress public.problem_progress;
  course public.courses;
begin
  if auth.uid() is null then
    raise exception 'not signed in';
  end if;

  -- Must be a member of the course...
  if not exists (
    select 1 from course_members
    where course_id = p_course_id and user_id = auth.uid()
  ) then
    raise exception 'not a member of this course';
  end if;

  -- ...and the course must actually contain this problem.
  if not exists (
    select 1
    from course_weeks w
    join course_problems cp on cp.week_id = w.id
    where w.course_id = p_course_id and cp.title_slug = p_slug
  ) then
    raise exception 'problem is not part of this course';
  end if;

  insert into problem_progress (user_id, course_id, title_slug)
  values (auth.uid(), p_course_id, p_slug)
  on conflict (user_id, course_id, title_slug) do nothing;

  select * into progress from problem_progress
  where user_id = auth.uid()
    and course_id = p_course_id
    and title_slug = p_slug
  for update;

  -- Score is frozen at the first completing run — later runs never change it.
  if progress.completed_at is not null then
    return progress;
  end if;

  -- Outside the course timeline nothing is recorded (no attempts, no points).
  select * into course from courses where id = p_course_id;
  if (course.start_date is not null and current_date < course.start_date)
     or (course.end_date is not null and current_date > course.end_date) then
    return progress;
  end if;

  if not p_passed then
    update problem_progress
    set failed_attempts = failed_attempts + 1
    where user_id = auth.uid()
      and course_id = p_course_id
      and title_slug = p_slug
    returning * into progress;
    return progress;
  end if;

  select case difficulty
           when 'Easy' then 100
           when 'Medium' then 200
           when 'Hard' then 300
         end
  into base
  from problems
  where title_slug = p_slug;
  if base is null then
    raise exception 'unknown problem difficulty for %', p_slug;
  end if;

  -- Clamp the reported execution time to [0, watchdog cap]; a missing value
  -- scores as the cap (no bonus).
  ms := least(15000, greatest(0, coalesce(p_exec_ms, 15000)));

  update problem_progress
  set completed_at = now(),
      exec_ms = ms,
      points = round(
        base * greatest(0.30, 1 - 0.10 * failed_attempts)
        + base * 0.10 * greatest(0.0, least(1.0, (15000 - ms) / 13000.0))
      )::integer
  where user_id = auth.uid()
    and course_id = p_course_id
    and title_slug = p_slug
  returning * into progress;
  return progress;
end;
$$;
