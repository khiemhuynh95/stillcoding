import { supabaseClient } from "./supabase";
import type {
  Course,
  CourseInvite,
  CourseMember,
  CourseProblemRef,
  CourseRole,
  CourseWeek,
  LeaderboardEntry,
  ProblemProgress,
} from "./types";

/**
 * Data access for the course feature (hidden beta). All course reads/writes go
 * through here — components use the hooks in hooks/useCourses.ts, never the
 * Supabase client directly. Everything requires a signed-in session; RLS keeps
 * course content member-only and privileged writes (create_course, join_course,
 * record_run, invite redemption) go through security-definer RPCs so the
 * client can't self-elevate. Snake_case rows are normalized to the camelCase
 * shapes in lib/types.ts at this boundary.
 */

export const courseEnabled = supabaseClient != null;

function requireClient() {
  if (!supabaseClient) {
    throw new Error("Supabase is not configured");
  }
  return supabaseClient;
}

// ---------------------------------------------------------------------------
// Row shapes (snake_case) + mappers
// ---------------------------------------------------------------------------

interface CourseRow {
  id: string;
  name: string;
  description: string;
  join_code: string;
  start_date: string | null;
  end_date: string | null;
}

interface CourseProblemRow {
  id: string;
  week_id: string;
  title_slug: string;
  position: number;
}

interface CourseWeekRow {
  id: string;
  course_id: string;
  title: string;
  position: number;
  course_problems: CourseProblemRow[];
}

interface ProgressRow {
  course_id: string;
  title_slug: string;
  failed_attempts: number;
  completed_at: string | null;
  points: number | null;
  exec_ms: number | null;
}

function rowToCourse(
  r: CourseRow,
  myRole: CourseRole,
  enrolled: boolean,
): Course {
  return {
    id: r.id,
    name: r.name,
    description: r.description,
    joinCode: r.join_code,
    startDate: r.start_date,
    endDate: r.end_date,
    myRole,
    enrolled,
  };
}

function rowToProblemRef(r: CourseProblemRow): CourseProblemRef {
  return {
    id: r.id,
    weekId: r.week_id,
    titleSlug: r.title_slug,
    position: r.position,
  };
}

function rowToWeek(r: CourseWeekRow): CourseWeek {
  return {
    id: r.id,
    courseId: r.course_id,
    title: r.title,
    position: r.position,
    problems: (r.course_problems ?? [])
      .slice()
      .sort((a, b) => a.position - b.position)
      .map(rowToProblemRef),
  };
}

function rowToProgress(r: ProgressRow): ProblemProgress {
  return {
    courseId: r.course_id,
    titleSlug: r.title_slug,
    failedAttempts: r.failed_attempts,
    completedAt: r.completed_at,
    points: r.points,
    execMs: r.exec_ms,
  };
}

const COURSE_COLUMNS = "id, name, description, join_code, start_date, end_date";

// ---------------------------------------------------------------------------
// Courses & membership
// ---------------------------------------------------------------------------

/**
 * The signed-in user's courses (with their role in each). App admins get
 * every course in the DB — RLS lets them read all of them — with unenrolled
 * ones surfaced as manageable (`myRole: 'admin'`, `enrolled: false`).
 */
export async function fetchMyCourses(
  userId: string,
  isAppAdmin: boolean,
): Promise<Course[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("course_members")
    .select(`role, courses (${COURSE_COLUMNS})`)
    .eq("user_id", userId);
  if (error) throw new Error(`Course list read failed: ${error.message}`);
  const mine = (data ?? [])
    .filter((r) => r.courses != null)
    .map((r) =>
      rowToCourse(r.courses as unknown as CourseRow, r.role as CourseRole, true),
    );

  if (isAppAdmin) {
    const { data: all, error: allError } = await client
      .from("courses")
      .select(COURSE_COLUMNS);
    if (allError) {
      throw new Error(`Course list read failed: ${allError.message}`);
    }
    const enrolledIds = new Set(mine.map((c) => c.id));
    for (const row of (all ?? []) as CourseRow[]) {
      if (!enrolledIds.has(row.id)) {
        mine.push(rowToCourse(row, "admin", false));
      }
    }
  }

  return mine.sort((a, b) => a.name.localeCompare(b.name));
}

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * One course with the signed-in user's role. Course URLs carry the short
 * join code (the shareable "Course ID"), so this accepts either that or the
 * internal uuid (old links keep working). Null when the user is neither a
 * member nor an app admin (RLS returns no row in that case anyway).
 */
