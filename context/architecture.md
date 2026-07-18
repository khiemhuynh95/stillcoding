# Architecture Context

## Stack

| Layer        | Technology                                   | Role                                                            |
| ------------ | -------------------------------------------- | -------------------------------------------------------------- |
| Framework    | Next.js 15 (App Router) + React 18.3 + TS    | Routing, rendering, app shell                                  |
| Styling      | Tailwind CSS 3 + CSS custom-property tokens  | Theming (light/dark), Material-3-derived design system        |
| Editor       | Monaco (`@monaco-editor/react`, ssr:false)   | In-browser code editor                                         |
| Data caching | TanStack Query 5                             | In-memory cache of API/DB reads (5-min stale time)            |
| Layout       | `react-resizable-panels`                     | Resizable description/editor split                            |
| Catalog data | leetcode-api → Supabase (Postgres) + fallback | Problem list + detail; persisted in DB, falls back to live API |
| Sync         | Supabase pg_cron + pg_net + Deno Edge Fn     | Daily refresh of the persisted catalog                        |
| Collab       | Yjs CRDT + Supabase Realtime (Broadcast)     | Real-time co-editing of a shared code buffer (opt-in, link-based) |
| Sanitizer    | `isomorphic-dompurify`                        | Sanitizes problem HTML before render                          |
| Analytics    | `@vercel/analytics`                          | Page analytics on Vercel                                      |

React 18.3 (not 19) was chosen for clean Monaco / panels peer deps.

## System Boundaries

- `app/` — routes only: `/` (browse), `/problems/[slug]` (coding),
  `/roadmap`, `/practice/[topic]`, plus `layout.tsx` (theme script,
  fonts, providers) and `not-found.tsx`.
- `components/` — presentational + interactive UI, grouped by area:
  `browse/`, `coding/`, `roadmap/`, `practice/`, `layout/`. No data
  fetching beyond the hooks they call.
- `hooks/` — client state and data access: `useProblems` (queries),
  `useFilters`, `useCodeDraft`, `useSolvedStatus`, `useLists`,
  `useBrownNoise`, `useLocalStorage` (the SSR-safe primitive).
- `lib/` — the data layer and curated content. `leetcode.ts` is the
  single normalized data API; `supabase.ts` the DB client; `types.ts`
  the shared shapes; `storage.ts` the namespaced localStorage helpers;
  `lists.ts`, `roadmap.ts`, `practice.ts`, `starterTemplates.ts` the
  curated-in-code content; `sanitize.ts`, `prefetch.ts`, `utils.ts` the
  support utilities. (Custom problems used to live in `customProblems.ts`;
  they are now `source='custom'` rows in the DB.)
- `providers/` — `QueryProvider` (TanStack Query client).
- `supabase/` — `migrations/`, `functions/sync-problems/` (Deno Edge
  Function), `config.toml`, `README.md`. Excluded from the Next.js
  typecheck via tsconfig.
- `design/` — static HTML mockups (`browse.html`, `code.html`) the
  UI was built from; reference only.

## Storage Model

- **Supabase (Postgres)**: the canonical problem catalog — `problems`
  (list fields + detail: content / stats(jsonb) / topic_tags /
  solution + `detail_synced_at`, plus `starter_code` jsonb: hand-authored
  per-problem starter code keyed by language, seeded by migration and
  preserved across syncs), `tags`, and a `sync_runs` audit table. RLS
  makes anon/auth **read-only**; only the service role (Edge Function /
  migrations) writes. **Custom problems** live here too as `source='custom'`
  rows (e.g. `custom-<slug>` ids), seeded by migration; the daily sync
  upserts LeetCode rows by id and never deletes, so custom rows survive.
