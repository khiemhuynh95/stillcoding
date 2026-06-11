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
  customMatchingTag,
  customSummaries,
  customToDetail,
  findCustomBySlug,
  mergeTagCounts,
} from "./customProblems";

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

/** GET /problems — all problems, with custom problems merged in first. */
export async function getProblems(): Promise<ProblemSummary[]> {
  const api = await apiFetch<ProblemSummary[]>("/problems");
  return [...customSummaries(), ...api];
}

/**
 * GET /problems/tag/{slug} — paginated. Pages through `skip` until the full
 * set is assembled so the UI can filter/sort/paginate client-side like the
 * main list.
 */
export async function getProblemsByTag(slug: string): Promise<ProblemSummary[]> {
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
  return [...customMatchingTag(slug), ...all];
}

/** GET /problem/{id_or_slug} — full detail, with stats parsed and slug attached. */
export async function getProblem(slugOrId: string): Promise<ProblemDetail> {
  const custom = findCustomBySlug(slugOrId);
  if (custom) return customToDetail(custom);
  const raw = await apiFetch<ProblemDetailRaw>(
    `/problem/${encodeURIComponent(slugOrId)}`,
  );
  return {
    ...raw,
    titleSlug: slugFromUrl(raw.url) ?? slugOrId,
    parsedStats: parseStats(raw.stats),
  };
}

/** GET /tags — topic tags with problem counts (custom tags folded in). */
export async function getTags(): Promise<Tag[]> {
  const api = await apiFetch<Tag[]>("/tags");
  return mergeTagCounts(api);
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
