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
If you are picking up a delegated ticket, execute *only* the ticket you were
given. Confirm that the active model/mode meets its `Required capability`; if
the host does not expose that information, ask the user to confirm it before
starting. Do not read other unstarted tickets or touch files outside what the
ticket lists. Stop only for unexplained drift, missing authority, an unmet
dependency, or a material ambiguity the ticket does not resolve.

**Execution isolation:** in one checkout, run tickets serially. After each
ticket returns, a senior-capability coordinator invokes Survey before marking it
complete and before another ticket edits the same shared checkout. Parallel
execution requires a separate Git worktree and branch per ticket. A fresh
session isolates conversation history; only a separate worktree isolates
working files.

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

## Completed
_Move tickets here once the survey skill has passed them, with the date and a one-line outcome note._

---

## Ready-to-paste handoff (Junior-safe, and Senior-required on request)

The delegate skill emits one complete block in this exact shape for every
ready Junior-safe ticket, in dependency order, and — this is the same
template, not a separate one — for a Senior-required ticket when the
coordinator asks for a handoff instead of executing it directly. It replaces
every bracketed field with the resolved project and ticket details; users do
not assemble a prompt from this template.

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

Verification commands: [exact Verification commands field from Ticket N].

Read Ticket [N]'s full spec in the queue before starting — it carries the
exact Done when condition this handoff does not repeat.

When finished, run every verification command above and report:
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

For one ready ticket, Delegate returns one handoff block. For zero, it
explains what work remains — Senior-required, Owner-required, or both — and
emits no empty prompt. The shared-checkout rule remains serial execution;
parallel execution requires a separate Git worktree and branch per ticket.
After each ticket returns, a senior-capability coordinator invokes Survey
before marking it complete and before another ticket edits the same shared
checkout.
