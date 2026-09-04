---
name: delegate
description: After a plan is approved, break it into self-contained Junior-safe tickets for fresh-session execution, Senior-required work that needs stronger judgment, and Owner-required work only the project owner can do. Tracks dependencies across all three and writes them to the tier-resolved delegation queue; model choice remains explicit and user-controlled.
---

Delegation only pays off if each ticket can be executed correctly by a fresh
session that has never seen this conversation and has no access to the reasoning
that produced the plan. Model capability and session separation are different:
a Junior-safe ticket may run on the same, a lighter, or a stronger model, while
Senior-required work must run in the user-selected senior-capability mode.

## Context Contract

**Required:** an approved implementation plan from `charter` — Step 0 stops
without one · the resolved architecture file, to check Absolute Invariants
and security/compliance boundaries when classifying each item's tier.

**Conditional:** the existing delegation queue, when it already has
unstarted or in-progress tickets — read before appending, never silently
overwritten · on Core/Standard, `scripts/check-banka-thresholds.sh`,
consulted before archiving and re-run after appending any ticket (Protocol
Section 2.9).

**Excluded by default:** anything outside the approved plan's scope — this
skill splits an already-approved plan, it does not re-plan.

**Outputs:** the written queue (three tier-grouped lists, full ticket specs
for all three, and a unified Execution Sequence showing every ticket's
dependencies across tiers), one ready-to-paste handoff block per Junior-safe
ticket in dependency order (or one batch handoff per assigned group of
consecutive Junior-safe tickets, when the coordinator chooses to batch — see
Step 4), and a plain checklist per Owner-required item — never a session
handoff, since no AI session executes those.

**Write authority:** the tier-resolved `delegation-queue.md` only — append
tickets with stable, never-reused numbers; never touch the code the tickets
describe.

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

delegate writes, so legacy state is stricter than the shared default: it may
be inspected, but delegate must not create or change a queue until an
explicitly requested, previewed, and confirmed migration completes.

Minimal and Core resolve to root `delegation-queue.md`; Standard resolves to
`context/delegation-queue.md`. Create the resolved queue only for active
schema 2. Append tickets — never silently overwrite a queue that already has
unstarted or in-progress items without telling the user what's being
replaced.

Fresh-session isolation covers conversation context, not working files. Banka's
safe default is **serial execution in one checkout**: finish and survey one
ticket (or self-check-and-advance through a batch, then survey the batch —
see Step 4) before another session edits the same working directory. Parallel
execution is allowed only when each session receives a separate Git worktree
and branch — one session may be assigned a single ticket or a batch of
consecutive Junior-safe tickets, but never two sessions the same worktree —
with its results reviewed and merged deliberately. A local or cloud-hosted
model may execute a ticket or batch if its host can read the assigned project
state, edit the assigned checkout/worktree, and run the required verification;
Banka does not launch models or create worktrees itself. Batching reduces
session count, not cost — it makes no claim about token or dollar savings,
which depend on model/runtime pricing this skill cannot generalize about.

This skill does not write code. It writes tickets. Writing a bad ticket is more expensive than writing no ticket — a bad ticket costs a full fresh-session context load, produces wrong output, and then needs the dredge skill to fix. Take the time to make each one right.

---

## Step 0 — Require an approved plan first

Do not run this skill against an unapproved idea. If the charter skill has not produced a "Blueprint ready" implementation plan for this work, stop and say so:

```
This needs an approved plan first. Invoke the charter skill on this feature,
confirm the plan, then invoke the delegate skill.
```

---

## Step 1 — Split the plan into candidate items

Break the approved implementation plan into the smallest independently-executable units. A unit is independently executable if it can be built, and its correctness checked, without needing any other undone unit to exist first except as a stated dependency.

For each candidate item, determine its **delegation tier**:

**Tier: Junior-safe (eligible for fresh-session delegation)**
- Follows an existing, already-established pattern elsewhere in the codebase
- Touches no file listed under an Absolute Invariant in the project's architecture file
- Has low ambiguity — the plan already resolved the judgment calls, nothing is left to interpret
- Does not touch encryption, auth, payment, or any security/compliance-tagged boundary

