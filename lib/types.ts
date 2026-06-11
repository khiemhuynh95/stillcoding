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
