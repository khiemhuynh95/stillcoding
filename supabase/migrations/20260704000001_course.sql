-- StillCoding — course feature (hidden beta): auth profiles, courses, weeks,
-- problems, membership, invites, and per-course progress.
--
-- This is the app's first use of Supabase Auth. Admin users are created in the
-- dashboard and flagged via profiles.is_admin; regular users register on the
-- unlisted /course/login page. Invites are plain rows (email + role + course)
-- redeemed automatically at registration (auth.users trigger) or on sign-in
-- (redeem_invites RPC) — no email sending. Users may also self-join with a
-- course join code, and can leave / rejoin anytime (progress rows are kept, so
-- rejoining restores a member's standing).
--
-- Access model: course content is member-only. Reads and writes are gated by
-- auth.uid() policies through the security-definer helpers below (definer
-- functions keep course_members policies from recursing into themselves).
-- problem_progress has NO client write path — scoring happens exclusively in
-- the record_run RPC (added by the scoring migration) so the points formula
-- lives server-side. The public catalog tables stay untouched and anon-readable;
-- the anonymous app keeps working exactly as before.

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- Tables
-- ---------------------------------------------------------------------------

-- One row per auth user, auto-created by the on_auth_user_created trigger.
create table if not exists public.profiles (
  id           uuid primary key references auth.users (id) on delete cascade,
  display_name text not null default '',
  is_admin     boolean not null default false,  -- may create courses; set manually in the dashboard
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

create table if not exists public.courses (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  description text not null default '',
  -- Human-shareable join code ("course id" users type to enroll).
  join_code   text not null unique default substr(md5(gen_random_uuid()::text), 1, 8),
  -- Course timeline: points are only earned inside [start_date, end_date]
  -- (null = unbounded on that side). Enforced by the record_run RPC.
  start_date  date,
  end_date    date,
  created_by  uuid references public.profiles (id) on delete set null,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  constraint courses_dates check (
    start_date is null or end_date is null or start_date <= end_date
  )
);

create table if not exists public.course_members (
  course_id  uuid not null references public.courses (id) on delete cascade,
  user_id    uuid not null references public.profiles (id) on delete cascade,
  role       text not null default 'member' check (role in ('admin', 'member')),
  created_at timestamptz not null default now(),
  primary key (course_id, user_id)
);

create table if not exists public.course_invites (
  id          uuid primary key default gen_random_uuid(),
  course_id   uuid not null references public.courses (id) on delete cascade,
  email       text not null,  -- stored lowercased
  role        text not null default 'member' check (role in ('admin', 'member')),
  invited_by  uuid references public.profiles (id) on delete set null,
  redeemed_by uuid references public.profiles (id) on delete set null,
  redeemed_at timestamptz,
  created_at  timestamptz not null default now(),
  unique (course_id, email)
);

create index if not exists course_invites_email_idx
  on public.course_invites (email) where redeemed_at is null;

create table if not exists public.course_weeks (
  id         uuid primary key default gen_random_uuid(),
  course_id  uuid not null references public.courses (id) on delete cascade,
  title      text not null,
  position   integer not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists course_weeks_course_idx
  on public.course_weeks (course_id, position);

create table if not exists public.course_problems (
  id         uuid primary key default gen_random_uuid(),
  week_id    uuid not null references public.course_weeks (id) on delete cascade,
  title_slug text not null,  -- catalog slug (leetcode or custom); resolved client-side
  position   integer not null default 0,
  created_at timestamptz not null default now(),
  unique (week_id, title_slug)
);

create index if not exists course_problems_week_idx
  on public.course_problems (week_id, position);

-- Per (user, course, problem): failed-run counter until the first passing run,
-- then a frozen score. A problem in two of a user's courses scores per course.
-- Rows deliberately survive a member leaving (rejoin restores standing).
create table if not exists public.problem_progress (
  user_id         uuid not null references public.profiles (id) on delete cascade,
  course_id       uuid not null references public.courses (id) on delete cascade,
  title_slug      text not null,
  failed_attempts integer not null default 0,
  completed_at    timestamptz,
  points          integer,
  exec_ms         integer,
  updated_at      timestamptz not null default now(),
  primary key (user_id, course_id, title_slug)
);

create index if not exists problem_progress_course_idx
  on public.problem_progress (course_id);

-- updated_at bumps (shared helper from the problems migration).
drop trigger if exists profiles_set_updated_at on public.profiles;
create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

drop trigger if exists courses_set_updated_at on public.courses;
create trigger courses_set_updated_at
  before update on public.courses
  for each row execute function public.set_updated_at();

drop trigger if exists problem_progress_set_updated_at on public.problem_progress;
create trigger problem_progress_set_updated_at
  before update on public.problem_progress
  for each row execute function public.set_updated_at();

-- ---------------------------------------------------------------------------
-- Policy helpers (security definer so course_members policies don't recurse)
-- ---------------------------------------------------------------------------

create or replace function public.is_course_member(cid uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from course_members
    where course_id = cid and user_id = auth.uid()
  );
$$;

create or replace function public.is_course_admin(cid uuid)
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from course_members
    where course_id = cid and user_id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.is_app_admin()
returns boolean
language sql stable security definer set search_path = public
as $$
  select coalesce((select is_admin from profiles where id = auth.uid()), false);
$$;

-- ---------------------------------------------------------------------------
-- New-user trigger + invite redemption
-- ---------------------------------------------------------------------------

-- Enroll a user into every unredeemed invite matching their email.
create or replace function public.apply_invites(uid uuid, uemail text)
returns integer
language plpgsql security definer set search_path = public
as $$
declare
  inv record;
  applied integer := 0;
begin
  if uid is null or uemail is null then
    return 0;
  end if;
  for inv in
    select id, course_id, role from course_invites
    where email = lower(uemail) and redeemed_at is null
  loop
    insert into course_members (course_id, user_id, role)
    values (inv.course_id, uid, inv.role)
    on conflict (course_id, user_id) do nothing;
    update course_invites
      set redeemed_by = uid, redeemed_at = now()
      where id = inv.id;
    applied := applied + 1;
  end loop;
  return applied;
end;
$$;

-- Create the profile row and apply any pending invites the moment a user
-- registers. Security definer with a pinned search_path is required — the
-- auth admin role that fires this trigger has no grants on public tables.
create or replace function public.handle_new_user()
returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'display_name', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  perform public.apply_invites(new.id, new.email);
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Called by the app on sign-in to pick up invites created after registration.
create or replace function public.redeem_invites()
returns integer
language sql security definer set search_path = public
as $$
  select public.apply_invites(
    auth.uid(),
    (select email from auth.users where id = auth.uid())
  );
$$;

-- ---------------------------------------------------------------------------
-- RPCs (course creation / joining go through definer functions so members
-- can't self-insert privileged rows)
-- ---------------------------------------------------------------------------

-- App admins only. Creates the course and enrolls the creator as its admin in
-- one call (sidesteps the chicken-and-egg with the course_members policy).
create or replace function public.create_course(
  p_name text,
  p_description text default '',
  p_start_date date default null,
  p_end_date date default null
)
returns public.courses
language plpgsql security definer set search_path = public
as $$
declare
  c public.courses;
begin
  if auth.uid() is null then
    raise exception 'not signed in';
  end if;
  if not public.is_app_admin() then
    raise exception 'only admins may create courses';
  end if;
  if coalesce(trim(p_name), '') = '' then
    raise exception 'course name is required';
  end if;
  insert into courses (name, description, start_date, end_date, created_by)
  values (trim(p_name), coalesce(p_description, ''), p_start_date, p_end_date, auth.uid())
  returning * into c;
  insert into course_members (course_id, user_id, role)
  values (c.id, auth.uid(), 'admin');
  return c;
end;
$$;

-- Self-enroll with a join code. Idempotent: rejoining is a no-op that keeps
-- any prior role, and prior problem_progress rows reattach automatically.
create or replace function public.join_course(p_join_code text)
returns uuid
language plpgsql security definer set search_path = public
as $$
declare
  cid uuid;
begin
  if auth.uid() is null then
    raise exception 'not signed in';
  end if;
  select id into cid from courses where join_code = lower(trim(p_join_code));
  if cid is null then
    raise exception 'unknown course id';
  end if;
  insert into course_members (course_id, user_id, role)
  values (cid, auth.uid(), 'member')
  on conflict (course_id, user_id) do nothing;
  return cid;
end;
$$;

-- ---------------------------------------------------------------------------
-- Row Level Security — course content is member-only; anon has no policies on
-- any of these tables (the anonymous app never sees them).
-- ---------------------------------------------------------------------------

alter table public.profiles enable row level security;
alter table public.courses enable row level security;
alter table public.course_members enable row level security;
alter table public.course_invites enable row level security;
alter table public.course_weeks enable row level security;
alter table public.course_problems enable row level security;
alter table public.problem_progress enable row level security;

-- profiles: any signed-in user may read (member names on course pages); a user
-- may update only their own row, and only display_name (column-level grant —
-- is_admin is not self-settable). Inserts come only from the definer trigger.
drop policy if exists "profiles readable by authenticated" on public.profiles;
create policy "profiles readable by authenticated"
  on public.profiles for select
  to authenticated
  using (true);

drop policy if exists "profiles self update" on public.profiles;
create policy "profiles self update"
  on public.profiles for update
  to authenticated
  using (id = auth.uid())
  with check (id = auth.uid());

revoke update on public.profiles from authenticated;
grant update (display_name) on public.profiles to authenticated;

-- courses: members read; course admins update/delete. Insert only via the
-- create_course RPC (no insert policy). Non-members join via join_course,
-- which looks up the join code as definer.
drop policy if exists "courses readable by members" on public.courses;
create policy "courses readable by members"
  on public.courses for select
  to authenticated
  using (public.is_course_member(id));

drop policy if exists "courses updatable by course admin" on public.courses;
create policy "courses updatable by course admin"
  on public.courses for update
  to authenticated
  using (public.is_course_admin(id))
  with check (public.is_course_admin(id));

drop policy if exists "courses deletable by course admin" on public.courses;
create policy "courses deletable by course admin"
  on public.courses for delete
  to authenticated
  using (public.is_course_admin(id));

-- course_members: members see their course's roster; course admins add
-- members (invites/manual). A user may always remove their own row (leave);
-- admins may remove anyone.
drop policy if exists "members readable by members" on public.course_members;
create policy "members readable by members"
  on public.course_members for select
  to authenticated
  using (public.is_course_member(course_id) or user_id = auth.uid());

drop policy if exists "members insertable by course admin" on public.course_members;
create policy "members insertable by course admin"
  on public.course_members for insert
  to authenticated
  with check (public.is_course_admin(course_id));

drop policy if exists "members updatable by course admin" on public.course_members;
create policy "members updatable by course admin"
  on public.course_members for update
  to authenticated
  using (public.is_course_admin(course_id))
  with check (public.is_course_admin(course_id));

drop policy if exists "members removable by admin or self" on public.course_members;
create policy "members removable by admin or self"
  on public.course_members for delete
  to authenticated
  using (public.is_course_admin(course_id) or user_id = auth.uid());

-- course_invites: course-admin only in all directions; redemption happens
-- through the definer functions above.
drop policy if exists "invites visible to course admin" on public.course_invites;
create policy "invites visible to course admin"
  on public.course_invites for select
  to authenticated
  using (public.is_course_admin(course_id));

drop policy if exists "invites insertable by course admin" on public.course_invites;
create policy "invites insertable by course admin"
  on public.course_invites for insert
  to authenticated
  with check (public.is_course_admin(course_id) and email = lower(email));

drop policy if exists "invites deletable by course admin" on public.course_invites;
create policy "invites deletable by course admin"
  on public.course_invites for delete
  to authenticated
  using (public.is_course_admin(course_id));

-- course_weeks / course_problems: members read; course admins write.
drop policy if exists "weeks readable by members" on public.course_weeks;
create policy "weeks readable by members"
  on public.course_weeks for select
  to authenticated
  using (public.is_course_member(course_id));

drop policy if exists "weeks managed by course admin" on public.course_weeks;
create policy "weeks managed by course admin"
  on public.course_weeks for all
  to authenticated
  using (public.is_course_admin(course_id))
  with check (public.is_course_admin(course_id));

drop policy if exists "course problems readable by members" on public.course_problems;
create policy "course problems readable by members"
  on public.course_problems for select
  to authenticated
  using (public.is_course_member(
    (select course_id from public.course_weeks w where w.id = week_id)
  ));

drop policy if exists "course problems managed by course admin" on public.course_problems;
create policy "course problems managed by course admin"
  on public.course_problems for all
  to authenticated
  using (public.is_course_admin(
    (select course_id from public.course_weeks w where w.id = week_id)
  ))
  with check (public.is_course_admin(
    (select course_id from public.course_weeks w where w.id = week_id)
  ));

-- problem_progress: a user reads their own rows; members read their course's
-- rows (feeds the member-only leaderboard). NO write policies — all writes go
-- through the record_run RPC (scoring migration).
drop policy if exists "progress readable by self or members" on public.problem_progress;
create policy "progress readable by self or members"
  on public.problem_progress for select
  to authenticated
  using (user_id = auth.uid() or public.is_course_member(course_id));

-- ---------------------------------------------------------------------------
-- Leaderboard view — security_invoker, so the member-only RLS above applies
-- to whoever queries it (anon and non-members simply get no rows). Scoped to
-- slugs currently in the course, so removed problems drop off the board.
-- ---------------------------------------------------------------------------

create or replace view public.course_leaderboard
with (security_invoker = true) as
select
  cm.course_id,
  cm.user_id,
  pr.display_name,
  coalesce(sum(pp.points), 0)::int as points,
  count(pp.completed_at)::int as solved
from public.course_members cm
join public.profiles pr on pr.id = cm.user_id
left join (
  select distinct w.course_id, cp.title_slug
  from public.course_weeks w
  join public.course_problems cp on cp.week_id = w.id
) cs on cs.course_id = cm.course_id
left join public.problem_progress pp
  on pp.user_id = cm.user_id
 and pp.course_id = cm.course_id
 and pp.title_slug = cs.title_slug
 and pp.completed_at is not null
group by cm.course_id, cm.user_id, pr.display_name;