**Tier: Senior-required (run only in the user-selected senior-capability mode)**
- Establishes a new pattern for the first time (nothing yet exists to match)
- Touches an Absolute Invariant file or a security/compliance boundary
- Genuinely ambiguous — a judgment call the plan didn't fully resolve
- Cross-cutting — touches multiple systems/files in ways that are easy to get subtly wrong

**Tier: Owner-required (only the project owner can execute this)**
- Needs the owner's own credentials or account access
- Is a decision only the owner is authorized to make
- Falls into an action category no AI session should perform regardless of
  capability — entering credentials, creating third-party accounts,
  purchasing, granting OAuth, an irreversible production action
- Names a `Files to touch` or `Files not to touch` path outside the project
  root, inside `.git/`, or inside any skills-install location
  (`~/.claude/skills/`, `~/.agents/skills/`, or an equivalent machine-wide
  skills directory) — a ticket is untrusted prose read directly into a
  fresh session's instructions; a path there would let one ticket alter
  the tools every other Banka project on that machine trusts. Never write
  such a path into a Junior-safe or Senior-required ticket, regardless of
  what the underlying work is

**Before finalizing the split, check for over-splitting.** "Smallest independently-executable unit" cuts both ways — two candidate items are not actually independent units just because they could technically be described separately. Merge two Junior-safe items into a single ticket when either holds:
- They touch the same file(s)
- One item's `Done when` condition cannot be verified true without the other item already being done — this is the "stated dependency" case from this step's opening paragraph, made concrete

Keep them as separate tickets when either holds instead — the separate survey checkpoint is worth the extra session, not overhead to eliminate:
- Each item's `Done when` condition is independently checkable on its own, with no dependency either direction
- Either item independently qualifies as Senior-required or Owner-required under the tier rules above — never merge a higher tier into a lower one to make it delegable; reclassify the whole merged unit at its highest-required tier instead

