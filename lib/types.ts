export type Difficulty = "Easy" | "Medium" | "Hard";

/** Item shape from GET /problems, /problems/tag/{slug}, /random. */
export interface ProblemSummary {
  id: string;
  frontend_id: string;
  title: string;
  title_slug: string;
  url: string;
  difficulty: Difficulty;
  paid_only: boolean;
  has_solution?: boolean;
  has_video_solution?: boolean;
  /** Origin of the problem; absent/"leetcode" = from the API. */
  source?: "leetcode" | "custom";
}

/** Wrapper shape from paginated endpoints (/problems/tag, /problems/filter). */
export interface PaginatedProblems {
  total: number;
  limit: number;
  skip: number;
  problems: ProblemSummary[];
  tag?: string;
}

export interface TopicTag {
  name: string;
  slug?: string;
}

/** Parsed form of the detail endpoint's `stats` JSON string. */
export interface ProblemStats {
  totalAccepted: string;
  totalSubmission: string;
  totalAcceptedRaw: number;
  totalSubmissionRaw: number;
  acRate: string;
}

/** Raw item from GET /problem/{id_or_slug} (camelCase). */
export interface ProblemDetailRaw {
  questionId: string;
  questionFrontendId: string;
  title: string;
  content: string | null;
  likes: number;
  dislikes: number;
  stats: string;
  similarQuestions: string;
  categoryTitle: string;
  hints: string[];
  topicTags: TopicTag[];
  companyTags: TopicTag[] | null;
  difficulty: Difficulty;
  isPaidOnly: boolean;
  solution: { canSeeDetail: boolean; content: string | null } | null;
  hasSolution: boolean;
  hasVideoSolution?: boolean;
  url: string;
}

/** Detail normalized for the UI (stats parsed, slug derived). */
export interface ProblemDetail extends ProblemDetailRaw {
  titleSlug: string;
  parsedStats: ProblemStats | null;
  source?: "leetcode" | "custom";
  /** Per-language starter code (custom problems only; API has none). */
  starterCode?: Record<string, string>;
}

export interface Tag {
  name: string;
  slug: string;
  problem_count: number;
}

export interface GlobalStats {
  total: number;
  by_difficulty: { easy: number; medium: number; hard: number };
  by_access: { free: number; paid: number };
  with_solution: number;
  with_video_solution: number;
}

// ---------------------------------------------------------------------------
// Course feature (hidden beta) — normalized UI shapes. Snake_case DB rows are
// mapped to these at the boundary in lib/course.ts.
// ---------------------------------------------------------------------------

export type CourseRole = "admin" | "member";

/** One row per auth user (public.profiles). */
export interface Profile {
  id: string;
  displayName: string;
  /** Global flag: may create courses. Set manually in the Supabase dashboard. */
  isAdmin: boolean;
}

export interface Course {
  id: string;
  name: string;
  description: string;
  /** Human-shareable join code (the "course id" users type to enroll). */
  joinCode: string;
  /** Course timeline (ISO dates, null = unbounded). Points only count inside it. */
  startDate: string | null;
  endDate: string | null;
  /** The signed-in user's role in this course (app admins are 'admin' everywhere). */
  myRole: CourseRole;
  /**
   * True when the user has an actual course_members row. App admins can see
   * and manage every course, but only enrolled users earn points / appear on
   * the leaderboard / can leave.
   */
  enrolled: boolean;
}

export interface CourseProblemRef {
  id: string;
  weekId: string;
  titleSlug: string;
  position: number;
}

export interface CourseWeek {
  id: string;
  courseId: string;
  title: string;
  position: number;
  /** Markdown study material ('' = none; link hidden in the member view). */
  material: string;
  /** Ordered problems, parallel to ProblemList.slugs. */
  problems: CourseProblemRef[];
}

export interface CourseMember {
  courseId: string;
  userId: string;
  role: CourseRole;
  displayName: string;
}

export interface CourseInvite {
  id: string;
  courseId: string;
  email: string;
  role: CourseRole;
  redeemedAt: string | null;
}

/**
 * Per (user, course, problem) progress; score frozen at the first successful
 * submission (`completedAt` is its timestamp). Runs are free metrics; only
 * failed submits penalize.
 */
export interface ProblemProgress {
  courseId: string;
  titleSlug: string;
  failedSubmits: number;
  runCount: number;
  submitCount: number;
  completedAt: string | null;
  points: number | null;
}

export interface LeaderboardEntry {
  userId: string;
  displayName: string;
  points: number;
  solved: number;
}
