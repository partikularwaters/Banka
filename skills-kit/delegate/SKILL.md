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
overwritten.

**Excluded by default:** anything outside the approved plan's scope — this
skill splits an already-approved plan, it does not re-plan.

**Outputs:** the written queue (three tier-grouped lists, full ticket specs
for all three, and a unified Execution Sequence showing every ticket's
dependencies across tiers), one ready-to-paste handoff block per Junior-safe
ticket in dependency order, and a plain checklist per Owner-required item —
never a session handoff, since no AI session executes those.

**Write authority:** the tier-resolved `delegation-queue.md` only — append
tickets with stable, never-reused numbers; never touch the code the tickets
describe.

Fresh-session isolation covers conversation context, not working files. Banka's
safe default is **serial execution in one checkout**: finish and survey one
ticket before another session edits the same working directory. Parallel ticket
execution is allowed only when each session receives a separate Git worktree
and branch, with its results reviewed and merged deliberately. A local or
cloud-hosted model may execute a ticket if its host can read the assigned
project state, edit the assigned checkout/worktree, and run the required
verification; Banka does not launch models or create worktrees itself.

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

A ticket fails if the reader would need to ask a question to proceed. Before finalizing a ticket, apply the same checkability standard used everywhere else in this project: could a reader with zero conversation memory read this ticket alone and produce the correct result? Every ticket, regardless of tier, includes a `Depends on` field naming other ticket numbers it needs done first, or "none" — this is what makes the unified Execution Sequence in Step 3 possible.

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

Resolve the project with the schema-2 authority and tier contract before
writing. `AGENTS.md` must contain one valid schema-2 Banka block with these
comments exactly once and in this order:

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Minimal -->
<!-- BANKA:END -->
```

The third comment is exactly one of `<!-- BANKA:TIER: Minimal -->`,
`<!-- BANKA:TIER: Core -->`, or `<!-- BANKA:TIER: Standard -->`. Its declared
tier must match the verified filesystem shape, and any present `CLAUDE.md` must
be exactly `@AGENTS.md`.

A matching Minimal shape has neither `/core/` nor `/context/`. Core has
`/core/` and its `overview.md`, `architecture.md`, `design.md`, and
`progress.md`, with no `/context/`. Standard has `/context/` and its
`project-overview.md`, `architecture.md`, `build-plan.md`, `code-standards.md`,
`library-docs.md`, `ui-tokens.md`, `ui-rules.md`, `ui-registry.md`, and
`progress-tracker.md`, with no `/core/`.

Minimal and Core resolve to root
`delegation-queue.md`; Standard resolves to `context/delegation-queue.md`.

Legacy `CLAUDE.md` authority is compatibility-read-only: it may be inspected,
but Delegate must not create or change a queue until the explicit, previewed,
and confirmed migration has completed. Stop rather than choosing a destination
when root authority is missing or broken, Banka metadata competes or is
malformed, both `/core/` and `/context/` exist, or the tier and storage shape
disagree. Create the resolved queue only for active schema 2. Append tickets —
never silently overwrite a queue that already has unstarted or in-progress
items without telling the user what's being replaced.

**Ticket numbers are append-only.** Never renumber or reuse a number already used in this file — not across separate delegate runs, and not when a merge collapses two candidates into one. A stable number is what lets a session-opening handoff point at "Ticket N" unambiguously; a number that can shift meaning defeats that.

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
[Full ticket blocks from Step 2, one per item — all three tiers, not Junior-safe only]
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

For one ready ticket, return one handoff block. For zero, say what work
remains — Senior-required, Owner-required, or both — and return no empty
handoff prompt. This skill never creates sessions, selects models, or creates
worktrees. In a shared checkout, tickets run serially; parallel execution
requires a separately assigned Git worktree and branch for each session.
After each ticket returns, a senior-capability coordinator invokes Survey
before marking it complete and before another ticket edits the same shared
checkout.

---

## The Rule

A ticket that needs the reader to infer, guess, or ask is not a ticket — it's an unfinished plan wearing a ticket's format. Do the inferring here, while full context is available. Never pass ambiguity downstream to a session that has no way to resolve it except by guessing.