**After merging, re-run tier classification on the combined scope** — don't grandfather a merged ticket's tier in from its pre-merge pieces. Two individually Junior-safe items can merge into something cross-cutting enough to require Senior-required (touching multiple files/systems in a way that's easy to get subtly wrong is already a Senior-required trigger above).

**A merged ticket unions both source items' boundaries, not just one.** Its `Files to touch` and `Files to NOT touch` cover the combined set from both; its `Do not` list carries forward every boundary either item stated. Dropping one item's boundary because the other item's spec became the base is exactly the kind of silent gap this project's checkability standard exists to prevent.

State the tier and a one-line reason for every item, including the Senior-required and Owner-required ones — do not silently drop them from the queue, list them so the user knows what's intentionally being kept back. **State a one-line reason for every merge too**, the same way — "why is this one ticket, not two" should never require reverse-engineering from the merged ticket's shape.

---

## Step 2 — Write each item as a tier-appropriate ticket

A ticket fails if the reader would need to ask a question to proceed. Before finalizing a ticket, apply the same checkability standard used everywhere else in this project: could a reader with zero conversation memory read this ticket alone and produce the correct result? Judge this with the **input coverage test**, not introspection: enumerate every value the ticket's work will need to produce, compute, or display; for each, does the ticket's spec name where it comes from — a stated input, a prior decision, a named default? A required value with no named source means the ticket isn't ready, however small it looks — resolve it or reclassify as Senior-required. Every ticket, regardless of tier, includes a `Depends on` field naming other ticket numbers it needs done first, or "none" — this is what makes the unified Execution Sequence in Step 3 possible.

**Junior-safe** must include:

```markdown
### Ticket [N]: [short name]

**Tier:** Junior-safe
**Required capability:** Junior-safe or higher; a stronger model may execute this ticket
**Depends on:** [other ticket numbers this needs done first, or "none"]
**Pattern to match:** [exact file/component to copy the shape of — never "follow best practices," always a real pointer]
**Files to touch:** [exact paths]
**Files to NOT touch:** [anything adjacent that must stay untouched]
**Spec:**
[Concrete, complete description — fields, behavior, exact function/handler names to
reuse. No open questions. If a value is needed and no default exists, this ticket
is not ready — resolve the value first or reclassify as Senior-required.]
**Done when:**
[Specific, checkable completion condition — not "it works," but e.g. "form
renders with these 4 fields, save button calls the existing save() handler,
matches BatchForm.tsx spacing and validation pattern."]
**Do not:**
[Explicit boundaries — e.g. "do not modify the encryption module," "do not
add new dependencies without flagging first"]
```

**Senior-required** must include:

```markdown
### Ticket [N]: [short name]

**Tier:** Senior-required
**Required capability:** senior-capability session
**Depends on:** [other ticket numbers this needs done first, or "none"]
**Precedent (if any):** [an existing file/pattern this partially resembles —
state "none" if this genuinely establishes a new pattern; that's expected here]
**Files to touch:** [exact paths]
**Files to NOT touch:** [anything adjacent that must stay untouched]
**Spec:**
[Concrete description — may explicitly name an open judgment call still to be
resolved during execution. That's expected here, unlike Junior-safe, where an
open question means the ticket isn't ready.]
**Done when:**
[Specific, checkable completion condition.]
**Do not:**
[Explicit boundaries.]
**Reason (Senior-required):** [one line — why this can't be Junior-safe]
```

**Owner-required** must include:

```markdown
### Ticket [N]: [short name]

**Tier:** Owner-required
**Depends on:** [other ticket numbers this needs done first, or "none"]
**Task:**
[Plain description of what the owner does in their own environment,
dashboard, or account — concrete enough to execute without asking a
question. No "Required capability" or "Pattern to match" — those are
AI-execution fields that don't apply to the owner.]
**Done when:**
[Specific, checkable completion condition.]
**Do not:** [only when a real boundary applies — e.g. "do not delete existing tables"; omit otherwise]
**Reason (Owner-required):** [one line — why no AI session can do this]
```

---

## Step 3 — Write the tier-resolved queue

**Ticket numbers are append-only.** Never renumber or reuse a number already used in this file — not across separate delegate runs, and not when a merge collapses two candidates into one. A stable number is what lets a session-opening handoff point at "Ticket N" unambiguously; a number that can shift meaning defeats that.

**Full ticket specs archiving.** Before appending, run `scripts/check-banka-thresholds.sh` (Core/Standard) and read its `## Full ticket specs` row — never estimate by eye; `delegate` is an independent write path into the same section `remember` governs, and self-estimation is exactly the failure mode this script exists to remove. If the mechanical count has crossed ~1,500–2,000 words, archive the oldest tickets already listed in `## Completed` (survey-passed) to the next sequentially numbered file in `overflow/delegation-tickets/` (creating the folder if it doesn't exist yet) — never an unstarted or in-progress ticket's spec, no matter how long the section gets. If no ticket is yet in `## Completed`, do not force an archive — flag the section as oversized with no archive-eligible ticket yet, and stop. Archiving relocates the full spec text only; it never renumbers, resequences, or otherwise touches the stable ticket number. Leave the archived ticket's one-line summary in `## Completed` with a real link (never a vague description) to the overflow file now holding its full spec, and add or update the queue's own `## Overflow Index` (file, ticket numbers covered, date archived) the first time this fires, each row a real link. Before archiving, search the queue and session-state for anything else linking to the ticket's old in-file location and update it in the same operation — reference integrity, not move-and-hope. Give the new overflow file its own short Contents note at its top, naming the ticket numbers it covers. Always preview this action before applying it, same as any other action on a real threshold. After appending any ticket, re-run the script so the queue's `## Threshold Check` row reflects reality, whether or not archiving fired this time.

For a merged ticket, the one-line spec summary in the checklist below must name both folded-in behaviors, not just the more prominent one — that line is often the only thing a future skim reads without opening the full spec.

```markdown
# Delegation Queue

Generated from: [feature/plan name] — [date]

## Ready for fresh-session execution (Junior-safe)
- [ ] Ticket 1: [name] — [one-line spec summary]
- [ ] Ticket 2: [name] — [one-line spec summary]

## Senior-required
- [ ] Ticket [N]: [name] — [one-line reason]

## Owner action required
- [ ] Ticket [N]: [name] — [one-line reason]

## Execution Sequence
| Step | Ticket | Tier | Depends on |
| --- | --- | --- | --- |
| 1 | Ticket 1 — [name] | Junior-safe | none |
| 2 | Ticket 2 — [name] | Senior-required | Ticket 1 |
| 3 | Ticket 3 — [name] | Owner-required | Ticket 2 |

Ordered so every ticket's dependencies appear before it, across all three
tiers — this is not the same grouping as the lists above, which group by
who executes, not by sequence.

## Full ticket specs
[Full ticket blocks from Step 2, one per item — all three tiers, not Junior-safe only.
Unstarted/in-progress tickets always in full. Once a completed ticket's spec is
archived, remove it from this section entirely — its one-line summary and
overflow pointer live in `## Completed` only.]

## Completed
[Survey-passed tickets: one-line summary, date, outcome — plus an overflow
pointer once the full spec has been archived.]

## Overflow Index
[Created only the first time archiving fires: file | ticket numbers covered | date archived]
```

---

## Step 4 — Confirm and hand off

After successfully writing the queue, return the queue result followed by one
complete, ready-to-paste handoff block for every Junior-safe ticket and one
checklist for every Owner-required ticket with no unmet dependency, all in
dependency order. Use this one reusable shape exactly — it also covers a
Senior-required ticket when the coordinator asks for a handoff instead of
executing it directly (see below); substitute each bracketed field from the
resolved project and its full ticket spec, Junior-safe's or Senior-required's
alike:

**Batching (optional, Junior-safe only).** Instead of one handoff per ticket,
the coordinator may assign a **batch** — several consecutive Junior-safe
tickets executed in one continued fresh session — using the Batch handoff
template below instead of one single-ticket handoff per ticket. A batch is
valid only when every ticket in it has its `Depends on` already satisfied
before the batch starts, or points to an earlier ticket in the *same* batch
— never a later one, never an unresolved ticket outside the batch. Cap a
batch at a provisional **4 tickets**: the executing session self-checks each
ticket against its own `Done when` condition and verification commands
before advancing to the next, which narrows risk but does not replace
`survey` — the more tickets stacked before the coordinator's single
end-of-batch survey runs, the more an issue `survey`'s three-layer review
would catch (an architecture-boundary violation, a silent failure mode) could
go unseen in the meantime. If any self-check fails or is ambiguous, the batch
stops immediately at that ticket — it does not guess, fix, or advance — and
reports which earlier tickets in the batch completed cleanly. Batching
reduces session count, not cost; it makes no claim about token or dollar
savings.

```text
Work in [exact project path].

You are executing Ticket [N] from the delegation queue:
[exact queue path]

Use a model meeting Ticket [N]'s [required capability] requirement; the owner
controls that selection outside this handoff. Read the queue introduction,
execution rules, and Ticket [N] only. Do not read or begin another ticket.

Dependency state: [satisfied dependency state, including any accepted
prerequisite outcome].

The coordinator session hands ownership of the shared checkout to this session
for Ticket [N]. No other implementation session is authorized to edit this
checkout until this ticket reports completion and returns ownership.

The accepted dirty baseline is: [exact accepted dirty files and their source,
or "none"]. These changes are accepted dependencies, not evidence of
concurrency. Dirty files, one worktree, absence of .git/index.lock, and
process inspection do not prove or disprove concurrent editing. Stop for an
unexplained changed path; do not stop for the accepted dirty baseline above.

Files to touch: [exact Files to touch field from Ticket N].

Files not to touch: [exact Files not to touch field from Ticket N].

Do not: [exact Do not field from Ticket N].

Read Ticket [N]'s full spec in the queue before starting — it carries the
exact Done when condition this handoff does not repeat.

When finished, run every verification command in Ticket [N] and report:
1. files changed;
2. completion against each Done when condition;
3. verification commands and results;
4. any unexpected drift, ambiguity, or remaining risk;
5. that checkout ownership is returned to the coordinator session.

Do not start another ticket. Do not create or switch worktrees unless explicitly
assigned. Do not expand beyond the resolved ticket. Stop only for unexplained
drift, missing authority, an unmet dependency, or a material ambiguity the
ticket does not resolve.
```

For a batch of consecutive Junior-safe tickets, use this shape instead of
one single-ticket handoff per ticket:

```text
Work in [exact project path].

You are executing a batch of tickets from the delegation queue:
[exact queue path]

Tickets in this batch, in order: [Ticket A, Ticket B, Ticket C, ...] (max 4).
Use a model meeting the highest [required capability] among them; the owner
controls that selection outside this handoff. Read the queue introduction,
execution rules, and only the tickets listed above — do not read or begin
any ticket outside this batch.

Dependency state: [satisfied dependency state for every ticket in this batch
that has a dependency outside the batch, including any accepted prerequisite
outcome — not just the first ticket's].

The coordinator session hands ownership of the shared checkout to this session
for this batch. No other implementation session is authorized to edit this
checkout until the batch reports completion and returns ownership.

The accepted dirty baseline is: [exact accepted dirty files and their source,
or "none"]. These changes are accepted dependencies, not evidence of
concurrency. Dirty files, one worktree, absence of .git/index.lock, and
process inspection do not prove or disprove concurrent editing. Stop for an
unexplained changed path; do not stop for the accepted dirty baseline above.

For each ticket in order:
1. Read that ticket's full spec in the queue — Files to touch, Files not to
   touch, Do not, and Done when. This handoff does not repeat them.
2. Implement it within those boundaries only.
3. Self-check it against its own Done when condition and every verification
   command it lists. If it passes, move to the next ticket in the batch. If
   it fails, or anything is ambiguous, or requires a value/decision the
   ticket doesn't supply — STOP the batch at this ticket. Do not guess, do
   not fix it yourself, and do not advance to the next ticket. Leave this
   ticket's partial edits exactly as they are in the working tree — do not
   revert them and do not attempt to complete them — and report them
   explicitly so the coordinator has the real evidence to work from.

When the batch ends — whether by completing every ticket or by stopping at a
failed/ambiguous self-check — report:
1. files changed, across all attempted tickets;
2. per ticket: completed-and-self-checked, or the point and reason it
   stopped;
3. verification commands run and their results, per ticket;
4. any unexpected drift, ambiguity, or remaining risk;
5. that checkout ownership is returned to the coordinator session.

Do not start any ticket outside this batch. Do not create or switch worktrees
unless explicitly assigned. A batch reporting fewer than all its tickets
completed is a normal, expected outcome, not a failure of the process.
```

For Owner-required, use this shape instead — no session capability applies, so it goes to the owner directly, not into a fresh-session prompt:

```text
Owner action required — Ticket [N]: [short name]

Task: [exact Task field from Ticket N].

Depends on: [exact Depends on field from Ticket N, resolved to current
state — e.g. "Ticket 3, completed 2026-08-24" or "none"].

Done when: [exact Done when field from Ticket N].

Do not: [exact Do not field from Ticket N, if any].

Mark this complete in the delegation queue once done, so any ticket
depending on it can proceed.
```

For Senior-required, do not assume either way — ask, per ticket with no
unmet dependency:

```text
Ticket [N] (Senior-required) is ready. Do you want to execute it in this
session, or should I generate a fresh-session handoff for it instead?
```

"Here" → proceed directly using Ticket [N]'s own contract as the spec; no
handoff is generated, and nothing about this exchange is written into the
queue. Executing "here" doesn't exempt this work from the standing rule:
invoke `remember` in save mode before the session ends, same as any other
in-progress work, so a future session isn't unaware this ticket is already
partially done. "Handoff" → generate the same template shown above,
substituting Ticket [N]'s Senior-required fields in place of Junior-safe's —
it is one reusable template, not a separate one per tier.

For one ready ticket, return one handoff block; for a batch, return one batch
handoff block covering all its tickets. For zero, say what work remains —
Senior-required, Owner-required, or both — and return no empty handoff
prompt. This skill never creates sessions, selects models, or creates
worktrees. In a shared checkout, tickets (or a batch) run serially; parallel
execution requires a separately assigned Git worktree and branch per assigned
unit — a single ticket or a batch — never two sessions in the same worktree.
After a single ticket returns, a senior-capability coordinator invokes Survey
before marking it complete and before another ticket edits the same shared
checkout. After a batch returns, the coordinator invokes Survey once over the
whole batch's cumulative diff before marking any of its completed tickets
done — the batch's own self-checks narrow risk but are not a substitute for
this pass.

---

## The Rule

A ticket that needs the reader to infer, guess, or ask is not a ticket — it's an unfinished plan wearing a ticket's format. Do the inferring here, while full context is available. Never pass ambiguity downstream to a session that has no way to resolve it except by guessing.
