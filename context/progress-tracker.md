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
- **Custom problem test scaffolds** — expanded the inline `python3`
  `unittest` blocks for C1 (`add-digits-until-one`) and C2
  (`balanced-brackets`) from a single `test_examples` into proper test
  classes (`TestAddDigits` / `TestBalancedBrackets`) with the example
  cases plus edge cases (single-digit/digital-root for C1; simple pairs,
  unbalanced, nested/sequential for C2). C3 left as-is.
- **Per-problem catalog starter code (DB-backed)** — catalog problems can
  now carry a real `class Solution` signature + an inline `unittest` block
  (≥3 tests: examples + edge cases) instead of the generic `solve()`
  scaffold. **Stored in the DB, not in app code:** a new `starter_code`
  jsonb column on `problems`, seeded by migration
  `20260616000001_problem_starter_code.sql`. Read path:
  `fetchProblemFromDb` → `rowToDetail` maps `starter_code` →
  `ProblemDetail.starterCode` (lib/supabase.ts); the coding page already
  prefers `detail.starterCode` over the generic template. The daily sync
  only writes the columns it names, so it preserves `starter_code`.
  Order-insensitive tests where the problem allows any output order
  (group-anagrams, top-k, 3sum); helper classes/builders inline for
  linked-list / tree / graph / design problems. Each block was verified
  against a reference solution before seeding. **Scope:** the API exposes
  no signatures, so these are hand-authored per slug for the curated
  study-list universe (Blind 75 / NeetCode 150 / Grind 75 / Top 100 Liked
  — ~200 unique slugs); problems without a seed keep the generic scaffold.
  python3 only (the runnable language). `tsc --noEmit` passes.
  **Coverage: the entire curated study-list universe — all 189 unique
  slugs across Blind 75 / NeetCode 150 / Grind 75 / Top 100 Liked.** Two
  seed migrations: `…0001` (Blind 75, 75 problems) adds the column;
  `…0002_…_extra` (the remaining 114) seeds the rest. Every Python block
  was verified against a reference solution (stub + reference + shared
  tests, so the seeded tests are exactly the verified ones) and
  compile-checked out of the generated SQL. Problems outside these lists
  keep the generic scaffold. **Manual step:** apply both migrations
  (`supabase db push` or SQL editor); without them (or keyless dev), these
  problems fall back to the generic scaffold.
  - **Beyond the curated lists** (`…0003_…_common`, 24): widely-known
    catalog problems (e.g. remove-duplicates, roman-to-integer,
    reverse-string, fibonacci-number, min-depth, path-sum) — same verified
    Python pipeline. The full ~3,700-problem tail is NOT covered: the API
    exposes no signatures to author/verify from.
  - **SQL / database problems** (`…0004_…_sql`, 10): seeded under the
    `sql` key (not python3) since they're solved in SQL — schema-aware
    stubs, with the reference query verified against sample data via
    stdlib `sqlite3`. e.g. combine-two-tables, second-highest-salary,
    rank-scores, rising-temperature.
- **Full catalog backfill (DB-direct, not a migration)** — ran a one-off
  Python backfill (service-role key; script not retained) to populate
  `starter_code` for every non-hand-authored problem from LeetCode's
  official GraphQL `codeSnippets` + `metaData` + `content`.
  **Python-only** (`from __future__ import annotations` + the official
  `python3` signature with `pass` injected so it runs standalone), plus a
  `unittest` block of the statement's **example** cases where the
  signature is JSON-able (skips linked-list/tree/graph-node, design
  classes, and void/in-place; those get the signature stub). Database
  problems get the `sql` snippet. Results: **3,138 / 3,958** problems now
  carry starter code (was 222 hand-authored); ~2,586 backfilled python3
  **with example tests** + 96 SQL; **820** stay NULL (premium/locked — no
  public snippets → generic scaffold); 0 failures. The 223 hand-authored
  seeds are protected by slug and untouched. **Caveat:** these example
  tests are statement-derived (authoritative inputs/outputs) but
  unverified and can be over-strict for any-order/multiple-answer
  problems (each block says so). **Not captured in a migration** — the
  data lives only in the DB; reproduce by re-querying LeetCode's GraphQL
  (`codeSnippets`/`metaData`/`content`) for rows whose `starter_code` is
  null.
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
- **Editor view controls + Run shortcut + pass/fail badge** — coding-screen
  polish on top of the existing Monaco editor + Pyodide runner:
  - **Font size controls** in the editor header (font − / size / font +),
    hidden on mobile (`sm:` and up). Persists across problems in localStorage
    (`editorFontSize` 11–22) and feeds Monaco's `options` (live-applied by
    `@monaco-editor/react`).
  - **Ctrl/Cmd+Enter runs the buffer** — registered via `editor.addCommand`
    in `onMount` (latest handler reached through a ref); no-op for
    non-Python languages. Run tooltip mentions the shortcut.
  - **Pass/fail badge** on the OutputConsole header — `parseTestSummary`
    (exported from `useRunPython.ts`) reads unittest's `Ran N tests` +
    `OK`/`FAILED (failures=..,errors=..)` lines into `{total, passed,
    failed}`; the console shows a green "N/N passed" / red badge once a run
    finishes. Returns null for non-unittest output (plain prints). No worker
    change (no `?v=` bump needed). `tsc --noEmit` passes.

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
