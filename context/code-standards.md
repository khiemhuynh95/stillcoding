# Code Standards

## General

- Keep modules small and single-purpose; group components by feature
  area (`browse/`, `coding/`, `roadmap/`, `practice/`, `layout/`).
- Fix root causes, not symptoms — do not layer workarounds.
- Do not mix unrelated concerns (data fetching, rendering, storage)
  in one component. Data access goes through hooks / `lib/`.
- Match the surrounding code's style, naming, and comment density.
  The codebase favors a banner comment on curated-content files
  explaining how to edit them safely (see `roadmap.ts`,
  `practice.ts`) — keep that pattern when adding similar files.

## TypeScript

- Strict mode throughout. Prefer explicit `interface`s (see
  `lib/types.ts`) — avoid `any`.
- Normalize external data at the boundary: parse the API/DB shapes
  (snake_case lists, camelCase detail, JSON-string `stats`) into the
  UI shapes in `lib/leetcode.ts` before anything downstream uses
  them. Components consume only normalized types.
- Use the `@/` path alias for imports from the project root.

## Next.js (App Router)

- Default to server components; add `"use client"` only where
  browser interactivity requires it (editor, hooks, stateful UI).
- Load Monaco dynamically with `ssr:false`.
- Keep route files (`app/**/page.tsx`) thin — compose components and
  hooks; push logic into `lib/` and `hooks/`.
- Guard all `window` / `localStorage` access for SSR (the helpers in
  `lib/storage.ts` already do this — use them).

## Styling

- Use Tailwind utilities bound to the CSS custom-property design
  tokens (see `ui-context.md` and `globals.css`). **No hardcoded hex
  values** in components.
- Support light and dark themes; theme is restored before first paint
  via the inline script in `layout.tsx`.
- Follow the border-radius and spacing scales defined in
  `ui-context.md` (8px grid, soft 4px corners).

## Data Layer

- All catalog reads go through `lib/leetcode.ts`
  (`getProblems` / `getProblem` / `getProblemsByTag` / `getTags`).
  Never call the API or Supabase directly from a component.
- Every read path must keep its Supabase-first, **live-API-fallback**
  behavior (absence / empty / error → API) so the app runs keyless.
- Cache reads with TanStack Query; respect the existing stale time.
  Don't add ad-hoc fetch caching.
- When fetching problem detail from the API/sync, key by
  `title_slug`, never numeric id.

## State & Storage

- All user state is localStorage-only, via `lib/storage.ts` with the
  `devstudio:` prefix and the `storageKeys` registry. Never touch
  `window.localStorage` directly or invent un-prefixed keys.
- Keep user state (drafts, solved status, lists, theme, filters) out
  of Supabase — it is intentionally device-local.

## Security

- Sanitize all problem HTML with `lib/sanitize.ts` before rendering.
  Never render raw catalog content.
- Never expose the service-role key to the client; the app uses only
  the publishable/anon (read-only) key.

## Curated Content

- Add custom problems by appending to `CUSTOM_PROBLEMS`
  (`lib/customProblems.ts`); lists to `PRESET_LISTS` (`lib/lists.ts`);
  roadmap nodes to `ROADMAP` (`lib/roadmap.ts`); topic cheat sheets to
  `PRACTICE` (`lib/practice.ts`). A slug not in the catalog is
  silently skipped — never throw on it.
- Practice snippets must always include a `python3` entry (the
  fallback language); other languages are optional.
- Per-problem starter code for **catalog** problems lives in the DB
  (`problems.starter_code` jsonb), seeded by a migration — not in app
  code. Add more by extending the seed migration, keyed by `title_slug`;
  `rowToDetail` maps it to `ProblemDetail.starterCode` and the coding
  page prefers it over the generic scaffold. Verify each Python block
  against a reference solution before seeding. Custom problems (C1–C3)
  still carry their own `starterCode` in `lib/customProblems.ts`.
- **Database (SQL) problems** seed under the `sql` key, not `python3` — a
  schema-aware SQL stub (the in-browser runner is Python-only, so these
  are editor scaffolds). Verify the reference query against sample data
  with stdlib `sqlite3` before seeding the stub.

## File Organization

- `app/` — routes only (browse, problems, roadmap, practice).
- `components/<area>/` — UI grouped by feature area.
- `hooks/` — client state + data-access hooks.
- `lib/` — data layer, types, storage, and curated content.
- `providers/` — React context providers (TanStack Query).
- `supabase/` — migrations + sync Edge Function (excluded from app
  typecheck).
