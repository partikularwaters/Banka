---
name: remember
description: Save what matters at the end of a session so the next session picks up exactly where you left off. Or restore context at the start of a new session so nothing is lost between them — and never trust this conversation's own memory over what's actually on disk.
---

AI has no memory between sessions. Every new session starts blank. This skill fixes that — but the fix is the file on disk, never this conversation's own recollection of it, since another session may have touched the project since this conversation last looked.

## Context Contract

**Required:** the resolved session-state file(s) (tier-dependent — see
"Resolve Banka state first" below) · current git log/status, checked before trusting
this conversation · AGENTS.md/CLAUDE.md and the tier's required files, to
resolve state · on schema-3 Core/Standard, `scripts/check-banka-thresholds.sh`'s
output, invoked first and read every call, save and restore alike (Protocol
Section 2.9) — never trust a self-estimate of a section's size over the
actual count. Schema-2 pre-migration Core/Standard predates the script
(Section 3.2) and self-estimates instead, same as Minimal.

**Conditional:** IDEA-SCOPE.md and the rest of the tier's Source-of-truth
files, restore mode, when they exist · the resolved delegation queue, when
present · a legacy CLAUDE.md chain, read-only, restore mode only.

**Excluded by default:** any file outside the tier's declared Source of
truth · raw secret values, in any form, at any point.

**Outputs:** save mode — an updated session-state file, plus a one-line
confirmation · restore mode — a conversational restore summary.

