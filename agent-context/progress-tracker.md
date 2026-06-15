# Progress Tracker

Update this file after every meaningful implementation change.

## Current Phase

- Shipped v1 / Vercel deploy-ready. Iterating on content and polish.

## Current Goal

- Polish and content expansion (problem rewording, roadmap/practice
  coverage), not new architecture.

## Completed

- **Core app** — browse (client-side filter/search/sort/pagination),
  coding screen (resizable Monaco split + sanitized description),
  6-language support with generic starter scaffolds.
- **Local user state** — filters (filter cache), solved/attempted
  status, per-(problem,language) autosaved drafts, theme; all in
  localStorage via `lib/storage.ts`.
- **Custom problems** — version-controlled merge layer
  (`lib/customProblems.ts` + `lib/leetcode.ts`), source-agnostic UI.
- **Supabase catalog** — `problems`/`tags`/`sync_runs` tables, RLS
  read-only, daily pg_cron → Edge Function sync; all four read paths
  serve from DB with live-API fallback. Backfilled (~3958 problems +
  72 tags, slug-keyed detail).
- **Problem lists** — preset (in-code) + user (localStorage) lists,
  sidebar Lists section, Save-to-list popover, order-preserving list
  browse.
- **Roadmap** — curated branching graph (`/roadmap`), progress from
  solved status.
- **Practice** — per-topic syntax cheat sheets (`/practice/[topic]`).
- **Deploy** — Vercel-ready; practice mode + brown noise; analytics;
  prefetch-on-hover + optimized font loading.

## In Progress

- Rewording batches of problem statements (ongoing content pass).

## Next Up

- Continue roadmap / practice topic coverage.
- Continue problem rewording batches.

## Open Questions

- None blocking. Future extension points (not committed): code
  runner (Judge0/Piston), user accounts + cross-device sync,
  graduating custom problems to Supabase.

## Architecture Decisions

- **localStorage for all user state** — keeps v1 backendless and
  matches the device-local model (drafts + filter cache).
- **Supabase persists the catalog (2026-06-12)** — reversed the
  original "no Supabase" call for a faster, stable catalog; kept the
  live-API fallback so the app still runs keyless.
- **Editor-only, no runner** — the API can't execute code.
- **Fast browse table** — omits acceptance rate + tags (not in the
  list endpoint).
- **Fetch detail by `title_slug`, not numeric id** — the API
  mis-resolves bare numbers as frontend ids and returns the wrong
  problem; "has detail" = `detail_synced_at != null`.
- **React 18.3 over 19** — clean Monaco / panels peer deps.

## Session Notes

- `CLAUDE.md` references these files as `context/…`, but they live in
  `agent-context/`. Read order is unchanged.
- Supabase project: ref `npliviizqlndlyctvhgo` ("still-coding",
  us-east-2). Setup steps in `supabase/README.md`. The Deno function
  is excluded from the Next.js typecheck via tsconfig.
- See auto-memory: `devstudio-pro-decisions`, `leetcode-api-quirks`,
  `supabase-problem-sync` for the deeper rationale and gotchas.
