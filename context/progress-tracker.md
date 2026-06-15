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
- **Collaboration (real-time co-editing)** — shippable, built across 3
  increments: (1) `collab_sessions` table + scoped RLS (anon
  insert/select/update) + size cap + daily retention sweep (delete
  sessions idle 30 days by `updated_at`) cron
  (`20260615000001_collab_sessions.sql`) and `lib/collab.ts` session
  CRUD; (2) Yjs CRDT + a Supabase Realtime **Broadcast** provider
  (`SupabaseYjsProvider`) + `hooks/useCollabSession.ts` (snapshot
  load/debounced save, presence, ephemeral name+color identity); (3) a
  custom Monaco⇄Yjs binding (`lib/monacoYjsBinding.ts` — written by
  hand so it drives the *CDN-loaded* Monaco instead of bundling
  y-monaco's own `monaco-editor` copy), `ShareButton` (start session /
  copy link / presence / rename / leave), `?session=` page wiring
  (collab mode bypasses localStorage autosave, locks language, hides
  Reset), and remote cursors/selections via injected per-client CSS.
  `npm run build` + `tsc --noEmit` pass.
  **Manual steps before it works in prod:** apply the new migration
  (`supabase db push` or SQL editor) and ensure Realtime is enabled on
  the project (Broadcast is on by default; no table replication
  needed). Feature is hidden when Supabase env vars are unset.
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
  - **Worker cache-bust:** the worker is loaded via
    `/pyodide-worker.js?v=N`. An earlier (flaky `setStdout`-streaming)
    build got pinned in browsers under `?v=2`, which surfaced as an
    empty console on C3 (real C3 code + current worker provably emits
    `unittest` output; an empty console means a stale worker is running).
    Bumped to `?v=3` (and `RUNNER_VERSION = 3`). **Always bump both when
    editing the worker** or browsers/CDN keep serving the cached copy.
  - **Console layout fix:** the CodeEditor root `<section>` was `flex-1`
    without `min-h-0`, so it wouldn't shrink below content height. When the
    192px OutputConsole opened, Monaco didn't yield space and the console
    body was pushed past the bottom and clipped by `<main>`'s
    `overflow-hidden` — only the "Finished" header showed, output invisible.
    Added `min-h-0` to the section so the editor shrinks and the console
    body stays on screen.

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
- **Collaboration via Yjs + Supabase Realtime (2026-06-15)** — chose
  real-time co-editing (Tier 3) over a stateless snapshot link or an
  async persisted session. Transport split: live keystrokes + cursors
  over Supabase Realtime Broadcast (ephemeral, no per-keystroke DB
  write); persistence via one debounced base64 Yjs snapshot in
  `collab_sessions`. This is the **first client write to Supabase** —
  deliberately scoped to a single table with its own RLS; the catalog
  stays read-only. Identity stays anonymous (ephemeral name + color in
  localStorage); the share link is a capability URL retained until 30
  days idle (daily pg_cron reap by `updated_at`). v1 locks one session
  to one (problem, language). Open risk accepted for v1: anon insert is
  open (mitigated by unguessable ids, a `doc` size cap, and retention)
  rather than gated.
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