**Write authority:** save mode only — the resolved session-state file(s), by
section (Minimal: the `AGENTS.md` block; schema-3 Core/Standard:
`progress.md`/`progress-tracker.md`, `session-notes.md`, and
`decisions-index.md`; schema-2 pre-migration Core/Standard, which has none
of those last two files: `progress.md`/`progress-tracker.md`'s own inline
Session Notes and Decisions Made sections instead — this project's
pre-Phase-2 shape, unchanged, never treated as broken or backfilled with
files it hasn't migrated to), plus whichever file owns a globally-scoped
fact a captured decision changes, plus the tier's `overflow/` files and
Overflow Index when the size thresholds above are crossed, plus the Logbook
(`decisions/`, schema-3 Core/Standard only — schema-2 pre-migration logs
decisions inline exactly as it always has) and its Decisions Index row for
a decision clearing Section 2.11's eligibility bar. Restore mode: none.

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

remember's own legacy handling splits by mode, unlike the shared default:
restore mode may inspect and report the legacy chain (it only reads), but
save mode must stop because it writes state. No Banka state may change until
an explicitly requested, previewed, and confirmed migration completes.

For active schema-3 Core/Standard, session state splits into three files
from day one (Protocol Section 4/5): task tracking in `core/progress.md` /
`context/progress-tracker.md`, thread-tagged narrative in
`core/session-notes.md` / `context/session-notes.md`, and the Logbook
routing table in `core/decisions-index.md` / `context/decisions-index.md`.
For schema-2 pre-migration Core/Standard, session state stays inline in
`progress.md`/`progress-tracker.md`'s own Session Notes and Decisions Made
sections, exactly as it always has — this is not a gap to fill, it's the
project's own unmigrated shape. Minimal session state stays in the Current
Status and Session Notes sections of the Banka-owned `AGENTS.md` block,
unchanged. If neither an active schema nor recognizable legacy state exists,
stop because no defined session-state destination exists. Never create one
implicitly.

## Security Boundary

Never persist secrets — API keys, tokens, passwords, private keys, cookies, connection strings, or any credential-like value. If useful but sensitive, store a redacted placeholder (`[REDACTED_API_KEY]`). If unsure, treat as sensitive and omit.

## How to Invoke

Claude Code: `/remember save` or `/remember restore`.
Codex: `$remember save` or `$remember restore`.
No argument given → ask which is meant.

---

## Save Mode

### Before writing anything: measure, then check for concurrent drift

On schema-3 Core/Standard, run `scripts/check-banka-thresholds.sh` first, before anything else — its report is the actual word counts, not an estimate. Read the resulting `## Threshold Check` block(s) so the rest of this save is informed by real numbers, not a guess about whether a section has gotten long. Schema-2 pre-migration Core/Standard predates the script (Section 3.2) and self-estimates instead, same as Minimal.

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
files by section; never replace any of them with a standalone memory document:

- **Minimal — Banka-owned `AGENTS.md` block:** update Current Status, Completed
  Actions, Known Issues / Open Decisions, Session Notes, and Next Immediate
  Step. Preserve all content outside the marked block.
- **Schema-3 Core — three files:** `core/progress.md` for Current Phase, Active
  Milestones, Completed Actions (plus its running total and Completed
  Archive Index once a phase archives — see Bloat prevention and correction
  below), Known Issues, and Next Immediate Step; `core/session-notes.md` for
  session narrative; `core/decisions-index.md` for the Decisions Index. A
  durable decision goes to the Logbook (`core/decisions/`) with a row in
  `core/decisions-index.md`, never an inline entry.
- **Schema-3 Standard — three files:** `context/progress-tracker.md` for Completed
  (plus its running total and Completed Archive Index once a phase
  archives — see Bloat prevention and correction below), In Progress, Up
  Next, Blocked, and Known Issues; `context/session-notes.md` for session
  narrative; `context/decisions-index.md` for the Decisions Index. A durable
  decision goes to the Logbook (`context/decisions/`) with a row in
  `context/decisions-index.md`, never an inline entry.
- **Schema-2 pre-migration Core/Standard — one file:**
  `progress.md`/`progress-tracker.md` alone, exactly as before this
  project's Section 4/5 file split. Update its inline Session Notes and
  Known Issues / Decisions Made sections directly, the same way Minimal's
  block is updated above. A durable decision stays a plain entry in the
  inline Decisions Made section — there is no Logbook here yet, and none of
  the write-authority or bloat-prevention rules below that name
  `session-notes.md`/`decisions-index.md` apply until Section 3.2's
  schema-2→3 migration runs.

When a captured decision changes a global invariant, architecture, token, or
other domain-owned fact, update the file that owns that fact rather than logging
the change only in session state. Preserve unrelated sections and prior durable
entries. Show a concise summary of proposed section changes before writing if
existing content would be replaced rather than appended or status-updated.

### Bloat prevention and correction

Before writing: promote durable, standing facts (architecture, invariants,
conventions) to the file that owns them, never log them here.

**Schema-3 Core/Standard — a durable decision carrying real reasoning worth
preserving goes to the Logbook (Protocol Section 2.11), never inline
here.** Write its Decision Record (`decisions/NNNN-title/decision.md` +
`rationale.md`), giving `decision.md` YAML frontmatter (`status`, `date`,
`governs`), and add a Decisions Index row whose title links to it. If it
supersedes an earlier Decision Record, mark that earlier record Superseded
in place: its `decision.md` prose status line becomes a real link to the
new record (`Superseded by [<NNNN>](../<new-NNNN>-title/decision.md)`),
while its `status` frontmatter field stays plain data (`Superseded by
<NNNN>`) since frontmatter isn't markdown-rendered. Also update its
Decisions Index row to link to the new record. The earlier record's
`rationale.md` is never rewritten, only the pointers to it.

**Schema-2 pre-migration Core/Standard has no Logbook yet** — a durable
decision stays a plain entry in `progress.md`/`progress-tracker.md`'s
inline Decisions Made section instead, mark a superseded entry
`[SUPERSEDED — see <new decision>]` in place there rather than opening a
Decision Record. Never create `decisions/` or `decisions-index.md` on an
unmigrated project — that would falsely present as an interrupted
migration the next time state is resolved.

**Minimal — no Logbook; decisions stay inline as before.** If a new
decision reverses an earlier one, mark the earlier entry
`[SUPERSEDED — see <new decision>]` in place.

Tag Session Notes entries by
the distinct line of work they belong to, not one flat narrative — a third
concurrently open thread gets a soft prompt to confirm it's genuinely
active; a fourth needs a stated one-line reason in writing before it's
tagged. Neither ever blocks.

Every save, check each tagged Session Notes thread independently (Minimal:
the `AGENTS.md` block's Session Notes section; schema-3 Core/Standard:
`core/session-notes.md` / `context/session-notes.md`; schema-2 pre-migration
Core/Standard: `progress.md`/`progress-tracker.md`'s own inline Session
Notes section — this thread-archival mechanism is part of the same Section
4/5 file split as the Logbook, so it doesn't apply here either until
migration): the moment one reaches a genuine settled boundary, archive it
immediately to `overflow/session-notes/` — do not wait for the file to also
cross a size threshold. A thread with no settled boundary stays live regardless of
size. The ~2,000-word figure (provisional, revise once real usage data
exists) is now only a fallback: if the file crosses it while nothing is
yet settled, flag it as oversized with no clean cut point and stop, rather
than forcing a split against unsettled work. An overflow file itself
crossing ~2,000 words — start the next sequentially numbered file in the
same subfolder. Always preview before applying. Each overflow file gets its
own short Contents note at the top; the live file's Overflow Index (file,
type, what it covers) tracks all of them, each entry a real link, and is
created the first time any of this fires.

