---
name: scale
description: Promote a project one tier at a time — Minimal to Core, or Core to Standard — once defined thresholds are met, splitting the current tier's file(s) into the next tier's structure. Only runs when explicitly requested or a threshold is actually met. Never skips a tier.
argument-hint: (usually no argument needed)
---

CRITICAL: Do not execute a promotion unless the user explicitly requested this command, OR one of the current tier's thresholds is actually met (see below). **Always promote exactly one tier at a time** — even if it looks like both tiers' thresholds are already met, promote to the next tier up, confirm it's correct, then separately re-check whether a second promotion is also warranted. Never jump from Minimal straight to Standard in one pass.

## Resolve Banka state first

Before reading or writing project state, inspect `AGENTS.md`, the complete
contents of `CLAUDE.md`, `/core/`, `/context/`, and the required tier files.
Active schema 2 requires one complete Banka block in `AGENTS.md` containing
these exact comments exactly once and in this order: `<!-- BANKA:START -->`,
`<!-- BANKA:STATE-SCHEMA: 2 -->`, exactly one of
`<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, or
`<!-- BANKA:TIER: Standard -->`, then `<!-- BANKA:END -->`. The declared tier
must match the filesystem shape and required files. `CLAUDE.md` must be exactly
`@AGENTS.md`; if it is missing, schema 2 is still
active for a runtime that discovers `AGENTS.md` directly, but report that
Claude Code compatibility is unavailable.

A matching Minimal shape has neither `/core/` nor `/context/`. Core has
`/core/` and its `overview.md`, `architecture.md`, `design.md`, and
`progress.md`, with no `/context/`. Standard has `/context/` and its
`project-overview.md`, `architecture.md`, `build-plan.md`, `code-standards.md`,
`library-docs.md`, `ui-tokens.md`, `ui-rules.md`, `ui-registry.md`, and
`progress-tracker.md`, with no `/core/`.

Stop for competing authority, malformed/partial/duplicate or unknown Banka
markers, a non-exact `CLAUDE.md` beside schema 2, an exact shim with missing
authority, both state directories, tier mismatch, or missing required tier
files. Do not choose, repair, or normalize any of these states.

Without valid schema 2, recognize legacy Banka state only when `CLAUDE.md` has
the `# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old AGENTS block pointing to it. Legacy is
compatibility-read-only, while promotion writes state: report the classification
and stop until an explicitly requested, previewed, and confirmed migration
completes. Incomplete legacy state or a broken old shim is also a stop
condition. If neither schema 2 nor recognizable legacy state exists, stop
because there is no tier to promote.

For active schema 2, use the declared tier: Standard cannot promote further;
Core is eligible only for Core → Standard; Minimal is eligible only for Minimal
→ Core. Before changing `AGENTS.md`, locate its one complete Banka block,
update only that block, and preserve all content outside it. Keep `CLAUDE.md`
exactly `@AGENTS.md` when it exists; it is never a project-state destination.

**Then: check which (if any) threshold for the current tier is met, and state this plainly.** If none are met and the user did not explicitly request this: stop here and say no promotion is needed — do not proceed further.

---

## Minimal → Core

Thresholds — any one is sufficient:
1. The inline project content in the Banka-owned `AGENTS.md` block exceeds
   ~1,500 words (~9,000 characters).
2. Any one domain (overview, architecture, design, progress) has grown enough real content that it's crowding out the others inside the single file.

If triggered, perform the promotion:

1. Create a `/core/` folder in the project root.
2. Split the Minimal `AGENTS.md` block's inline project state into the four Core
   files:
   - Project Overview's Vision and Data Model → `core/overview.md`
   - Project Overview's Stack, Folder Matrix, and Absolute Invariants → `core/architecture.md`
   - Any UI-related content → `core/design.md`
   - Current Status and Session Notes → `core/progress.md`
3. Replace only the Banka-owned block in `AGENTS.md` with the Core router, set
   its tier marker to Core, and make its Source of truth section list the four
   `/core/` files. Preserve all content outside the block and keep `CLAUDE.md`
   exactly `@AGENTS.md`.
4. Output all four new files and the proposed replacement Banka block in full.
   Explicitly list what moves from the Minimal block into each new file so the
   user can confirm before inline state is removed. Once confirmed, replace the
   block with the router; do not leave duplicated state behind.

## Core → Standard

Thresholds — any one is sufficient:
1. The four `/core/` files combined exceed ~4,000 words (~25,000 characters).
2. The project has split into a fundamentally distinct architectural environment (e.g., a mobile companion app or standalone service alongside this project).
3. `core/design.md`'s Component Registry exceeds 15 complex, unique UI definitions.

If triggered, perform the promotion:

1. Create a `/context/` folder in the project root.
2. Split `core/overview.md` → `context/project-overview.md`.
3. Split `core/architecture.md` across the Standard files:
   - Stack, folder matrix, invariants → `context/architecture.md`
   - Conventions → `context/code-standards.md`
   - Third-party library patterns → `context/library-docs.md`
4. Split `core/design.md` across `context/ui-tokens.md`, `context/ui-rules.md`, and `context/ui-registry.md` (split by content type — tokens/colors/type scale to ui-tokens.md, layout/interaction patterns to ui-rules.md, the actual component list to ui-registry.md).
5. Split `core/progress.md`:
   - Active Milestones and Completed Actions → `context/build-plan.md`
   - Session Memory Bank and any Known Issues / Open Decisions → `context/progress-tracker.md`
6. Replace only the Banka-owned block in `AGENTS.md` with the Standard router,
   set its tier marker to Standard, and make its Source of truth section list
   all nine `/context/` files. Preserve all content outside the block and keep
   `CLAUDE.md` exactly `@AGENTS.md`. The Skills available note reflects that
   moor writes to `context/ui-registry.md` or `context/progress-tracker.md`, and
   remember uses `context/progress-tracker.md`.
7. Output all nine new files and the proposed replacement Banka block in full.
   Explicitly list what moves from each `/core/` file into each new file so the
   user can confirm before anything is deleted. Once confirmed and equivalence
   is verified, delete `/core/`; never leave both state directories.
