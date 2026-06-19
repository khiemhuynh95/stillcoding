import type {
  GlobalStats,
  PaginatedProblems,
  ProblemDetail,
  ProblemDetailRaw,
  ProblemStats,
  ProblemSummary,
  Tag,
} from "./types";
import {
  fetchProblemFromDb,
  fetchProblemsByTagFromDb,
  fetchProblemsFromDb,
  fetchTagsFromDb,
  supabaseEnabled,
} from "./supabase";

const BASE_URL =
  process.env.NEXT_PUBLIC_LEETCODE_API_BASE?.replace(/\/$/, "") ||
  "https://leetcode-api-pied.vercel.app";

async function apiFetch<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(`${BASE_URL}${path}`, {
    ...init,
    headers: { Accept: "application/json", ...(init?.headers ?? {}) },
  });
  if (!res.ok) {
    throw new Error(`LeetCode API ${path} failed: ${res.status} ${res.statusText}`);
  }
  return res.json() as Promise<T>;
}

/** Parse the detail endpoint's `stats` JSON string; tolerant of malformed data. */
export function parseStats(raw: string | null | undefined): ProblemStats | null {
  if (!raw) return null;
  try {
    return JSON.parse(raw) as ProblemStats;
  } catch {
    return null;
  }
}

/**
 * All problems. Reads from the persisted Supabase table (kept fresh by the daily
 * sync) when configured, falling back to the live GET /problems when Supabase is
 * absent or empty. Custom problems are `source='custom'` rows in the same table,
 * so they come through here like any other (they're absent in keyless dev).
 */
export async function getProblems(): Promise<ProblemSummary[]> {
  if (supabaseEnabled) {
    try {
      const rows = await fetchProblemsFromDb();
      if (rows && rows.length) return rows;
    } catch (err) {
      // Fall through to the live API if the DB read fails.
      console.error("Supabase problems read failed, falling back to API:", err);
    }
  }
  return apiFetch<ProblemSummary[]>("/problems");
}

/**
 * GET /problems/tag/{slug} — paginated. Pages through `skip` until the full
 * set is assembled so the UI can filter/sort/paginate client-side like the
 * main list.
 */
export async function getProblemsByTag(slug: string): Promise<ProblemSummary[]> {
  if (supabaseEnabled) {
    try {
      const rows = await fetchProblemsByTagFromDb(slug);
      // Empty can mean detail isn't backfilled yet, so fall through to the API.
      if (rows && rows.length) return rows;
    } catch (err) {
      console.error("Supabase tag read failed, falling back to API:", err);
    }
  }
  const limit = 100;
  const all: ProblemSummary[] = [];
  let skip = 0;
  // Guard against runaway loops if `total` is ever missing/wrong.
  for (let page = 0; page < 100; page += 1) {
    const data = await apiFetch<PaginatedProblems>(
      `/problems/tag/${encodeURIComponent(slug)}?limit=${limit}&skip=${skip}`,
    );
    all.push(...data.problems);
    skip += data.problems.length;
    if (!data.problems.length || skip >= data.total) break;
  }
  return all;
}

/** GET /problem/{id_or_slug} — full detail, with stats parsed and slug attached. */
export async function getProblem(slugOrId: string): Promise<ProblemDetail> {
  if (supabaseEnabled) {
    try {
      const row = await fetchProblemFromDb(slugOrId);
      if (row) return row;
    } catch (err) {
      console.error("Supabase problem read failed, falling back to API:", err);
    }
  }
  const raw = await apiFetch<ProblemDetailRaw>(
    `/problem/${encodeURIComponent(slugOrId)}`,
  );
  return {
    ...raw,
    titleSlug: slugFromUrl(raw.url) ?? slugOrId,
    parsedStats: parseStats(raw.stats),
  };
}

/** Topic tags with problem counts. DB first, API fallback. */
export async function getTags(): Promise<Tag[]> {
  if (supabaseEnabled) {
    try {
      const rows = await fetchTagsFromDb();
      if (rows && rows.length) return rows;
    } catch (err) {
      console.error("Supabase tags read failed, falling back to API:", err);
    }
  }
  return apiFetch<Tag[]>("/tags");
}

/** GET /random — a single random problem (optionally filtered by difficulty). */
export function getRandomProblem(difficulty?: string): Promise<ProblemSummary> {
  const qs = difficulty ? `?difficulty=${encodeURIComponent(difficulty)}` : "";
  return apiFetch<ProblemSummary>(`/random${qs}`);
}

/** GET /stats — global problem statistics. */
export function getStats(): Promise<GlobalStats> {
  return apiFetch<GlobalStats>("/stats");
}

/** Extract the `two-sum` slug from a canonical LeetCode problem URL. */
function slugFromUrl(url: string): string | null {
  const match = url.match(/problems\/([^/]+)/);
  return match ? match[1] : null;
}