export async function fetchCourse(
  codeOrId: string,
  userId: string,
  isAppAdmin: boolean,
): Promise<Course | null> {
  const client = requireClient();
  const key = codeOrId.trim();
  const { data: course, error } = await client
    .from("courses")
    .select(COURSE_COLUMNS)
    .eq(UUID_RE.test(key) ? "id" : "join_code", UUID_RE.test(key) ? key : key.toLowerCase())
    .maybeSingle();
  if (error) throw new Error(`Course read failed: ${error.message}`);
  if (!course) return null;
  const { data: member, error: memberError } = await client
    .from("course_members")
    .select("role")
    .eq("course_id", (course as CourseRow).id)
    .eq("user_id", userId)
    .maybeSingle();
  if (memberError) {
    throw new Error(`Membership read failed: ${memberError.message}`);
  }
  if (member) {
    return rowToCourse(course as CourseRow, member.role as CourseRole, true);
  }
  if (isAppAdmin) return rowToCourse(course as CourseRow, "admin", false);
  return null;
}

/** Create a course (app admins only; enforced by the RPC). */
export async function createCourse(input: {
  name: string;
  description?: string;
  startDate?: string | null;
  endDate?: string | null;
}): Promise<Course> {
  const client = requireClient();
  const { data, error } = await client.rpc("create_course", {
    p_name: input.name,
    p_description: input.description ?? "",
    p_start_date: input.startDate ?? null,
    p_end_date: input.endDate ?? null,
  });
  if (error) throw new Error(`Create course failed: ${error.message}`);
  return rowToCourse(data as CourseRow, "admin", true);
}

/** Update course settings (name / description / timeline). Course admin only. */
export async function updateCourse(
  courseId: string,
  patch: {
    name?: string;
    description?: string;
    startDate?: string | null;
    endDate?: string | null;
  },
): Promise<void> {
  const client = requireClient();
  const row: Record<string, unknown> = {};
  if (patch.name !== undefined) row.name = patch.name;
  if (patch.description !== undefined) row.description = patch.description;
  if (patch.startDate !== undefined) row.start_date = patch.startDate;
  if (patch.endDate !== undefined) row.end_date = patch.endDate;
  const { error } = await client.from("courses").update(row).eq("id", courseId);
  if (error) throw new Error(`Update course failed: ${error.message}`);
}

/** Join (or rejoin) a course by its join code. Returns the course id. */
export async function joinCourse(joinCode: string): Promise<string> {
  const client = requireClient();
  const { data, error } = await client.rpc("join_course", {
    p_join_code: joinCode.trim(),
  });
  if (error) throw new Error(`Join course failed: ${error.message}`);
  return data as string;
}

/** Leave a course. Progress rows are kept, so rejoining restores standing. */
export async function leaveCourse(
  courseId: string,
  userId: string,
): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_members")
    .delete()
    .eq("course_id", courseId)
    .eq("user_id", userId);
  if (error) throw new Error(`Leave course failed: ${error.message}`);
}

// ---------------------------------------------------------------------------
// Weeks & problems (course admin writes; member reads)
// ---------------------------------------------------------------------------

/** All weeks of a course with their ordered problems. */
export async function fetchWeeks(courseId: string): Promise<CourseWeek[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("course_weeks")
    .select("id, course_id, title, position, course_problems (id, week_id, title_slug, position)")
    .eq("course_id", courseId)
    .order("position");
  if (error) throw new Error(`Weeks read failed: ${error.message}`);
  return ((data ?? []) as unknown as CourseWeekRow[]).map(rowToWeek);
}

export async function createWeek(
  courseId: string,
  title: string,
  position: number,
): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_weeks")
    .insert({ course_id: courseId, title, position });
  if (error) throw new Error(`Create week failed: ${error.message}`);
}

export async function renameWeek(weekId: string, title: string): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_weeks")
    .update({ title })
    .eq("id", weekId);
  if (error) throw new Error(`Rename week failed: ${error.message}`);
}

export async function deleteWeek(weekId: string): Promise<void> {
  const client = requireClient();
  const { error } = await client.from("course_weeks").delete().eq("id", weekId);
  if (error) throw new Error(`Delete week failed: ${error.message}`);
}

export async function addProblemToWeek(
  weekId: string,
  titleSlug: string,
  position: number,
): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_problems")
    .insert({ week_id: weekId, title_slug: titleSlug, position });
  if (error) throw new Error(`Add problem failed: ${error.message}`);
}

export async function removeProblemFromWeek(problemId: string): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_problems")
    .delete()
    .eq("id", problemId);
  if (error) throw new Error(`Remove problem failed: ${error.message}`);
}

