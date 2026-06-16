import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import type {
  ProblemDetail,
  ProblemStats,
  ProblemSummary,
  Tag,
  TopicTag,
} from "./types";

/**
 * Read-only Supabase access for the persisted `problems` table. The daily sync
 * (supabase/functions/sync-problems) keeps the table fresh; the app reads from
 * it so the browse list and problem pages don't depend on the live API being
 * up. When the env vars are absent (e.g. a fresh local checkout) the client is
 * null and lib/leetcode.ts falls back to the live API.
 */
const URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
// Accept either the new-style publishable key (sb_publishable_…) or the legacy
// anon JWT — both act as the `anon` role for RLS.
const ANON_KEY =
  process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ||
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

let client: SupabaseClient | null = null;
if (URL && ANON_KEY) {
  client = createClient(URL, ANON_KEY, { auth: { persistSession: false } });
}

export const supabaseEnabled = client != null;

/**
 * The shared Supabase client (or null when env vars are unset). Catalog reads
 * go through the helpers below; the collaboration layer (lib/collab.ts) reuses
 * this same client for its scoped writes and Realtime channels so the app keeps
 * a single connection.
 */
export const supabaseClient = client;

/** Shape of a row in public.problems (snake_case columns). */
interface ProblemRow {
  id: string;
  frontend_id: string;
  title: string;
  title_slug: string;
  url: string;
  difficulty: ProblemSummary["difficulty"];
  paid_only: boolean;
  has_solution: boolean;
  has_video_solution: boolean;
  source: "leetcode" | "custom";
  question_id: string | null;
  content: string | null;
  likes: number | null;
  dislikes: number | null;
  stats: ProblemStats | null;
  similar_questions: unknown;
  category_title: string | null;
  hints: string[] | null;
  topic_tags: TopicTag[] | null;
  company_tags: TopicTag[] | null;
  solution_content: string | null;
  solution_can_see_detail: boolean | null;
  detail_synced_at: string | null;
  display_title: string | null;
  display_content: string | null;
  starter_code: Record<string, string> | null;
}

const SUMMARY_COLUMNS =
  "id, frontend_id, title, display_title, title_slug, url, difficulty, paid_only, has_solution, has_video_solution, source";

function rowToSummary(r: ProblemRow): ProblemSummary {
  return {
    id: r.id,
    frontend_id: r.frontend_id,
    title: r.display_title ?? r.title,
    title_slug: r.title_slug,
    url: r.url,
    difficulty: r.difficulty,
    paid_only: r.paid_only,
    has_solution: r.has_solution,
    has_video_solution: r.has_video_solution,
    source: r.source,
  };
}

function rowToDetail(r: ProblemRow): ProblemDetail {
  return {
    questionId: r.question_id ?? r.id,
    questionFrontendId: r.frontend_id,
    title: r.display_title ?? r.title,
    content: r.display_content ?? r.content,
    likes: r.likes ?? 0,
    dislikes: r.dislikes ?? 0,
    stats: r.stats ? JSON.stringify(r.stats) : "",
    similarQuestions: r.similar_questions ? JSON.stringify(r.similar_questions) : "",
    categoryTitle: r.category_title ?? "",
    hints: r.hints ?? [],
    topicTags: r.topic_tags ?? [],
    companyTags: r.company_tags,
    difficulty: r.difficulty,
    isPaidOnly: r.paid_only,
    solution:
      r.solution_can_see_detail == null && r.solution_content == null
        ? null
        : {
            canSeeDetail: r.solution_can_see_detail ?? false,
            content: r.solution_content,
          },
    hasSolution: r.has_solution,
    hasVideoSolution: r.has_video_solution,
    url: r.url,
    titleSlug: r.title_slug,
    parsedStats: r.stats ?? null,
    source: r.source,
    starterCode: r.starter_code ?? undefined,
  };
}

/** All persisted problems as list-row summaries (sorted newest-id first). */
export async function fetchProblemsFromDb(): Promise<ProblemSummary[] | null> {
  if (!client) return null;
  const all: ProblemSummary[] = [];
  const pageSize = 1000;
  for (let from = 0; ; from += pageSize) {
    const { data, error } = await client
      .from("problems")
      .select(SUMMARY_COLUMNS)
      .range(from, from + pageSize - 1);
    if (error) throw new Error(`Supabase problems read failed: ${error.message}`);
    if (!data?.length) break;
    all.push(...(data as ProblemRow[]).map(rowToSummary));
    if (data.length < pageSize) break;
  }
  return all;
}

/**
 * A single persisted problem's full detail by slug or numeric frontend id.
 * Returns null when not configured or not found (caller falls back to the API).
 */
export async function fetchProblemFromDb(
  slugOrId: string,
): Promise<ProblemDetail | null> {
  if (!client) return null;
  const { data, error } = await client
    .from("problems")
    .select("*")
    .or(`title_slug.eq.${slugOrId},frontend_id.eq.${slugOrId}`)
    .limit(1)
    .maybeSingle();
  if (error) throw new Error(`Supabase problem read failed: ${error.message}`);
  if (!data) return null;
  const row = data as ProblemRow;
  // Detail not fetched yet for this row — let the caller hit the live API.
  if (!row.detail_synced_at) return null;
  return rowToDetail(row);
}

/**
 * Persisted problems carrying a given topic tag (by slug). Filters the
 * `topic_tags` jsonb by containment, so a problem only matches once its detail
 * has been synced. Returns null when not configured; an empty array means
 * nothing matched (caller may fall back to the API).
 */
export async function fetchProblemsByTagFromDb(
  tagSlug: string,
): Promise<ProblemSummary[] | null> {
  if (!client) return null;
  const all: ProblemSummary[] = [];
  const pageSize = 1000;
  for (let from = 0; ; from += pageSize) {
    const { data, error } = await client
      .from("problems")
      .select(SUMMARY_COLUMNS)
      // jsonb containment: pass a JSON *string*, else supabase-js encodes the
      // array as a Postgres array literal ("{[object Object]}") and PostgREST
      // rejects it as invalid json.
      .contains("topic_tags", JSON.stringify([{ slug: tagSlug }]))
      .range(from, from + pageSize - 1);
    if (error) throw new Error(`Supabase tag read failed: ${error.message}`);
    if (!data?.length) break;
    all.push(...(data as ProblemRow[]).map(rowToSummary));
    if (data.length < pageSize) break;
  }
  return all;
}

/** Persisted topic tags (name, slug, problem_count). Null when not configured. */
export async function fetchTagsFromDb(): Promise<Tag[] | null> {
  if (!client) return null;
  const { data, error } = await client
    .from("tags")
    .select("slug, name, problem_count");
  if (error) throw new Error(`Supabase tags read failed: ${error.message}`);
  if (!data) return null;
  return data.map((t) => ({
    slug: t.slug as string,
    name: t.name as string,
    problem_count: (t.problem_count as number) ?? 0,
  }));
}
