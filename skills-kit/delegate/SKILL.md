---
name: delegate
description: After a plan is approved, break it into self-contained Junior-safe tickets for fresh-session execution and identify Senior-required work that needs stronger judgment. Writes to the tier-resolved delegation queue; model choice remains explicit and user-controlled.
---

Delegation only pays off if each ticket can be executed correctly by a fresh
session that has never seen this conversation and has no access to the reasoning
that produced the plan. Model capability and session separation are different:
a Junior-safe ticket may run on the same, a lighter, or a stronger model, while
Senior-required work must run in the user-selected senior-capability mode.

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

**Before finalizing the split, check for over-splitting.** "Smallest independently-executable unit" cuts both ways — two candidate items are not actually independent units just because they could technically be described separately. Merge two Junior-safe items into a single ticket when either holds:
- They touch the same file(s)
- One item's `Done when` condition cannot be verified true without the other item already being done — this is the "stated dependency" case from this step's opening paragraph, made concrete

Keep them as separate tickets when either holds instead — the separate survey checkpoint is worth the extra session, not overhead to eliminate:
- Each item's `Done when` condition is independently checkable on its own, with no dependency either direction
- Either item independently qualifies as Senior-required under the tier rules above — never merge a Senior-required item into a Junior-safe one to make it delegable; reclassify the whole merged unit as Senior-required instead

**After merging, re-run tier classification on the combined scope** — don't grandfather a merged ticket's tier in from its pre-merge pieces. Two individually Junior-safe items can merge into something cross-cutting enough to require Senior-required (touching multiple files/systems in a way that's easy to get subtly wrong is already a Senior-required trigger above).

**A merged ticket unions both source items' boundaries, not just one.** Its `Files to touch` and `Files to NOT touch` cover the combined set from both; its `Do not` list carries forward every boundary either item stated. Dropping one item's boundary because the other item's spec became the base is exactly the kind of silent gap this project's checkability standard exists to prevent.

State the tier and a one-line reason for every item, including the Senior-required ones — do not silently drop them from the queue, list them so the user knows what's intentionally being kept back. **State a one-line reason for every merge too**, the same way — "why is this one ticket, not two" should never require reverse-engineering from the merged ticket's shape.

---

## Step 2 — Write each Junior-safe item as a self-contained ticket

A ticket fails if the fresh session would need to ask a question to proceed. Before finalizing a ticket, apply the same checkability standard used everywhere else in this project: could a model with zero conversation memory read this ticket alone and produce the correct result?

Each ticket must include:

```markdown
### Ticket [N]: [short name]

**Tier:** Junior-safe
**Required capability:** Junior-safe or higher; a stronger model may execute this ticket
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

---

## Step 3 — Write the tier-resolved queue

Resolve the project before writing: `/context/` →
`context/delegation-queue.md`; `/core/` or `CLAUDE.md` → root
`delegation-queue.md`. If none exists, stop: this is not yet a Banka-enabled
project, so no queue destination is defined. Create the resolved file if it
doesn't exist. Append tickets — never silently overwrite a queue that already
has unstarted or in-progress items without telling the user what's being
replaced.

**Ticket numbers are append-only.** Never renumber or reuse a number already used in this file — not across separate delegate runs, and not when a merge collapses two candidates into one. A stable number is what lets a session-opening prompt point at "Ticket N" unambiguously (see the queue's own sample prompts); a number that can shift meaning defeats that.

For a merged ticket, the one-line spec summary in the checklist below must name both folded-in behaviors, not just the more prominent one — that line is often the only thing a future skim reads without opening the full spec.

```markdown
# Delegation Queue

Generated from: [feature/plan name] — [date]

## Ready for fresh-session execution (Junior-safe)
- [ ] Ticket 1: [name] — [one-line spec summary]
- [ ] Ticket 2: [name] — [one-line spec summary]

## Kept with the current session (Senior-required)
- [item] — [one-line reason]
- [item] — [one-line reason]

## Full ticket specs
[Full ticket blocks from Step 2, one per Junior-safe item]
```

---

## Step 4 — Confirm and hand off

Tell the user plainly what happens next — this skill does not open new sessions itself:

```
Delegation queue written: [N] tickets ready for a fresh session,
[M] items kept here because [tier reasoning].

For each ready ticket: open a fresh session using this host's normal
new-session mechanism, then point it at its ticket in the tier-resolved queue —
see that file's own sample prompts for the exact wording. Use a lighter model
only when this host offers one and the user has selected it; the same or a
stronger model may execute any Junior-safe ticket. Do not carry this
conversation's history into that session — a fresh session is the point.

At session start, confirm that the active model/mode meets the ticket's
`Required capability`. If the host does not expose that information, ask the
user to confirm it before starting. Never execute Senior-required work in a
Junior-only mode.

Unless the user has explicitly assigned separate Git worktrees and branches,
run tickets serially in a shared checkout. A fresh session alone does not make
parallel filesystem edits safe.

After each ticket completes, return to a senior-capability session and invoke
the survey skill on the result before marking it done.
```

Sample prompts for opening each kind of new session — one for a Junior-safe ticket, one for a Senior-required item — are kept in the delegation queue template, not restated here, so there's one copy to keep current instead of two.

---

## The Rule

A ticket that needs the reader to infer, guess, or ask is not a ticket — it's an unfinished plan wearing a ticket's format. Do the inferring here, while full context is available. Never pass ambiguity downstream to a session that has no way to resolve it except by guessing.
