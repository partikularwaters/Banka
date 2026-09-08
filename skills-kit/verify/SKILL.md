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
(on Core/Standard), append-only — never `survey`'s report, never code, never a
file another skill already owns.

## Resolve Banka state first

Before reading or writing project state, inspect `AGENTS.md`, the complete
contents of `CLAUDE.md`, `/core/`, `/context/`, and the required tier files.
A valid Banka block contains these comments exactly once, in order:
`<!-- BANKA:START -->`, `<!-- BANKA:STATE-SCHEMA: 2 -->` or
`<!-- BANKA:STATE-SCHEMA: 3 -->`, exactly one `<!-- BANKA:TIER: Minimal -->`,
`<!-- BANKA:TIER: Core -->`, or `<!-- BANKA:TIER: Standard -->`, then
`<!-- BANKA:END -->`. This Skills Kit operates schema 3 only.

Minimal has neither `/core/` nor `/context/`. Core has `/core/` only:
`overview.md`, `architecture.md`, `design.md`, `progress.md`,
`session-notes.md`, `decisions-index.md`, and `verified-index.md`.
Standard has `/context/` only: `project-overview.md`, `architecture.md`,
`build-plan.md`, `code-standards.md`, `library-docs.md`, `ui-tokens.md`,
`ui-rules.md`, `ui-registry.md`, `progress-tracker.md`, `session-notes.md`,
`decisions-index.md`, and `verified-index.md`.

Schema 2 has the same Minimal shape, or Core/Standard's original four/nine
files without `session-notes.md`, `decisions-index.md`, or `verified-index.md`.
If any of those three files exists with marker `2`, stop for interrupted
migration: resume Protocol Section 3.2 directly or restore from version
control. Do not route an interrupted migration to ordinary schema-2 skills.
For valid schema 2 at any tier, stop before this skill's operating steps and
use the refusal below. Schema 2 remains supported by its own release line;
never add files or change its marker merely to run this skill.

Stop for malformed, partial, duplicate, or unknown markers, tier/file-shape
mismatch, both state directories, missing required files, or competing
root authority. `CLAUDE.md`, when present, must be exactly `@AGENTS.md`.
A missing shim only disables Claude Code compatibility; it does not bypass
schema-2 refusal for runtimes that discover `AGENTS.md` directly.
Do not repair, merge, or normalize these states implicitly.

Without a valid schema block, recognize legacy state only from a
`CLAUDE.md` with `# Project Operating Protocol` and one complete original
tier shape. Legacy is compatibility-read-only until explicit migration.
An exact shim without valid `AGENTS.md` is broken authority, not legacy.
Without active or recognizable legacy state, treat the repository as
unstructured/non-Banka — never assume Minimal or create Banka state
implicitly.

**Schema-2 refusal:** This skill requires schema 3. There is no `verify-s2`; use `/survey-s2` or `$survey-s2` and gather the required evidence directly.
If unavailable, install the suffixed copies from the latest stable release
that explicitly supports schema 2. Alternatively, ask directly to migrate
using `protocol/Banka.md` Section 3.2 from a release supporting schema 3,
with a full preview and confirmation. Migration is a protocol task, not a
skill invocation; neither path runs automatically.

verify requires a state destination to write into, so its own legacy/missing-
state handling is stricter than the shared default: on legacy state, report
the classification and stop — never write. If neither an active schema nor
recognizable legacy state exists, stop; there is no destination to write to.

For Core, write to `core/verified-index.md`; for Standard, write to
`context/verified-index.md`. Minimal has no destination: stop and name
what evidence would resolve the claim without creating a record.

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

For committed file/diff evidence, invoke `scripts/verify-claims.sh --revision
<commit> --check-file <repository-relative-path>` or `--check-diff <path>`.
The output pins the full commit SHA; diff checks compare it with its first
parent. Missing commits or parents are BLOCKED, never reconstructed.

Run `--run-test` separately, without `--revision`. Uncommitted file/diff
checks also omit `--revision`. These are live observations: record the dirty
paths and relevant runtime/dependency details, and mark replay unavailable.
A commit SHA alone does not preserve dirty files or a test environment.
Never use a pinned check to claim an uncommitted change was verified.
Read the script's exact output.
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

Append rows to `verified-index.md` with these fields. Add Evidence scope to
older tables; mark prior rows `legacy observation — replay not established`
unless their inputs were explicitly pinned. Never infer preserved evidence.

- **ID** — the next sequential number.
- **Ticket/Plan** — the ticket number or charter-plan citation this traces to.
- **Commit** — the full SHA checked, or `unavailable` outside Git.
- **Evidence scope** — `commit-pinned` for revision-based file/diff checks;
  otherwise `live observation — replay unavailable`, with dirty paths and
  relevant runtime/dependency details. Keep different scopes in separate rows.
- **Claims checked** — a one-line description.
- **Invocation** — the exact flags, including `--revision <full-sha>` when used,
  copied verbatim from the script's own output (e.g. `` `--check-file
  src/foo.ts` `` or `` `--check-diff core/design.md` ``) — never paraphrased,
  never re-typed from memory. Pinned checks replay against the named Git
  objects while available; live invocations repeat the command only, not its
  historical inputs or result. If the script's own output shows mangled or unreadable escape
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