- **Live API (fallback)**: `https://leetcode-api-pied.vercel.app`
  (configurable). Read when Supabase env vars are unset, or the DB
  returns empty/errors — so local dev works keyless. (Custom problems are
  DB-only, so they don't appear in keyless dev.)
- **In-code (version-controlled)**: preset lists, roadmap, practice
  content, starter templates. Merged in the app layer; never written to
  Supabase. (Custom problems were here previously; now DB-backed.)
- **localStorage (`devstudio:` prefix)**: all *public* user state —
  filters, solved/attempted status, per-(problem,language) code drafts,
  user-created lists, selected language, theme, per-problem countdown
  timer (`timer:<slug>`). Not synced anywhere. (The supabase-js session
  for signed-in course users also lives in localStorage, managed by the
  library.)
- **Supabase course tables (hidden beta, signed-in only)**: `profiles`,
  `courses` (join code + start/end timeline), `course_members`,
  `course_invites`, `course_weeks` (title, position, and optional
  markdown `material` — admin-authored study notes rendered on
  `/course/[code]/week/[weekId]`), `course_problems` (ordered slugs per
  week), `problem_progress` (per user+course+problem: failed-attempt
  counter, then frozen `points`/`exec_ms`/`completed_at`), and the
  `course_leaderboard` view (security_invoker). Course content is
  member-only via `auth.uid()` RLS; `problem_progress` has **no client
  write path** — scoring goes through the `record_run` RPC, which owns
  the points formula (difficulty base − attempt penalty + speed bonus)
  and the timeline check. Progress rows survive leave/rejoin. Course
  activity is the only user state persisted server-side; drafts,
  filters, theme, timers, and the public solved-map stay localStorage.
- **Supabase `collab_sessions` (client-writable)**: the one table the
  app writes to. Holds a shared code buffer for live co-editing — id
  (unguessable), slug, language, a base64 Yjs snapshot (`doc`),
  `created_at`, `updated_at`. RLS allows anon `insert`/`select`/`update`
  on this table **only**; it is a capability URL (anyone with the link
  can read + edit). Live keystrokes flow over Realtime Broadcast (not
  the DB); the row is just a debounced snapshot for late-joiners/reload.
  The same Yjs doc also carries a `timer` `Y.Map` — a **shared session
  countdown** (`{ durationMs, running, startedAt, remainingMs }`): any
  collaborator can start/pause/reset/set-minutes, it converges over Broadcast
  and rides along in the `doc` snapshot. It writes only on
  start/stop/reset/set (display ticks are local), so a running timer adds no
  extra traffic.
  **Retention**: a daily pg_cron job deletes sessions idle for 30 days
  (by `updated_at`, which the snapshot save bumps — active sessions
  slide forward, only idle ones are reaped). The shared buffer is
  **not** part of the user's localStorage practice state — users
  "fork" a session back into a local draft to keep a copy.

## Auth and Access Model

- **The public app has no user auth.** Anonymous visitors have no
  accounts and all their personal state lives in localStorage, exactly
  as before.
- **Hidden course beta (the one auth surface)**: Supabase Auth
  email/password behind the unlisted `/course/login` page (no public
  links). The shared client persists the session
  (`persistSession: true` — a no-op for anonymous visitors, who never
  create one). `providers/AuthProvider.tsx` exposes
  `useAuth()` (session + `profiles` row); `app/course/(member)/layout.tsx`
  client-gates the course area. No middleware / `@supabase/ssr`.
- **Roles**: `profiles.is_admin` (set manually in the Supabase
  dashboard) gates course creation **and grants visibility/management
  of every course**: the RLS helpers `is_course_member` /
  `is_course_admin` include an `is_app_admin()` bypass, so app admins
  see and manage all courses without materialized membership rows.
  They still don't earn points or appear on leaderboards unless they
  actually join (`record_run` and the leaderboard view key off real
  `course_members` rows). Per-course roles live in
  `course_members.role` (`admin`|`member`). Course content is
  otherwise member-only via `auth.uid()` RLS through those
  security-definer helpers.
  Privileged transitions are security-definer RPCs only:
  `create_course`, `join_course`, `redeem_invites`, `record_run`.
  Invites are DB rows redeemed by the `auth.users` insert trigger or
  on sign-in — no email sending.
- Supabase catalog access stays read-only via the publishable/anon key
  (`NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` or legacy
  `NEXT_PUBLIC_SUPABASE_ANON_KEY`); RLS forbids client catalog writes.
- Catalog writes happen only offline, via the Edge Function running
  under the service role. The `SUPABASE_SERVICE_ROLE_KEY` is never
  exposed to the app / Vercel.
- **One anon client-write exception**: the collaboration feature
  lets the anon client `insert`/`select`/`update` `collab_sessions`
  (and nothing else). Collaborators stay anonymous,
  identified by an ephemeral display name + color held in localStorage.
  Collaboration requires Supabase env vars; when unset, the feature is
  simply hidden and the rest of the app runs keyless as before.

## Invariants

1. The UI is **source-agnostic**: components and hooks read through
   `lib/leetcode.ts`'s normalized shape (`getProblems` / `getProblem`
   / `getProblemsByTag` / `getTags`) and never know whether data came
   from Supabase (LeetCode or `source='custom'` rows) or the live API.
2. Every catalog read path falls back to the live API on
   absence/empty/error, so the app runs with **zero env vars set**.
3. All *public* user state is localStorage-only and namespaced with the
   `devstudio:` prefix — go through `lib/storage.ts`, never touch
   `localStorage` directly. Signed-in **course activity** (enrollment,
   attempts, completions, points) is the deliberate exception: it
   persists to Supabase through `lib/course.ts` only.
4. Problem HTML is **always** sanitized (`lib/sanitize.ts`) before
   render — never `dangerouslySetInnerHTML` raw API/DB content.
   Markdown (course study material) renders only through
   `lib/markdown.ts` (`marked` → `sanitizeHtml`) — same invariant,
   markdown flavored.
5. Code execution is **Run-only, no judge** and limited to three
   languages: Python (Pyodide/WASM in a Web Worker) and JavaScript
   (native, in a Web Worker — `hooks/useRunJavaScript.ts`) run
   **client-side**; Java is compiled + run **server-side** via the
   public Wandbox API (`hooks/useRunJava.ts` — no key, user code leaves
   the browser). All other languages stay editor-only (draft autosave).
   There is no Submit/grader — Run just executes the editor buffer.
6. Lists, roadmap, and practice are curated in code and resolve through
   the normal data layer — a slug missing from the catalog is silently
   skipped, never an error. Custom problems are now **DB rows**
   (`source='custom'`), added by migration; they read through the same
   path as the catalog (so they're absent only in keyless dev).
7. Supabase detail is fetched by `title_slug`, never numeric id (the
   API mis-resolves bare numbers as frontend ids); "has detail" means
   `detail_synced_at != null`, not `content != null`.
8. The **only anon** client write path is `collab_sessions`; every
   catalog table (`problems`, `tags`, `sync_runs`) stays anon read-only.
   Signed-in course users additionally write course tables under
   member/admin RLS, and `problem_progress` only via the `record_run`
   RPC. Public practice state (drafts, solved status, lists) stays
   localStorage-only and is never written to Supabase — a collab
   session is a separate, ephemeral, opt-in document.
9. **Course reads/writes go through `lib/course.ts`** (and the hooks in
   `hooks/useCourses.ts`); components never call Supabase directly.
   The points formula lives **only** in the `record_run` RPC — the
   client reports what a run did (pass/fail + measured duration), never
   computes points. Trust model accepted for the beta: the client is
   trusted about run outcomes (no server judge), but not about
   attempts, points, membership, or the course timeline.
