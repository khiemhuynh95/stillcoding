// Supabase Edge Function: sync-problems
//
// Fetches the LeetCode list (/problems), diffs it against the `problems` table,
// then inserts new problems and updates changed ones. For new/changed problems
// (and any still missing detail) it also fetches /problem/{id} to persist
// content, stats, tags and the solution field.
//
// Invoked daily by pg_cron (see migrations/0002_cron.sql). Can also be called
// manually to backfill detail in batches via the `limit` query param.
//
// Env (set with `supabase secrets set`):
//   SUPABASE_URL                 - injected automatically
//   SUPABASE_SERVICE_ROLE_KEY    - injected automatically (bypasses RLS)
//   LEETCODE_API_BASE            - e.g. https://leetcode-api-pied.vercel.app
//
// Query params:
//   ?limit=N   - cap detail fetches this run (default 400). Remaining problems
//                are picked up on the next run. Use ?limit=2000 to force a full
//                backfill in one shot.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const LEETCODE_API_BASE =
  (Deno.env.get("LEETCODE_API_BASE") ?? "https://leetcode-api-pied.vercel.app")
    .replace(/\/$/, "");

interface ListItem {
  id: string;
  frontend_id: string;
  title: string;
  title_slug: string;
  url: string;
  difficulty: string;
  paid_only: boolean;
  has_solution?: boolean;
  has_video_solution?: boolean;
}

/** Fields that, when changed upstream, mean a row needs re-syncing. */
function listHashInput(p: ListItem): string {
  return JSON.stringify([
    p.frontend_id,
    p.title,
    p.title_slug,
    p.url,
    p.difficulty,
    p.paid_only,
    p.has_solution ?? false,
    p.has_video_solution ?? false,
  ]);
}

async function sha256(text: string): Promise<string> {
  const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return Array.from(new Uint8Array(buf))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

function safeJsonParse<T>(raw: unknown): T | null {
  if (typeof raw !== "string" || !raw) return null;
  try {
    return JSON.parse(raw) as T;
  } catch {
    return null;
  }
}

function slugify(text: string): string {
  return text.toLowerCase().trim().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
}

/** Run `worker` over `items` with at most `concurrency` in flight. */
async function pool<T>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<void>,
): Promise<void> {
  let i = 0;
  const runners = Array.from({ length: Math.min(concurrency, items.length) }, async () => {
    while (i < items.length) {
      const idx = i++;
      await worker(items[idx]);
    }
  });
  await Promise.all(runners);
}

