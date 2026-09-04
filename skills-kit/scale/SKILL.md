---
name: scale
description: Promote a project one tier at a time — Minimal to Core, or Core to Standard — once defined thresholds are met, splitting the current tier's file(s) into the next tier's structure. Only runs when explicitly requested or a threshold is actually met. Never skips a tier.
argument-hint: (usually no argument needed)
---

CRITICAL: Do not execute a promotion unless the user explicitly requested this command, OR one of the current tier's thresholds is actually met (see below). **Always promote exactly one tier at a time** — even if it looks like both tiers' thresholds are already met, promote to the next tier up, confirm it's correct, then separately re-check whether a second promotion is also warranted. Never jump from Minimal straight to Standard in one pass.

**Note:** this skill's "promotion" is tier-level (Minimal→Core→Standard) only.
Protocol §2.9 defines a separate, within-tier "promotion check" — moving a
durable fact from session-state to its owning file — that `remember` and
`moor` perform directly. It is not a tier promotion and this skill has no
role in it.

## Context Contract

**Required:** the current tier's complete state (the Banka-owned `AGENTS.md`
block, or every `/core/` or `/context/` file) · the relevant threshold
figures (word/character counts, registry entry count).

**Excluded by default:** the next tier beyond the one promotion step being
performed — scale never previews a Core→Standard split while executing
Minimal→Core.

**Outputs:** the proposed destination files in full, and the proposed
replacement `AGENTS.md` block, shown before anything is finalized.

**Write authority:** the marked `AGENTS.md` block, plus the tier's target
directory and files — only after the user confirms the shown mapping, and
only for the single tier step being promoted. A promoted project must still
pass the Cold Agent Test (Protocol §3.1) once the write completes.

## Resolve Banka state first

Before reading or writing project state, inspect `AGENTS.md`, the complete
contents of `CLAUDE.md`, `/core/`, `/context/`, and the required tier files.
Active schema 2 requires one complete Banka block in `AGENTS.md` containing
these exact comments exactly once and in this order: `<!-- BANKA:START -->`,
`<!-- BANKA:STATE-SCHEMA: 2 -->`, exactly one of
`<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, or
`<!-- BANKA:TIER: Standard -->`, then `<!-- BANKA:END -->`. The declared tier
must match the filesystem shape and required files. `CLAUDE.md` must be exactly
`@AGENTS.md`; if it is missing, schema 2 is still active for a runtime that
discovers `AGENTS.md` directly, but report that Claude Code compatibility is
unavailable.

A matching Minimal shape has neither `/core/` nor `/context/`. Core has
`/core/` and its `overview.md`, `architecture.md`, `design.md`, `progress.md`,
`session-notes.md`, `decisions-index.md`, and `verified-index.md`, with no
`/context/`. Standard has `/context/` and its `project-overview.md`,
`architecture.md`, `build-plan.md`, `code-standards.md`, `library-docs.md`,
`ui-tokens.md`, `ui-rules.md`, `ui-registry.md`, `progress-tracker.md`,
`session-notes.md`, `decisions-index.md`, and `verified-index.md`, with no
`/core/`.

Stop state-dependent work for competing authority, malformed/partial/duplicate
or unknown Banka markers, a non-exact `CLAUDE.md` beside schema 2, an exact shim
with missing authority, both state directories, tier mismatch, or missing
required tier files. Do not choose, repair, or normalize any of these states.

Without valid schema 2, recognize legacy Banka state only when `CLAUDE.md` has
the `# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old AGENTS block pointing to it. If neither schema 2
nor recognizable legacy state exists, treat the repository as
unstructured/non-Banka — never assume Minimal, never create Banka state
implicitly.

Promotion writes state, so scale's own legacy/missing-state handling is
stricter than the shared default: on legacy state, report the classification
and stop until an explicitly requested, previewed, and confirmed migration
completes — never promote. If neither schema 2 nor recognizable legacy state
exists, stop because there is no tier to promote.

