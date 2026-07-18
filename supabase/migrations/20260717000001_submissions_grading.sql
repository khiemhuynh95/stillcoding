-- StillCoding — simplified grading: Run vs Submit.
--
-- Replaces the run-based scoring model (record_run) with a submission-based
-- one. Run only counts (run_count); Submit saves the user's code + test
-- results into public.submissions, counts (submit_count / failed_submits),
-- and is the only action that can score points. Points are frozen at the
-- FIRST successful submission per (user, course, problem):
--
--   base       = 100 / 200 / 300 by problems.difficulty
--   timeFactor = 1 - 0.70 * (current_date - start_date) / (end_date - start_date)
--                clamped to [0.30, 1.0]; 1.0 when either date is null or
--                start = end (earlier success in the course window scores more)
--   points     = round(base * greatest(0.30, timeFactor - 0.10 * failed_submits))
--
-- The exec-time speed bonus is gone. Trust model unchanged: the client is
-- trusted about WHAT a run produced (pass/fail, test counts); it is never
-- trusted to count anything, compute points, or supply timestamps — the
-- server clock is the only clock.
--
-- Existing problem_progress rows keep their old frozen points (accepted for
-- the beta; the formula change is not applied retroactively).

-- problem_progress: attempts are now submits; the speed bonus input is gone;
-- run/submit counters are pure metrics.
alter table public.problem_progress rename column failed_attempts to failed_submits;
alter table public.problem_progress drop column exec_ms;
alter table public.problem_progress
  add column run_count    integer not null default 0,
  add column submit_count integer not null default 0;

-- One row per Submit: the code as submitted plus its test report. course_id
-- is null for practice submits (signed-in, but not via a course link or the
-- course checks failed).
create table public.submissions (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid not null references public.profiles (id) on delete cascade,
  course_id    uuid references public.courses (id) on delete set null,
  title_slug   text not null,
  lang         text not null,
  code         text not null,
  tests_total  integer not null default 0,
  tests_passed integer not null default 0,
  tests_failed integer not null default 0,
  passed       boolean not null,
  created_at   timestamptz not null default now()
);

create index submissions_user_idx
  on public.submissions (user_id, title_slug, created_at desc);
create index submissions_course_idx
  on public.submissions (course_id) where course_id is not null;

-- Writes go only through the record_submission definer RPC (no client write
-- policies), same pattern as problem_progress.
alter table public.submissions enable row level security;

create policy "submissions readable by owner or course admin"
  on public.submissions for select to authenticated
  using (
    user_id = (select auth.uid())
    or (course_id is not null and public.is_course_admin(course_id))
  );

-- Run = free metric. Counts every finished run in a course context,
-- regardless of timeline or completion.
create or replace function public.record_test_run(
  p_course_id uuid,
  p_slug text
)
returns void
language plpgsql security definer set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'not signed in';
  end if;

  if not exists (
    select 1 from course_members
    where course_id = p_course_id and user_id = auth.uid()
  ) then
    raise exception 'not a member of this course';
  end if;

  if not exists (
    select 1
    from course_weeks w
    join course_problems cp on cp.week_id = w.id
    where w.course_id = p_course_id and cp.title_slug = p_slug
  ) then
    raise exception 'problem is not part of this course';
  end if;

  insert into problem_progress (user_id, course_id, title_slug, run_count)
  values (auth.uid(), p_course_id, p_slug, 1)
  on conflict (user_id, course_id, title_slug)
  do update set run_count = problem_progress.run_count + 1;
end;
$$;

-- Submit = save code + test result, count it, and score the first success.
-- The submission row must survive even when the course context is invalid, so
-- course checks soft-fail to a practice submit (cid := null) instead of
-- raising after the insert and rolling it back.
create or replace function public.record_submission(
  p_slug text,
  p_lang text,
  p_code text,
  p_total integer,
  p_passed_tests integer,
  p_failed_tests integer,
  p_passed boolean,
  p_course_id uuid default null
)
returns public.problem_progress
language plpgsql security definer set search_path = public
as $$
declare
  cid uuid := p_course_id;
  base integer;
  tf numeric;
  progress public.problem_progress;
  course public.courses;
begin
  if auth.uid() is null then
    raise exception 'not signed in';
  end if;
  if length(p_code) > 100000 then
    raise exception 'submission too large';
  end if;

  if cid is not null then
    if not exists (
      select 1 from course_members
      where course_id = cid and user_id = auth.uid()
    ) or not exists (
      select 1
      from course_weeks w
      join course_problems cp on cp.week_id = w.id
      where w.course_id = cid and cp.title_slug = p_slug
    ) then
      cid := null;
    end if;
  end if;

  insert into submissions
    (user_id, course_id, title_slug, lang, code,
     tests_total, tests_passed, tests_failed, passed)
  values
    (auth.uid(), cid, p_slug, p_lang, p_code,
     greatest(0, coalesce(p_total, 0)),
     greatest(0, coalesce(p_passed_tests, 0)),
     greatest(0, coalesce(p_failed_tests, 0)),
     p_passed);

  -- Practice submit: saved, but no counters and no points.
  if cid is null then
    return null;
  end if;

  insert into problem_progress (user_id, course_id, title_slug)
  values (auth.uid(), cid, p_slug)
  on conflict (user_id, course_id, title_slug) do nothing;

  select * into progress from problem_progress
  where user_id = auth.uid()
    and course_id = cid
    and title_slug = p_slug
  for update;

  update problem_progress
  set submit_count = submit_count + 1
  where user_id = auth.uid()
    and course_id = cid
    and title_slug = p_slug
  returning * into progress;

  -- Points are frozen at the first successful submission — later submits are
  -- counted as a metric but never change the score.
  if progress.completed_at is not null then
    return progress;
  end if;

  -- Outside the course timeline: the submit is stored and counted, but there
  -- is no penalty and no points.
  select * into course from courses where id = cid;
  if (course.start_date is not null and current_date < course.start_date)
     or (course.end_date is not null and current_date > course.end_date) then
    return progress;
  end if;

  if not p_passed then
    update problem_progress
    set failed_submits = failed_submits + 1
    where user_id = auth.uid()
      and course_id = cid
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

  -- Earlier first success in the course window scores more: linear decay from
  -- 1.0 at start_date to 0.30 at end_date. Missing dates or a zero-length
  -- window score as 1.0.
  if course.start_date is null or course.end_date is null
     or course.end_date <= course.start_date then
    tf := 1.0;
  else
    tf := greatest(0.30, least(1.0,
      1 - 0.70 * (current_date - course.start_date)::numeric
              / (course.end_date - course.start_date)));
  end if;

  update problem_progress
  set completed_at = now(),
      points = round(
        base * greatest(0.30, tf - 0.10 * failed_submits)
      )::integer
  where user_id = auth.uid()
    and course_id = cid
    and title_slug = p_slug
  returning * into progress;
  return progress;
end;
$$;

drop function if exists public.record_run(uuid, text, boolean, integer);
