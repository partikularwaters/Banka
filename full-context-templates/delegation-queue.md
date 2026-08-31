<!-- Delegation queue: Junior-safe tickets written by the delegate skill for fresh-session execution -->

# Delegation Queue

This file is empty until the delegate skill is invoked against an approved charter plan. See the `delegate` skill for how tickets get written here.

**Rule for any session reading this file:** resolve queue placement from a valid
schema-2 `AGENTS.md` authority whose comments occur exactly once and in this
order:

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Minimal -->
<!-- BANKA:END -->
```

The third comment is exactly one of `<!-- BANKA:TIER: Minimal -->`,
`<!-- BANKA:TIER: Core -->`, or `<!-- BANKA:TIER: Standard -->`; it must match
the tier shape. Resolve to root
`delegation-queue.md` for Minimal/Core or `context/delegation-queue.md` for
Standard. A legacy `CLAUDE.md` project is compatibility-read-only, so do not
write a queue until its explicit, previewed, and confirmed migration completes.
If you are picking up a delegated ticket, execute *only* the ticket (or, for a
batch, only the tickets) you were given. Confirm that the active model/mode
meets its `Required capability` (the highest among a batch's tickets); if the
host does not expose that information, ask the user to confirm it before
starting. Do not read other unstarted tickets, or any ticket outside an
assigned batch, or touch files outside what the ticket(s) list. Stop only for
unexplained drift, missing authority, an unmet dependency, or a material
ambiguity the ticket does not resolve — in a batch, this stops the batch, not
just the current ticket.

**Execution isolation:** in one checkout, run tickets serially. After a single
ticket returns, a senior-capability coordinator invokes Survey before marking
it complete and before another ticket edits the same shared checkout. For a
batch (several consecutive Junior-safe tickets assigned to one session — see
`delegate`'s batch handoff), the executing session self-checks each ticket
against its own Done when condition before advancing to the next, and the
coordinator invokes Survey once over the whole batch's cumulative diff before
marking any of its tickets done — self-checks narrow risk but are not a
substitute for that pass. Parallel execution requires a separate Git worktree
and branch per assigned unit — a single ticket or a batch, never two sessions
in the same worktree. A fresh session isolates conversation history; only a
separate worktree isolates working files. Batching reduces session count, not
cost — it is not a token or dollar savings mechanism.

---

## Ready for fresh-session execution (Junior-safe)
_Empty. Populated by the delegate skill._

## Senior-required
_Empty. Populated by the delegate skill. Execution mode (current session or
fresh-session handoff) is decided per ticket at Step 4 time, not fixed here._

## Owner action required
_Empty. Populated by the delegate skill._

## Execution Sequence
_Empty. Populated by the delegate skill — one row per ticket across all
three tiers, ordered so every ticket's dependencies appear before it._

## Full ticket specs
_Empty. Populated by the delegate skill._

**Keeping this section lean:** an unstarted or in-progress ticket's full spec
always stays here in full, no matter how long the section gets — never
archive live work. Once this section crosses ~1,500–2,000 words, archive the
oldest *completed* tickets' full specs to the next sequentially numbered file
in `overflow/delegation-tickets/` (creating the folder if it doesn't exist
yet), leaving each archived ticket's one-line summary in `## Completed` below
with a pointer to the file that now holds its full spec. If no ticket is yet
in `## Completed`, do not force an archive — flag the section as oversized
with no archive-eligible ticket yet, and stop. Ticket numbers never
change when a spec is archived. Add or update the Overflow Index the first
time this fires:

## Overflow Index
| File | Type | Covers |
| --- | --- | --- |
| `overflow/delegation-tickets/01-delegation-tickets.md` | completed ticket detail | [ticket numbers, date archived] |

Each overflow file carries its own short Contents note at its own top, naming
which ticket numbers it covers, so it can be found without reading it in full.

## Completed
_Move tickets here once the survey skill has passed them, with the date and a
one-line outcome note. Once a ticket's full spec is archived (see above),
add a pointer to the overflow file that holds it — e.g. "full spec:
`overflow/delegation-tickets/01-delegation-tickets.md`"._

---

## Ready-to-paste handoff (Junior-safe, and Senior-required on request)

The delegate skill emits one complete block in this exact shape for every
ready Junior-safe ticket, in dependency order, and — this is the same
template, not a separate one — for a Senior-required ticket when the
coordinator asks for a handoff instead of executing it directly. It replaces
every bracketed field with the resolved project and ticket details; users do
not assemble a prompt from this template.

**Batching (optional, Junior-safe only).** Instead of one handoff per ticket,
the coordinator may assign a batch — several consecutive Junior-safe tickets
executed in one continued fresh session — using the Batch handoff template
below. A batch is valid only when every ticket in it has its `Depends on`
already satisfied before the batch starts, or points to an earlier ticket in
the same batch. Cap a batch at a provisional 4 tickets. The executing session
self-checks each ticket against its own `Done when` condition and
verification commands before advancing; a failed or ambiguous self-check
stops the batch at that ticket rather than guessing or advancing. Batching
reduces session count, not cost.

```
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

```
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

## Owner-required checklist

For Owner-required tickets, the delegate skill emits this shape instead — no
session capability applies, so it goes to the owner directly, not into a
fresh-session prompt:

```
Owner action required — Ticket [N]: [short name]

Task: [exact Task field from Ticket N].

Depends on: [exact Depends on field from Ticket N, resolved to current
state — e.g. "Ticket 3, completed 2026-08-24" or "none"].

Done when: [exact Done when field from Ticket N].

Do not: [exact Do not field from Ticket N, if any].

Mark this complete in the delegation queue once done, so any ticket
depending on it can proceed.
```

For one ready ticket, Delegate returns one handoff block; for a batch, one
batch handoff block covering all its tickets. For zero, it explains what work
remains — Senior-required, Owner-required, or both — and emits no empty
prompt. The shared-checkout rule remains serial execution; parallel execution
requires a separate Git worktree and branch per assigned unit — a single
ticket or a batch, never two sessions in the same worktree. After a single
ticket returns, a senior-capability coordinator invokes Survey before marking
it complete and before another ticket edits the same shared checkout. After a
batch returns, the coordinator invokes Survey once over the whole batch's
cumulative diff before marking any of its completed tickets done.
