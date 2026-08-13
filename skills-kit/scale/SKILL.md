---
name: scale
description: Promote a project one tier at a time — Minimal to Core, or Core to Standard — once defined thresholds are met, splitting the current tier's file(s) into the next tier's structure. Only runs when explicitly requested or a threshold is actually met. Never skips a tier.
argument-hint: (usually no argument needed)
---

CRITICAL: Do not execute a promotion unless the user explicitly requested this command, OR one of the current tier's thresholds is actually met (see below). **Always promote exactly one tier at a time** — even if it looks like both tiers' thresholds are already met, promote to the next tier up, confirm it's correct, then separately re-check whether a second promotion is also warranted. Never jump from Minimal straight to Standard in one pass.

**First: resolve the current tier.** Check which state exists. `/context/` →
this project is already Standard tier — stop here and tell the user no promotion
is possible. `/core/` → this project is Core tier — check the Core → Standard
thresholds below. `CLAUDE.md` → this project is Minimal tier — check the Minimal
→ Core thresholds below. If none exists, stop: this is not a Banka-enabled
project, so there is no tier to promote.

Before changing `AGENTS.md`, locate the block between `<!-- BANKA:START -->`
and `<!-- BANKA:END -->`. Update only that Banka-owned block and preserve all
content outside it. If an older unmarked Banka shim exists, show the proposed
marked migration for confirmation. If unrelated instructions directly conflict
with the new Banka block, stop and surface the conflict instead of choosing one.

**Then: check which (if any) threshold for the current tier is met, and state this plainly.** If none are met and the user did not explicitly request this: stop here and say no promotion is needed — do not proceed further.

---

## Minimal → Core

Thresholds — any one is sufficient:
1. `CLAUDE.md`'s inline project content exceeds ~1,500 words (~9,000 characters).
2. Any one domain (overview, architecture, design, progress) has grown enough real content that it's crowding out the others inside the single file.

If triggered, perform the promotion:

1. Create a `/core/` folder in the project root.
2. Split `CLAUDE.md`'s inline content into the four Core files:
   - Project Overview's Vision and Data Model → `core/overview.md`
   - Project Overview's Stack, Folder Matrix, and Absolute Invariants → `core/architecture.md`
   - Any UI-related content → `core/design.md`
   - Current Status and Session Notes → `core/progress.md`
3. Rewrite `CLAUDE.md` to the Core router format — its Source of truth section now lists the four `/core/` files. Update only the Banka-owned block in `AGENTS.md` so it points to `CLAUDE.md` and `/core/`; do not copy project state into it.
4. Output all four new files and the rewritten `CLAUDE.md` in full, plus the proposed replacement for the marked Banka block in `AGENTS.md`. Explicitly list what moved from `CLAUDE.md` into which new file, so the user can confirm before anything is deleted. **Once confirmed, remove the inline content from `CLAUDE.md`** — leaving both copies in place risks a future session reading stale, duplicated content instead of the real Core source of truth.

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
6. Rewrite `CLAUDE.md` to the Standard router format — its Source of truth section now lists all nine `/context/` files, and its Skills available note updates to reflect that the moor skill writes to `context/ui-registry.md` (UI patterns) or `context/progress-tracker.md` (general outcomes), and the remember skill saves/restores session state in `context/progress-tracker.md`. Update only the Banka-owned block in `AGENTS.md` so it points to `CLAUDE.md` and `/context/`; do not copy project state into it.
7. Output all nine new files and the rewritten `CLAUDE.md` in full, plus the proposed replacement for the marked Banka block in `AGENTS.md`. Explicitly list what moved from which `/core/` file into which new one, so the user can confirm before anything is deleted. **Once confirmed, delete the `/core/` folder** — leaving it in place risks a future session reading stale, orphaned files instead of the real Standard source of truth.
