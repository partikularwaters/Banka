---
name: remember
description: Save what matters at the end of a session so the next session picks up exactly where you left off. Or restore context at the start of a new session so nothing is lost between them — and never trust this conversation's own memory over what's actually on disk.
---

AI has no memory between sessions. Every new session starts blank. This skill fixes that — but the fix is the file on disk, never this conversation's own recollection of it, since another session may have touched the project since this conversation last looked.

## Context Contract

**Required:** the resolved session-state file (tier-dependent — see "Resolve
Banka state first" below) · current git log/status, checked before trusting
this conversation · AGENTS.md/CLAUDE.md and the tier's required files, to
resolve state.

**Conditional:** IDEA-SCOPE.md and the rest of the tier's Source-of-truth
files, restore mode, when they exist · the resolved delegation queue, when
present · a legacy CLAUDE.md chain, read-only, restore mode only.

**Excluded by default:** any file outside the tier's declared Source of
truth · raw secret values, in any form, at any point.

**Outputs:** save mode — an updated session-state file, plus a one-line
confirmation · restore mode — a conversational restore summary.

**Write authority:** save mode only — the resolved session-state file, by
section, plus whichever file owns a globally-scoped fact a captured decision
changes. Restore mode: none.

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

Stop state-dependent work for competing authority, malformed/partial/duplicate
or unknown Banka markers, a non-exact `CLAUDE.md` beside schema 2, an exact shim
with missing authority, both state directories, tier mismatch, or missing
required tier files. Do not choose, repair, or normalize any of these states.

Without valid schema 2, recognize legacy Banka state only when `CLAUDE.md` has
the `# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old AGENTS block pointing to it. Legacy is
compatibility-read-only: restore mode may inspect and report its chain, but save
mode must stop because it writes state. No Banka state may change until an
explicitly requested, previewed, and confirmed migration completes. Incomplete
legacy state or a broken old shim is a stop condition.

For active schema 2, Standard session state lives in
`context/progress-tracker.md`, Core session state in `core/progress.md`, and
Minimal session state in the Current Status and Session Notes sections of the
Banka-owned `AGENTS.md` block. If neither schema 2 nor recognizable legacy
state exists, stop because no defined session-state destination exists. Never
create one implicitly.

## Security Boundary

Never persist secrets — API keys, tokens, passwords, private keys, cookies, connection strings, or any credential-like value. If useful but sensitive, store a redacted placeholder (`[REDACTED_API_KEY]`). If unsure, treat as sensitive and omit.

## How to Invoke

Claude Code: `/remember save` or `/remember restore`.
Codex: `$remember save` or `$remember restore`.
No argument given → ask which is meant.

---

## Save Mode

### Before writing anything: check for concurrent drift

If this project uses version control, run the equivalent of `git log` and `git status` **before** trusting anything this conversation believes about the project's current state. If a commit exists that this conversation didn't make, another session touched this project since — read what actually changed from disk/git, not from this conversation's assumptions, before writing the save. This applies every single time, not just when something seems off.

### What to capture

Think like handing off to an equally skilled colleague who knows nothing about today's session:

- **What was built** — specific files, features completed. Precise, not vague ("created X, Y, Z; feature works end to end").
- **Decisions made** — architectural choices future work depends on, with the reasoning, not implementation detail visible in the code.
- **Problems solved** — anything that took real time to figure out, so it isn't solved twice.
- **Current state** — exactly what works, what's partial, what's known-broken.
- **What comes next** — specific enough to start immediately.
- **Open questions** — anything genuinely unresolved.

Do not capture: implementation detail visible in the code itself, anything already documented in the context files, or the blow-by-blow process of how something was built — only what was built and decided.

### Safety check, then update the existing structure

Run a final pass for anything secret-shaped before writing. Update the resolved
file by section; never replace it with a standalone memory document:

- **Minimal — Banka-owned `AGENTS.md` block:** update Current Status, Completed
  Actions, Known Issues / Open Decisions, Session Notes, and Next Immediate
  Step. Preserve all content outside the marked block.
- **Core — `core/progress.md`:** update Current Phase, Active Milestones,
  Completed Actions, Known Issues, Session Memory Bank, and Next Immediate Step.
- **Standard — `context/progress-tracker.md`:** update Completed, In Progress,
  Up Next, Blocked, Known Issues, Decisions Made, and Session Notes.

When a captured decision changes a global invariant, architecture, token, or
other domain-owned fact, update the file that owns that fact rather than logging
the change only in session state. Preserve unrelated sections and prior durable
entries. Show a concise summary of proposed section changes before writing if
existing content would be replaced rather than appended or status-updated.

Confirm after writing: `Session state saved. Next session: invoke the remember skill in restore mode.`

---

## Restore Mode

### Step 1 — Check for drift before anything else

If version control is in use, run its equivalent of `git log --oneline -10` and `git status` immediately — even if the session-state file looks complete and current. **A project folder worked by more than one session can have real changes on disk that no saved state mentions yet.** Treat this as standing practice, not a one-off check triggered only when something seems wrong — the whole point is that a stale assumption looks exactly like a correct one until it's checked.

### Step 2 — Read everything available

Read the resolved session-state file first (the Banka-owned `AGENTS.md` block's
Current Status and Session Notes, `core/progress.md`, or
`context/progress-tracker.md`). Under active schema-2 Core or Standard, also
read every other file listed in `AGENTS.md`'s Source of truth section. Under
readable legacy Core or Standard, read the files listed in legacy `CLAUDE.md`
instead and identify the restore as legacy. At every tier, read
`IDEA-SCOPE.md` when it exists. Also read the exact tier-resolved queue when
present: root `delegation-queue.md` for Minimal/Core, or
`context/delegation-queue.md` for Standard. Do not scan beyond these declared
sources.

Never repeat or surface raw secrets from any source, even in restored context — summarize in redacted form only.

### Step 3 — Confirm what was restored

Do not start building. Summarize so the developer can verify accuracy:

```
Memory restored. Here is where we are:

**Git/version-control check:** [confirmed matches saved state / found drift — describe it]
**Last session:** [what was built]
**Current state:** [what works right now]
**Decisions in place:** [key locked decisions]
**Next up:** [what should start next]

Is this correct?
```

Only proceed after confirmation.

### If memory is incomplete, unclear, or contradicted by what's on disk

Say so honestly. Do not guess or silently reconcile a contradiction — surface it and let the developer decide which is authoritative.

## The Rule

Every session ends by invoking the remember skill in save mode. Every session
starts by invoking it in restore mode — and restore always means checking
disk/version-control reality first, this conversation's own memory second.
