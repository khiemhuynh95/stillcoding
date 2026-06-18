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
  `customProblems.ts`, `lists.ts`, `roadmap.ts`, `practice.ts`,
  `starterTemplates.ts` the curated-in-code content; `sanitize.ts`,
  `prefetch.ts`, `utils.ts` the support utilities.
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
  makes anon/auth **read-only**; only the service role (Edge Function)
  writes.
- **Live API (fallback)**: `https://leetcode-api-pied.vercel.app`
  (configurable). Read when Supabase env vars are unset, or the DB
  returns empty/errors — so local dev works keyless.
- **In-code (version-controlled)**: custom problems, preset lists,
  roadmap, practice content, starter templates. Merged in the app
  layer; never written to Supabase.
- **localStorage (`devstudio:` prefix)**: all user state — filters,
  solved/attempted status, per-(problem,language) code drafts,
  user-created lists, selected language, theme. Not synced anywhere.
- **Supabase `collab_sessions` (client-writable)**: the one table the
  app writes to. Holds a shared code buffer for live co-editing — id
  (unguessable), slug, language, a base64 Yjs snapshot (`doc`),
  `created_at`, `updated_at`. RLS allows anon `insert`/`select`/`update`
  on this table **only**; it is a capability URL (anyone with the link
  can read + edit). Live keystrokes flow over Realtime Broadcast (not
  the DB); the row is just a debounced snapshot for late-joiners/reload.
  **Retention**: a daily pg_cron job deletes sessions idle for 30 days
  (by `updated_at`, which the snapshot save bumps — active sessions
  slide forward, only idle ones are reaped). The shared buffer is
  **not** part of the user's localStorage practice state — users
  "fork" a session back into a local draft to keep a copy.

## Auth and Access Model

- **No user auth.** There are no accounts; every visitor is anonymous
  and all personal state lives in their browser's localStorage.
- Supabase access is read-only via the publishable/anon key
  (`NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` or legacy
  `NEXT_PUBLIC_SUPABASE_ANON_KEY`); RLS forbids client writes.
- Catalog writes happen only offline, via the Edge Function running
  under the service role. The `SUPABASE_SERVICE_ROLE_KEY` is never
  exposed to the app / Vercel.
- **One scoped client-write exception**: the collaboration feature
  lets the anon client `insert`/`select`/`update` `collab_sessions`
  (and nothing else). Still no accounts — collaborators are anonymous,
  identified by an ephemeral display name + color held in localStorage.
  Collaboration requires Supabase env vars; when unset, the feature is
  simply hidden and the rest of the app runs keyless as before.

## Invariants

1. The UI is **source-agnostic**: components and hooks read through
   `lib/leetcode.ts`'s normalized shape (`getProblems` / `getProblem`
   / `getProblemsByTag` / `getTags`) and never know whether data came
   from Supabase, the live API, or `customProblems.ts`.
2. Every catalog read path falls back to the live API on
   absence/empty/error, so the app runs with **zero env vars set**.
3. All user state is localStorage-only and namespaced with the
   `devstudio:` prefix — go through `lib/storage.ts`, never touch
   `localStorage` directly.
4. Problem HTML is **always** sanitized (`lib/sanitize.ts`) before
   render — never `dangerouslySetInnerHTML` raw API/DB content.
5. Code execution is **Run-only, no judge** and limited to two
   languages: Python runs client-side (Pyodide/WASM in a Web Worker),
   Java is compiled + run server-side via the public Wandbox API
   (`hooks/useRunJava.ts` — no key, user code leaves the browser). All
   other languages stay editor-only (draft autosave). There is no
   Submit/grader — Run just executes the editor buffer.
6. Custom problems, lists, roadmap, and practice are curated in code
   and resolve through the normal data layer — a slug missing from
   the catalog is silently skipped, never an error.
7. Supabase detail is fetched by `title_slug`, never numeric id (the
   API mis-resolves bare numbers as frontend ids); "has detail" means
   `detail_synced_at != null`, not `content != null`.
8. The **only** client write path is `collab_sessions`; every catalog
   table (`problems`, `tags`, `sync_runs`) stays anon read-only. User
   practice state (drafts, solved status, lists) stays localStorage-only
   and is never written to Supabase — a collab session is a separate,
   ephemeral, opt-in document.