Deno.serve(async (req) => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const url = new URL(req.url);
  const detailLimit = Number(url.searchParams.get("limit") ?? "400") || 400;

  // Open a run-log row up front so a crash still leaves a trace.
  const { data: run } = await supabase
    .from("sync_runs")
    .insert({})
    .select("id")
    .single();
  const runId = run?.id as number | undefined;

  const finish = async (
    payload: {
      inserted: number;
      updated: number;
      detail_fetched: number;
      total_seen: number;
      ok: boolean;
      error?: string;
    },
  ) => {
    if (runId != null) {
      await supabase
        .from("sync_runs")
        .update({ ...payload, finished_at: new Date().toISOString() })
        .eq("id", runId);
    }
    return new Response(JSON.stringify(payload), {
      status: payload.ok ? 200 : 500,
      headers: { "content-type": "application/json" },
    });
  };

  try {
    // 1. Pull the full upstream list.
    const listRes = await fetch(`${LEETCODE_API_BASE}/problems`, {
      headers: { Accept: "application/json" },
    });
    if (!listRes.ok) throw new Error(`GET /problems ${listRes.status}`);
    const list = (await listRes.json()) as ListItem[];

    // 2. Load what we already have (id, hash, whether detail has been synced).
    //    Use detail_synced_at (not content) as the "has detail" signal: paid
    //    problems legitimately have null content, so keying off content would
    //    re-fetch them on every run forever.
    const existing = new Map<string, { hash: string | null; hasDetail: boolean }>();
    const pageSize = 1000;
    for (let from = 0; ; from += pageSize) {
      const { data, error } = await supabase
        .from("problems")
        .select("id, list_hash, detail_synced_at")
        .range(from, from + pageSize - 1);
      if (error) throw error;
      if (!data?.length) break;
      for (const row of data) {
        existing.set(row.id as string, {
          hash: (row.list_hash as string | null) ?? null,
          hasDetail: row.detail_synced_at != null,
        });
      }
      if (data.length < pageSize) break;
    }

    // 3. Diff: which rows are new / changed, and which need detail fetched.
    const listRows: Record<string, unknown>[] = [];
    const needDetail: ListItem[] = [];
    let inserted = 0;
    let updated = 0;

    for (const p of list) {
      const hash = await sha256(listHashInput(p));
      const prev = existing.get(p.id);
      const isNew = !prev;
      const changed = prev != null && prev.hash !== hash;

      if (isNew) inserted++;
      else if (changed) updated++;

      listRows.push({
        id: p.id,
        frontend_id: p.frontend_id,
        title: p.title,
        title_slug: p.title_slug,
        url: p.url ?? "",
        difficulty: p.difficulty,
        paid_only: p.paid_only ?? false,
        has_solution: p.has_solution ?? false,
        has_video_solution: p.has_video_solution ?? false,
        source: "leetcode",
        list_hash: hash,
      });

      if (isNew || changed || !prev?.hasDetail) needDetail.push(p);
    }

    // 4. Upsert list fields for everything (only the provided columns change on
    //    conflict, so existing detail is preserved).
    if (listRows.length) {
      for (let from = 0; from < listRows.length; from += 500) {
        const { error } = await supabase
          .from("problems")
          .upsert(listRows.slice(from, from + 500), { onConflict: "id" });
        if (error) throw error;
      }
    }

    // 5. Fetch + upsert detail for the rows that need it (capped per run).
    const detailTargets = needDetail.slice(0, detailLimit);
    let detailFetched = 0;
    await pool(detailTargets, 8, async (p) => {
      try {
        // Fetch by slug, not id: the numeric questionId 404s for many newer
        // problems, whereas the slug always resolves.
        const res = await fetch(
          `${LEETCODE_API_BASE}/problem/${encodeURIComponent(p.title_slug)}`,
          { headers: { Accept: "application/json" } },
        );
        if (!res.ok) return;
        const d = await res.json();
        const topicTags = Array.isArray(d.topicTags)
          ? d.topicTags.map((t: { name: string; slug?: string }) => ({
              name: t.name,
              slug: t.slug ?? slugify(t.name),
            }))
          : null;
        const { error } = await supabase
          .from("problems")
          .update({
            question_id: d.questionId ?? null,
            content: d.content ?? null,
            likes: d.likes ?? null,
            dislikes: d.dislikes ?? null,
            stats: safeJsonParse(d.stats),
            similar_questions: safeJsonParse(d.similarQuestions),
            category_title: d.categoryTitle ?? null,
            hints: Array.isArray(d.hints) ? d.hints : null,
            topic_tags: topicTags,
            company_tags: Array.isArray(d.companyTags) ? d.companyTags : null,
            solution_content: d.solution?.content ?? null,
            solution_can_see_detail: d.solution?.canSeeDetail ?? null,
            detail_synced_at: new Date().toISOString(),
          })
          .eq("id", p.id);
        if (!error) detailFetched++;
      } catch {
        // Skip this problem; it'll be retried next run.
      }
    });

    // 6. Sync the topic tag list (cheap, one call). Non-fatal on failure.
    try {
      const tagsRes = await fetch(`${LEETCODE_API_BASE}/tags`, {
        headers: { Accept: "application/json" },
      });
      if (tagsRes.ok) {
        const tags = (await tagsRes.json()) as {
          name: string;
          slug: string;
          problem_count: number;
        }[];
        const tagRows = tags
          .filter((t) => t.slug)
          .map((t) => ({
            slug: t.slug,
            name: t.name,
            problem_count: t.problem_count ?? 0,
          }));
        if (tagRows.length) {
          await supabase.from("tags").upsert(tagRows, { onConflict: "slug" });
        }
      }
    } catch (err) {
      console.error("tag sync failed (non-fatal):", err);
    }

    return await finish({
      inserted,
      updated,
      detail_fetched: detailFetched,
      total_seen: list.length,
      ok: true,
    });
  } catch (err) {
    return await finish({
      inserted: 0,
      updated: 0,
      detail_fetched: 0,
      total_seen: 0,
      ok: false,
      error: err instanceof Error ? err.message : String(err),
    });
  }
});
