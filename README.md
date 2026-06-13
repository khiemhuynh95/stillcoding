# StillCoding

A Next.js app for browsing coding problems and writing solutions, built on the
public [leetcode-api](https://github.com/noworneverev/leetcode-api).

**Flow:** Browse problems (filter / search / sort) → open a problem → write a
solution in an in-browser editor that auto-saves.

## Getting started

```bash
npm install
npm run dev      # http://localhost:3000
```

```bash
npm run build && npm start   # production
```

### Configuration

The API base URL is read from `NEXT_PUBLIC_LEETCODE_API_BASE` (see `.env.local`),
defaulting to the hosted `https://leetcode-api-pied.vercel.app`. Point it at a
self-hosted instance (e.g. `http://localhost:8000`) if you run the API yourself.

All env vars are optional — see [`.env.example`](.env.example) for the full
list. With none set the app runs against the live API; add the
`NEXT_PUBLIC_SUPABASE_*` vars to read the persisted catalog instead.

### Deploy (Vercel)

Import the repo into Vercel — the Next.js framework preset is detected
automatically (build `next build`, no extra config). Add any
`NEXT_PUBLIC_*` vars from `.env.example` under **Settings → Environment
Variables**; `.env.local` is gitignored and not uploaded. The
`SUPABASE_SERVICE_ROLE_KEY` belongs to the offline sync only and should **not**
be set on Vercel.

## Architecture

- **No backend / no database.** Problem data is fetched live from the API and
  cached in memory with **TanStack Query** (5-min stale time), so interactions
  don't refetch. All user state lives in the browser:
  - filters (the "filter cache"), restored on landing
  - solved / attempted status (drives the browse Status column)
  - code drafts, per problem **and** language, debounce-autosaved
- The data layer (`lib/leetcode.ts`, `lib/storage.ts`) is isolated so a backend
  (e.g. Supabase for accounts + cross-device sync) could be added later without
  touching the UI.

### Browse
The list endpoint returns all problems in one payload, so difficulty filtering,
title/number search, sorting, and pagination all run **client-side** for instant
results. Topic filtering uses the `/problems/tag/{slug}` endpoint.

### Coding screen
Resizable split (horizontal on desktop, vertical on mobile): sanitized problem
description on one side, a **Monaco** editor on the other. Pick from 6 languages;
your code is saved to `localStorage` as you type and restored on return.

## Adding your own problems

The app merges the read-only LeetCode API with a local, version-controlled set
of your own problems. To add one, edit **`lib/customProblems.ts`** and append to
the `CUSTOM_PROBLEMS` array:

- `title_slug` is the URL (`/problems/<slug>`) and must be unique.
- `content` is HTML shown in the description pane (examples/constraints inline).
- `starterCode` is optional **per-language** boilerplate (keys: `python3`,
  `javascript`, `typescript`, `java`, `cpp`, `go`) — something the LeetCode API
  can't provide.

Custom problems show up in the list (badged "Custom", ranked as newest), are
searchable, filter by their tags, and open in the editor like any other — no
other files change. When editing files by hand becomes limiting (frequent
edits, non-dev authors, user submissions), the same merge layer in
`lib/leetcode.ts` can swap this file for a Supabase/DB source **without touching
the UI**.

## Known limitations (by design)

- **No code execution.** The API is read-only and can't run or judge code, so the
  editor saves drafts only (no Run/Submit). A runner (Judge0/Piston) could be
  added later.
- **Generic starter templates.** The API doesn't expose per-problem function
  signatures, so each language ships a generic `Solution` scaffold.
- **Browse table** omits acceptance rate and per-row tags — those aren't in the
  list endpoint (only on the per-problem detail), so the table stays fast.

## Project structure

```
app/                     # routes: / (browse), /problems/[slug] (coding)
components/browse/        # sidebar, table, pagination, search, FAB
components/coding/        # description, Monaco editor, language select, status bar
components/layout/        # top nav, footer, mobile nav
hooks/                    # localStorage state, queries, filters, drafts, solved status
lib/                      # API client (+ custom-problem merge), types, storage, templates
providers/QueryProvider   # TanStack Query client
```