For active schema 2, use the declared tier: Standard cannot promote further;
Core is eligible only for Core → Standard; Minimal is eligible only for
Minimal → Core. Before changing `AGENTS.md`, locate its one complete Banka block,
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
2. Split the Minimal `AGENTS.md` block's inline project state into the seven
   Core files:
   - Project Overview's Vision and Data Model → `core/overview.md`. A Core
     template section with no Minimal-tier source (e.g. Features In/Out of
     Scope, Success Criteria) gets a real, project-specific placeholder
     statement — never silently omitted.
   - Project Overview's Stack, Folder Matrix, and Absolute Invariants → `core/architecture.md`
   - Any UI-related content → `core/design.md`. A project with no UI surface
     gets an explicit statement to that effect (matching `design.md`'s own
     template guidance that this is a valid, checkable fact, not a gap to
     leave ambiguous) — never left blank or in placeholder brackets.
   - Current Status and task-tracking content, including Next Immediate
     Step, → `core/progress.md` — even though Minimal's template places Next
     Immediate Step textually under its Session Notes heading, it belongs
     with task tracking, not narrative, since Core's own `session-notes.md`
     has no equivalent field for it.
   - Session Notes narrative (Context, and any still-open item under Known
     Issues / Open Decisions) → `core/session-notes.md`. An OPEN item
     (Section 2.5's tag) is never a durable decision — it stays here exactly
     as an open item, never promoted to the Logbook, however close it sits
     to a settled decision that is.
   - Any inline decision clearing the Logbook's eligibility bar (Protocol
     Section 2.11 — a durable, standing fact carrying real reasoning worth
     preserving, not merely visible or resolved) → its own
     `core/decisions/NNNN-title/` record, with a row in
     `core/decisions-index.md`; a single-line settled fact with no real
     rationale goes to whichever owning file it belongs in instead.
   - `core/verified-index.md` starts empty — Minimal has nothing to migrate
     into it, since `verify` only runs on Core/Standard.
   - Carry the project's own content only. Never backfill a destination
     file's generic instructional or scaffolding prose (e.g. `design.md`'s
     "how to fill this in" guidance) — that exists for fresh tier
     generation, not promotion, and inserting it here would misrepresent
     Banka guidance as something this project decided.
3. Replace only the Banka-owned block in `AGENTS.md` with the Core router, set
   its tier marker to Core, and make its Source of truth section list the seven
   `/core/` files. Preserve all content outside the block and keep `CLAUDE.md`
   exactly `@AGENTS.md`.
4. Output all seven new files and the proposed replacement Banka block in full.
   Explicitly list what moves from the Minimal block into each new file so the
   user can confirm before inline state is removed. Once confirmed, replace the
   block with the router; do not leave duplicated state behind.

## Core → Standard

Thresholds — any one is sufficient:
1. The seven `/core/` files combined exceed ~4,000 words (~25,000 characters).
2. The project has split into a fundamentally distinct architectural environment (e.g., a mobile companion app or standalone service alongside this project).
3. `core/design.md`'s Component Registry exceeds 15 complex, unique UI definitions.

If triggered, perform the promotion:

1. Create a `/context/` folder in the project root.
2. Split `core/overview.md` → `context/project-overview.md`.
3. Split `core/architecture.md` across the Standard files:
   - Stack, folder matrix, invariants → `context/architecture.md`
   - Conventions → `context/code-standards.md`
   - Third-party library patterns → `context/library-docs.md`
4. Split `core/design.md` across `context/ui-tokens.md`, `context/ui-rules.md`, and `context/ui-registry.md` (split by content type — tokens/colors/type scale to ui-tokens.md, layout/interaction patterns to ui-rules.md, the actual component list to ui-registry.md). A project with no UI surface carries that same explicit statement forward into all three files, rather than each one separately going ambiguous or blank.
5. Split `core/progress.md`:
   - Active Milestones and Completed Actions → `context/build-plan.md`
   - Remaining task-tracking content, including Next Immediate Step →
     `context/progress-tracker.md`
6. `core/session-notes.md` → `context/session-notes.md` (any still-open item
   stays exactly as an open item — Standard's larger file count doesn't
   change what clears the Logbook's eligibility bar); `core/decisions-index.md`
   → `context/decisions-index.md`; `core/decisions/` → `context/decisions/`,
   unchanged; `core/verified-index.md` → `context/verified-index.md`,
   unchanged.
7. Every split above carries the project's own content only — never backfill
   a Standard file's generic instructional or scaffolding prose (e.g.
   `code-standards.md`'s Engineering Mindset section, or `ui-tokens.md`'s
   "how to fill this in" pattern guidance). That scaffolding exists for
   fresh tier generation, not promotion. A Standard template section with no
   Core-tier source gets a real, project-specific placeholder statement
   instead, same as Minimal → Core.
8. Replace only the Banka-owned block in `AGENTS.md` with the Standard router,
   set its tier marker to Standard, and make its Source of truth section list
   all twelve `/context/` files. Preserve all content outside the block and keep
   `CLAUDE.md` exactly `@AGENTS.md`. The Skills available note reflects that
   moor writes git-observed UI patterns to `context/ui-registry.md` and
   invariant/token changes to their owning file, never session-state; remember
   uses `context/progress-tracker.md`, `context/session-notes.md`, and
   `context/decisions-index.md`; and verify writes to
   `context/verified-index.md` only.
9. Output all twelve new files and the proposed replacement Banka block in full.
   Explicitly list what moves from each `/core/` file into each new file so the
   user can confirm before anything is deleted. Once confirmed and equivalence
   is verified, delete `/core/`; never leave both state directories.

## Standard is the ceiling

`scale` never promotes past Standard — there is no fourth tier. A project
that has genuinely outgrown Standard needs a different mechanism entirely
(multi-developer coordination, real governance, likely structured or
database-backed state instead of markdown prose), not one more proportional
step in this ladder. Banka does not attempt that internally; say so plainly
rather than improvising a workaround, and point the developer to a
genuinely different tool for that scale of project.
