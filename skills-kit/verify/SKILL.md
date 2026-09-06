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

**Write authority:** `verified-index.md` and its own `overflow/verified/`
(Core/Standard), append-only — never `survey`'s report, never code, never a
file another skill already owns.

## Resolve Banka state first

Before reading or writing project state, inspect `AGENTS.md`, the complete
contents of `CLAUDE.md`, `/core/`, `/context/`, and the required tier files.
An active schema requires one complete Banka block in `AGENTS.md` containing
these exact comments exactly once and in this order: `<!-- BANKA:START -->`,
`<!-- BANKA:STATE-SCHEMA: 2 -->` or `<!-- BANKA:STATE-SCHEMA: 3 -->`, exactly
one of `<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, or
`<!-- BANKA:TIER: Standard -->`, then `<!-- BANKA:END -->`. The declared tier
must match the filesystem shape required for that schema number. `CLAUDE.md`
must be exactly `@AGENTS.md`; if it is missing, the active schema is still
active for a runtime that discovers `AGENTS.md` directly, but report that
Claude Code compatibility is unavailable.

A matching Minimal shape has neither `/core/` nor `/context/`, identical under
either schema number. Core has `/core/` with no `/context/`: schema 2 requires
exactly `overview.md`, `architecture.md`, `design.md`, and `progress.md`;
schema 3 additionally requires `session-notes.md`, `decisions-index.md`, and
`verified-index.md`. Standard has `/context/` with no `/core/`: schema 2
requires exactly `project-overview.md`, `architecture.md`, `build-plan.md`,
`code-standards.md`, `library-docs.md`, `ui-tokens.md`, `ui-rules.md`,
`ui-registry.md`, and `progress-tracker.md`; schema 3 additionally requires
`session-notes.md`, `decisions-index.md`, and `verified-index.md`. Schema-2
Core/Standard is a fully active, permanent classification, not a transitional
one — nothing requires migrating to schema 3.

Stop state-dependent work for competing authority, malformed/partial/duplicate
or unknown Banka markers, a non-exact `CLAUDE.md` beside an active schema, an
exact shim with missing authority, both state directories, tier mismatch, or
missing required tier files for the declared schema. A schema-2 Core/Standard
project already showing one or more of schema 3's three additional files is
mid-migration, not broken — stop and point to resuming or reverting the
migration (Protocol Section 3.2), never treat it as ordinary incomplete state
and never invent or discard content. Do not choose, repair, or normalize any
of these states.

Without a valid schema-2 or schema-3 block, recognize legacy Banka state only
when `CLAUDE.md` has the `# Project Operating Protocol` heading and exactly
one complete legacy tier shape, with or without an old AGENTS block pointing
to it. Legacy's Core/Standard shape coincides with schema 2's own file count,
but the two are distinguished by the marker, not the file count — check for a
valid schema block first. If neither an active schema nor recognizable legacy
state exists, treat the repository as unstructured/non-Banka — never assume
Minimal, never create Banka state
implicitly.

verify requires a state destination to write into, so its own legacy/missing-
state handling is stricter than the shared default: on legacy state, report
the classification and stop — never write. If neither an active schema nor
recognizable legacy state exists, stop; there is no destination to write to.

For active schema-3 Core/Standard: write to `core/verified-index.md` (Core)
or `context/verified-index.md` (Standard). Minimal, and schema-2
(pre-migration) Core/Standard, have no destination — verify does not run
there. For Minimal this is the same exclusion as the Logbook and the
threshold script (Sections 2.9 and 2.11): outgrowing "no extra files" is
itself the promotion signal. For schema-2 Core/Standard, state this plainly
and point to Section 3.2's optional migration to schema 3 rather than
inventing a destination or silently skipping the record.

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
actually reports. If the printed invocation itself looks mangled or has
unreadable escape sequences, that's a known re-quoting limitation in a
non-UTF-8 locale (see the script's own header note) — it doesn't mean the
check failed; read the verdict normally and carry the caveat into Step 3.

**What each verdict actually proves, and what it doesn't:** `MET` means the
specified evidence exists — a file is present, a diff touched a path, a
command exited `0`. It never means the claim is semantically or
behaviorally true. A `--run-test MET` confirms the command succeeded; it
does not confirm the test meaningfully exercises the claim being verified
— a vacuous or empty test would report the same `MET`. That gap is a
property of the project's own test, not something this step can add from
outside it; Step 1's refusal to invent a run command that isn't already
there is the same discipline applied earlier. Never present a `MET` as
proof the claim is correct — only as proof this specific evidence exists.

## Step 3 — Write the record

Append one row to `verified-index.md` with these fields:

- **ID** — the next sequential number.
- **Ticket/Plan** — the ticket number or charter-plan citation this traces to.
- **Commit** — the commit checked at.
- **Claims checked** — a one-line description.
- **Invocation** — the exact `--check-file`/`--check-diff`/`--run-test` line
  copied verbatim from the script's own output (e.g. `` `--check-file
  src/foo.ts` `` or `` `--check-diff core/design.md` ``) — never paraphrased,
  never re-typed from memory, so a future session can re-run the identical
  check. If the script's own output shows mangled or unreadable escape
  sequences (a non-UTF-8 locale re-quoting a non-ASCII path or command —
  see `verify-claims.sh`'s own header note), copy it exactly as shown anyway
  and flag it plainly as unreliable for copy-paste reuse — never silently
  clean it up into something that looks right, and never treat the mangled
  text as a sign the underlying check itself failed.
- **Verdict** — if the script's checks disagree, state the worst case:
  `MISSING` beats `MET`, `BLOCKED` beats a false `MET`, never round up.
- **Date.**

Re-run `scripts/check-banka-thresholds.sh` afterward so `verified-index.md`'s
own Threshold Check reflects what was just written. Once the table crosses
~2,000 words, start `overflow/verified/01-verified-index.md` (next:
`02-...`, same convention as `decisions-index.md`'s own pagination) and link
to it from the live table — this file's overflow is verify's own to
maintain, the same way `remember` maintains overflow only for the files it
writes.

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

Never write what you believe — write what the script showed, and record the
exact invocation that showed it. A verified record that can't be
mechanically re-derived is just another opinion with a timestamp — and a
`MET` that gets read as "correct" instead of "evidence found" is exactly
that opinion, wearing a mechanical record's authority it hasn't earned.
