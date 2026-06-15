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
- **Non-traditional problems** — added the first build & debug exercise
  ("Cloud Gaming — Membership & Billing", custom `C3`) and a new
  `beyond-leetcode` preset list to hold this style of problem (class
  design / simulation, not single-function puzzles).
- **In-browser Python runner (Pyodide)** — Run button + output console
  on the coding screen, Python-only. CPython runs client-side in a Web
  Worker (`public/pyodide-worker.js`, Pyodide loaded lazily from the
  jsdelivr CDN on first run); `hooks/useRunPython.ts` drives it with a
  fresh-worker-per-run model (terminate = cancel/timeout; 15s execution
  cap, runtime download uncapped). `components/coding/OutputConsole.tsx`
  streams stdout/stderr. The worker execs user code into the real
  `__main__` dict so a trailing `unittest.main()` works. **Run just
  executes the editor buffer — there is no separate grader.** Users
  write and run their own test cases directly in the code; the custom
  problems (C1/C2/C3) ship example `unittest` blocks inline in
  `starterCode.python3` as a starting point. Other languages stay
  editor-only.

## Next Up

- Continue roadmap / practice topic coverage.
- Continue problem rewording batches.

## Open Questions

- None blocking. Future extension points (not committed): multi-language
  execution (server-side Judge0/Piston — Python already runs in-browser
  via Pyodide), user accounts + cross-device sync, graduating custom
  problems to Supabase.

## Architecture Decisions

- **localStorage for all user state** — keeps v1 backendless and
  matches the device-local model (drafts + filter cache).
- **Supabase persists the catalog (2026-06-12)** — reversed the
  original "no Supabase" call for a faster, stable catalog; kept the
  live-API fallback so the app still runs keyless.
- **In-browser runner via Pyodide (2026-06-14)** — partially reverses
  "editor-only". Python runs client-side in WASM (no backend, sandboxed
  by construction), which fits the device-local model better than the
  server-side Judge0/Piston option originally assumed. Python-only for
  now; other languages remain editor-only pending a server runner.
- **Fast browse table** — omits acceptance rate + tags (not in the
  list endpoint).
- **Fetch detail by `title_slug`, not numeric id** — the API
  mis-resolves bare numbers as frontend ids and returns the wrong
  problem; "has detail" = `detail_synced_at != null`.
- **React 18.3 over 19** — clean Monaco / panels peer deps.

## Session Notes

- Context files live in `context/` (matching CLAUDE.md's documented
  read order).
- Supabase project: ref `npliviizqlndlyctvhgo` ("still-coding",
  us-east-2). Setup steps in `supabase/README.md`. The Deno function
  is excluded from the Next.js typecheck via tsconfig.
- See auto-memory: `devstudio-pro-decisions`, `leetcode-api-quirks`,
  `supabase-problem-sync` for the deeper rationale and gotchas.
