---
name: verify
description: Mechanically reconcile a survey verdict against real repo evidence — never re-judging correctness, only confirming the repo actually shows what survey said. Writes one durable, evidence-linked record so moor and future sessions can check mechanically instead of asking the conversation.
---

A survey verdict that only lives in conversation can't be checked later without asking — verify closes that gap the same way moor's own capture is grounded: never a self-read of "this looks right," always the mechanical output of a script running against the actual repo.

## Context Contract

**Required:** the claim(s) to reconcile — either the specific `BLOCKED`
claim `survey` routed here, or the relevant claims from `survey`'s most
recent PASS verdict for what's about to be captured · `scripts/verify-claims.sh`'s
output for each claim — never a self-read of whether something "looks right."

**Conditional:** the ticket (`delegation-queue.md`) or charter-plan citation
this verification traces back to, when one exists · a project's own
run/test command, only when resolving a `BLOCKED` claim and one already
exists — never invented.

**Excluded by default:** re-judging correctness — that's `survey`'s job,
never repeated here · anything not verifiable through
`scripts/verify-claims.sh`'s mechanical checks.

**Outputs:** one durable row in `verified-index.md` — ticket/plan citation,
commit, claims checked, verdict, date.

**Write authority:** `verified-index.md` only (Core/Standard), append-only
— never `survey`'s report, never code, never a file another skill already
owns.

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

verify requires a state destination to write into, so its own legacy/missing-
state handling is stricter than the shared default: on legacy state, report
the classification and stop — never write. If neither schema 2 nor
recognizable legacy state exists, stop; there is no destination to write to.

For active schema 2: write to `core/verified-index.md` (Core) or
`context/verified-index.md` (Standard). Minimal has no destination — verify
does not run there, same exclusion as the Logbook and the threshold script
(Sections 2.9 and 2.11): outgrowing "no extra files" is itself the
promotion signal.

## How to Invoke

Claude Code: `/verify`, `/verify [ticket-or-claim]`.
Codex: `$verify`, `$verify [ticket-or-claim]`.

Two triggers, neither a blanket "run after every survey":
- **`moor`'s promotion check**, when no matching `verified-index.md` entry
  exists yet for the pattern/invariant it's about to capture.
- **`survey`'s own Step 4**, directly, when a Layer 3 claim comes back
  `BLOCKED` and needs real evidence to resolve.

A developer may also invoke it directly to reconcile a specific build.

---

## Step 1 — Gather what to check

Identify the claim(s) to verify: either the specific `BLOCKED` claim
`survey` routed here, or the claims from `survey`'s most recent PASS verdict
covering the files about to be captured. For each claim, resolve what
evidence would confirm it — which file(s) should exist or have changed, and
whether a project run/test command already exists that would resolve it.
Never invent a run command that isn't already there.

## Step 2 — Run the script, never estimate

Invoke `scripts/verify-claims.sh` with one `--check-file`, `--check-diff`,
or `--run-test` flag per claim resolved in Step 1. Read its exact output.
The script's MET / MISSING / BLOCKED verdict is the answer — never
substitute your own read of whether a change "looks right" for what it
actually reports.

## Step 3 — Write the record

Append one row to `verified-index.md`: the next sequential ID, the ticket
number or charter-plan citation this traces to, the commit checked at, a
one-line description of the claims checked, the verdict (if the script's
checks disagree, state the worst case — `MISSING` beats `MET`, `BLOCKED`
beats a false `MET` — never round up), and the date. Re-run
`scripts/check-banka-thresholds.sh` afterward so `verified-index.md`'s own
Threshold Check reflects what was just written.

## Step 4 — Confirm

```
Verified [claim(s)] against [ticket/plan] at [commit] → MET / MISSING / BLOCKED

Recorded: verified-index.md #[ID]
```

If `MISSING`: state plainly what's missing — never treat it as resolved.
If `BLOCKED`: say so, and name what would resolve it (a run/test command
the project doesn't have yet) — the same "never fabricate a resolution"
rule `survey`'s own `blocked` verdict already follows.

## The Rule

Never write what you believe — write what the script showed. A verified record that can't be mechanically re-derived is just another opinion with a timestamp.