/** Persist a week's problem order (positions rewritten 0..n-1). */
export async function reorderWeekProblems(
  orderedProblemIds: string[],
): Promise<void> {
  const client = requireClient();
  const results = await Promise.all(
    orderedProblemIds.map((id, position) =>
      client.from("course_problems").update({ position }).eq("id", id),
    ),
  );
  const failed = results.find((r) => r.error);
  if (failed?.error) {
    throw new Error(`Reorder failed: ${failed.error.message}`);
  }
}

// ---------------------------------------------------------------------------
// Members & invites (course admin)
// ---------------------------------------------------------------------------

export async function fetchMembers(courseId: string): Promise<CourseMember[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("course_members")
    .select("course_id, user_id, role, profiles (display_name)")
    .eq("course_id", courseId);
  if (error) throw new Error(`Members read failed: ${error.message}`);
  return (data ?? [])
    .map((r) => ({
      courseId: r.course_id as string,
      userId: r.user_id as string,
      role: r.role as CourseRole,
      displayName:
        ((r.profiles as unknown as { display_name: string } | null)
          ?.display_name as string) || "Unknown",
    }))
    .sort((a, b) => a.displayName.localeCompare(b.displayName));
}

export async function removeMember(
  courseId: string,
  userId: string,
): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_members")
    .delete()
    .eq("course_id", courseId)
    .eq("user_id", userId);
  if (error) throw new Error(`Remove member failed: ${error.message}`);
}

export async function setMemberRole(
  courseId: string,
  userId: string,
  role: CourseRole,
): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_members")
    .update({ role })
    .eq("course_id", courseId)
    .eq("user_id", userId);
  if (error) throw new Error(`Change role failed: ${error.message}`);
}

export async function fetchInvites(courseId: string): Promise<CourseInvite[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("course_invites")
    .select("id, course_id, email, role, redeemed_at")
    .eq("course_id", courseId)
    .order("created_at", { ascending: false });
  if (error) throw new Error(`Invites read failed: ${error.message}`);
  return (data ?? []).map((r) => ({
    id: r.id as string,
    courseId: r.course_id as string,
    email: r.email as string,
    role: r.role as CourseRole,
    redeemedAt: r.redeemed_at as string | null,
  }));
}

export async function createInvite(
  courseId: string,
  email: string,
  role: CourseRole,
): Promise<void> {
  const client = requireClient();
  const { error } = await client.from("course_invites").insert({
    course_id: courseId,
    email: email.trim().toLowerCase(),
    role,
  });
  if (error) throw new Error(`Invite failed: ${error.message}`);
}

export async function revokeInvite(inviteId: string): Promise<void> {
  const client = requireClient();
  const { error } = await client
    .from("course_invites")
    .delete()
    .eq("id", inviteId);
  if (error) throw new Error(`Revoke invite failed: ${error.message}`);
}

// ---------------------------------------------------------------------------
// Progress & leaderboard
// ---------------------------------------------------------------------------

/** The signed-in user's progress rows for one course. */
export async function fetchMyProgress(
  courseId: string,
  userId: string,
): Promise<ProblemProgress[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("problem_progress")
    .select("course_id, title_slug, failed_attempts, completed_at, points, exec_ms")
    .eq("course_id", courseId)
    .eq("user_id", userId);
  if (error) throw new Error(`Progress read failed: ${error.message}`);
  return ((data ?? []) as ProgressRow[]).map(rowToProgress);
}

/**
 * Report a finished run for scoring. The RPC (security definer) checks
 * membership + course content + the course timeline, counts failed attempts,
 * and computes/freezes points on the first passing run — the formula lives
 * server-side only. Returns the resulting progress row.
 */
export async function recordRun(
  courseId: string,
  titleSlug: string,
  passed: boolean,
  execMs: number | null,
): Promise<ProblemProgress> {
  const client = requireClient();
  const { data, error } = await client.rpc("record_run", {
    p_course_id: courseId,
    p_slug: titleSlug,
    p_passed: passed,
    p_exec_ms: execMs,
  });
  if (error) throw new Error(`Record run failed: ${error.message}`);
  return rowToProgress(data as ProgressRow);
}

/** Ranked standings for one course (member-only via RLS on the view). */
export async function fetchLeaderboard(
  courseId: string,
): Promise<LeaderboardEntry[]> {
  const client = requireClient();
  const { data, error } = await client
    .from("course_leaderboard")
    .select("user_id, display_name, points, solved")
    .eq("course_id", courseId)
    .order("points", { ascending: false })
    .order("solved", { ascending: false });
  if (error) throw new Error(`Leaderboard read failed: ${error.message}`);
  return (data ?? []).map((r) => ({
    userId: r.user_id as string,
    displayName: (r.display_name as string) || "Unknown",
    points: (r.points as number) ?? 0,
    solved: (r.solved as number) ?? 0,
  }));
}