**Core/Standard — Completed archives by phase boundary, not word count.**
The moment `**Current Phase:**` / `**Current phase:**` changes, the
*previous* phase's `Completed`/`Completed Actions` entries are now
permanently settled — archive them immediately to `overflow/completed/`
(next sequentially numbered file, same convention as Session Notes) and add
a row to the live file's `## Completed Archive Index` (`Phase | File |
Covers`, each a real link). A still-open phase's entries stay live
regardless of size — the same "never act against unsettled work" boundary
as Session Notes. The ~2,000-word figure is again only a fallback: if
`Completed`/`Completed Actions` crosses it while the phase is still open,
flag it oversized with no clean cut point and stop. **On schema-3
Core/Standard, never hand-update the running-total line next to Current
Phase** — it's a mechanical count (`scripts/check-banka-thresholds.sh`, run
first per the Save Mode step above), not a narrative one; after archiving,
re-run the script and copy its computed total in verbatim, the same as the
Threshold Check block itself. Schema-2 pre-migration Core/Standard predates
the script (Section 3.2) and self-counts instead. Unlike Session Notes or
the Decisions Index, this never needs its own file — the routing index
lives inside `progress.md`/`progress-tracker.md` itself. Minimal has no
In Progress/Up Next/Blocked split and defers this entirely to `scale`'s own
Minimal→Core threshold, same reasoning as the Logbook.

**Links, not paths.** Every pointer written here — an Overflow Index row, a
Decisions Index row, a Completed Archive Index row, an archived entry's
summary — is a real markdown link to the exact target, never a vague
description. Before archiving anything (a settled thread, a settled phase's
Completed entries, an overflow file rollover), search this project's own
Banka-generated files for links pointing at the path about to change and
update them in the same save — never move-and-hope.

Core/Standard's `decisions-index.md` paginates instead of archiving — once it
crosses ~2,000 words, start `overflow/decisions-index/01-decisions-index.md`
(next: `02-...`, Section 2.11) and link to it from the live table; rows
never get swept out for being old, since a decision
record stays exactly as useful to see years later as it was on day one.

If a resolved session-state file predates this convention, the rules
above still apply from this point forward — write the guidance above into
the file yourself (Minimal: under Session Notes; schema-3 Core/Standard:
`session-notes.md`) so the next session sees it too, rather than applying
it only in your own head this one time. This is distinct from a
schema-2 pre-migration Core/Standard project, which still has Session Notes
or a Decisions Made section inline in `progress.md`/`progress-tracker.md`
by design, not by predating a convention: leave that content exactly as it
is and keep logging there, per the schema-2 branches above — it does not
"just happen" once the project is regenerated or promoted. `session-notes.md`
and `decisions-index.md` become available only once Section 3.2's explicit,
previewed, confirmed schema-2→3 migration runs.

Confirm after writing: `Session state saved. Next session: invoke the remember skill in restore mode.`

---

## Restore Mode

### Step 1 — Check for drift before anything else

If version control is in use, run its equivalent of `git log --oneline -10` and `git status` immediately — even if the session-state file looks complete and current. **A project folder worked by more than one session can have real changes on disk that no saved state mentions yet.** Treat this as standing practice, not a one-off check triggered only when something seems wrong — the whole point is that a stale assumption looks exactly like a correct one until it's checked.

### Step 2 — Read everything available

On schema-3 Core/Standard, run `scripts/check-banka-thresholds.sh` and read
its `## Threshold Check` report before anything else — if something is
already over threshold and unaddressed, that's worth surfacing to the
developer immediately at restore, not discovered only at the next save.
Schema-2 pre-migration Core/Standard predates the script (Section 3.2) and
has no report to read here.

Read the resolved session-state file(s) first: the Banka-owned `AGENTS.md`
block's Current Status and Session Notes for Minimal; for schema-3 Core,
`core/progress.md`/`core/session-notes.md`/`core/decisions-index.md`
(`context/progress-tracker.md`/`context/session-notes.md`/
`context/decisions-index.md` for Standard); for schema-2 pre-migration
Core/Standard, `progress.md`/`progress-tracker.md` alone, since its inline
Session Notes and Decisions Made sections hold what the other two files
would otherwise carry. Under any active schema, also read every other file
listed in `AGENTS.md`'s Source of truth section. Under
readable legacy Core or Standard, read the files listed in legacy `CLAUDE.md`
instead and identify the restore as legacy. At every tier, read
`IDEA-SCOPE.md` when it exists. Also read the exact tier-resolved queue when
present: root `delegation-queue.md` for Minimal/Core, or
`context/delegation-queue.md` for Standard — including its Overflow Index, when
one exists, to know what's archived. Do not open a file listed in that index
unless the developer specifically asks about a completed ticket's detail; the
live queue's one-line summaries are enough for a normal restore. Do not scan
beyond these declared sources.

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
