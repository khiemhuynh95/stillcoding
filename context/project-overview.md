# StillCoding

## Overview

StillCoding is a Next.js (App Router) web app for browsing coding
problems and writing solutions in the browser. It sources its
problem catalog from the public, read-only
[leetcode-api](https://github.com/noworneverev/leetcode-api)
(persisted in Supabase, with a live-API fallback), and merges in a
local, version-controlled set of custom problems. It's aimed at
developers practicing for interviews who want a fast, distraction-free
place to read a problem and draft a solution — plus guided structure
(a learning roadmap, curated problem lists, and per-topic syntax
review) layered on top of raw LeetCode data.

## Goals

1. Let a user browse the full ~1700-problem catalog and find a
   problem fast (instant client-side filter / search / sort).
2. Let a user read a problem and draft a solution in an in-browser
   editor that auto-saves per problem and language.
3. Provide curated structure the raw API lacks — a learning roadmap,
   preset + user-created problem lists, and per-topic syntax cheat
   sheets.
4. Ship with zero required backend (runs keyless against the live
   API), while keeping a clean swap point for Supabase-backed data.

## Core User Flow

1. User lands on the browse page; their last filters are restored
   from localStorage.
2. User filters by difficulty / topic / list, searches by title or
   number, and sorts — all instant and client-side.
3. User opens a problem (`/problems/[slug]`).
4. User reads the sanitized problem description on one side and
   writes a solution in the Monaco editor on the other.
5. Code auto-saves to localStorage per (problem, language); the user
   marks the problem solved/attempted, which drives the browse
   Status column and roadmap/list progress.
6. Optionally: follow the roadmap (`/roadmap`), review a topic's
   syntax before solving (`/practice/[topic]`), or add a problem to
   a list.

## Features

### Browse

- Full-catalog table (#, title, difficulty, paid badge, local
  status) with instant client-side search, difficulty filter, sort,
  and pagination.
- Topic filter (via the tag endpoint / `topic_tags`) and Random
  problem FAB.
- Sidebar with difficulty filters, topics, and Lists.
- Filters persist in localStorage (the "filter cache") and restore
  on landing; row prefetching warms problem detail on hover.

### Coding screen

- Resizable split (horizontal on desktop, vertical on mobile):
  sanitized HTML problem description + Monaco editor.
- 6 languages (python3, javascript, typescript, java, cpp, go);
  generic per-language starter scaffolds (custom problems may carry
  real per-language starter code).
- Debounced autosave of drafts per (problem, language); solved /
  attempted toggle; Save-to-list popover in the header.

### Problem lists

- Preset lists curated in code (`lib/lists.ts`: Blind 75, NeetCode
  150, Grind 75, Top 100 Liked) — ordered slug arrays.
- User-created lists in localStorage (`hooks/useLists.ts`: create /
  rename / delete / toggle problem). Browsing a list preserves its
  curated order. List and tag scopes are mutually exclusive.

### Roadmap

- A curated, branching learning path (`lib/roadmap.ts`) rendered as a
  dependency graph (`/roadmap`); progress computed from solved
  status. Each node holds problem slugs (LeetCode or custom).

### Practice (per-topic syntax review)

- Read-only "cheat sheets" per roadmap topic (`lib/practice.ts`,
  `/practice/[topic]`): core syntax / data structures / idioms,
  shown for the editor's selected language (python3 fallback).

### Custom problems

- Local, version-controlled problems appended to
  `lib/customProblems.ts`, merged with the API behind one normalized
  shape so the UI is source-agnostic.

### Collaboration

- Real-time co-editing of a single problem's code buffer via a
  shareable link. From the coding screen a user generates a link
  (`/problems/[slug]?session=<id>`); anyone who opens it joins a live
  Yjs-backed session and edits the same buffer with remote cursors and
  collaborator presence. Anonymous (ephemeral name + color); the link
  is a capability URL and sessions expire. Opt-in and only available
  when Supabase is configured. Users can "fork" a session back into
  their own local draft. One session = one (problem, language).

### Extras

- Light/dark theme (restored before first paint, no flash).
- Brown-noise focus player (`components/coding/BrownNoise.tsx`).
- Vercel Analytics.

## Scope

### In Scope

- Browsing, filtering, searching, sorting the problem catalog.
- Reading problems and drafting solutions (editor only).
- Local user state: filters, solved/attempted status, code drafts,
  user lists, theme — all in localStorage.
- Supabase-persisted catalog with daily sync + live-API fallback.
- Curated roadmap, preset/user lists, per-topic practice pages.
- Custom problems via a version-controlled file.

### Out of Scope

- Submission / judging (no grader). Run-only code execution exists for
  Python (in-browser Pyodide) and Java (server-side via the public
  Wandbox API); the other languages remain editor-only.
- Per-problem real function signatures / starter templates from the
  API (it exposes none — generic scaffolds are used).
- User accounts / auth / cross-device sync of user state (drafts,
  solved status, and user lists are not synced to Supabase).
  Collaboration is the one shared-state feature, but it is a separate,
  ephemeral, opt-in document — not a sync of the user's local state.
- Acceptance rate / per-row tags in the browse table (not in the
  list endpoint; kept off the table for speed).

## Success Criteria

1. With no env vars set, the app runs against the live API and a
   user can browse, open a problem, and draft a solution.
2. Filters, solved status, and code drafts survive a reload.
3. `npm run build` passes.
4. A new custom problem appended to `lib/customProblems.ts` appears
   in the list, is searchable, and opens in the editor with no other
   file changes.
