# AI Workflow Rules

## Approach

Build StillCoding incrementally against the context files. They
define what to build (`project-overview.md`), how the system is
structured (`architecture.md`), the visual system (`ui-context.md`),
implementation rules (`code-standards.md`), and current state
(`progress-tracker.md`). Implement against these specs — do not infer
or invent product behavior from scratch. Read all six (this file
included) before any architectural decision, per `CLAUDE.md`.

## Scoping Rules

- Work on one feature unit at a time.
- Prefer small, verifiable increments over large speculative changes.
- Do not combine unrelated system boundaries (e.g. the Supabase sync
  function and the browse UI) in a single implementation step.

## When to Split Work

Split an implementation step if it combines:

- UI changes and data-layer / Supabase-sync changes.
- Multiple unrelated routes or feature areas (e.g. roadmap and the
  coding screen).
- Behavior not clearly defined in the context files.

If a change cannot be verified end to end quickly, the scope is too
broad — split it.

## Handling Missing Requirements

- Do not invent product behavior not defined in the context files.
- If a requirement is ambiguous, resolve it in the relevant context
  file before implementing.
- If a requirement is missing, add it as an open question in
  `progress-tracker.md` before continuing.

## Preserve the Core Invariants

When changing the data or state layer, do not break the invariants in
`architecture.md`. In particular:

- Keep the live-API fallback on every catalog read path (the app must
  run with zero env vars set).
- Keep the UI source-agnostic — go through `lib/leetcode.ts`'s
  normalized shape.
- Keep user state in localStorage via `lib/storage.ts`; do not sync
  it to Supabase.
- Always sanitize problem HTML before rendering.

## Protected Files

Do not modify the following unless explicitly instructed:

- `node_modules/**` and any third-party library internals.
- `supabase/migrations/*` already applied to the live project —
  add a new migration rather than editing a historical one.
- `design/*.html` — reference mockups, not shipping code.
- `ui-context.md` — the design system spec (treat as source of truth;
  change only when the user asks).

## Keeping Docs in Sync

Update the relevant context file whenever implementation changes:

- System architecture, boundaries, or storage model →
  `architecture.md`.
- Code conventions or standards → `code-standards.md`.
- Feature scope → `project-overview.md`.
- Any meaningful change → `progress-tracker.md`.

## Before Moving to the Next Unit

1. The current unit works end to end within its defined scope.
2. No invariant defined in `architecture.md` was violated.
3. `progress-tracker.md` reflects the completed work.
4. `npm run build` passes.
