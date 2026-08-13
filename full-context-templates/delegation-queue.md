<!-- Delegation queue: Junior-safe tickets written by the delegate skill for fresh-session execution -->

# Delegation Queue

This file is empty until the delegate skill is invoked against an approved charter plan. See the `delegate` skill for how tickets get written here.

**Rule for any session reading this file:** if you are picking up a delegated
ticket, execute *only* the ticket you were given. Confirm that the active
model/mode meets its `Required capability`; if the host does not expose that
information, ask the user to confirm it before starting. Do not read other
unstarted tickets or touch files outside what the ticket lists. If anything is
ambiguous or missing a value, stop and report the gap instead of guessing.

**Execution isolation:** in one checkout, run tickets serially and survey each
before another session edits the same working directory. Parallel execution
requires a separate Git worktree and branch per ticket. A fresh session isolates
conversation history; only a separate worktree isolates working files.

---

## Ready for fresh-session execution (Junior-safe)
_Empty. Populated by the delegate skill._

## Kept with the current session (Senior-required)
_Empty. Populated by the delegate skill._

## Full ticket specs
_Empty. Populated by the delegate skill._

## Completed
_Move tickets here once the survey skill has passed them, with the date and a one-line outcome note._

---

## Sample prompts for opening the next session

Copy whichever applies when starting a fresh session to work an item from this queue.

**Junior-safe ticket (fresh session, user-selected model):**
```
Read CLAUDE.md [and everything in /core/ or /context/, if applicable] in
this project. You're picking up a delegated ticket — per the "If you are
executing a delegated ticket" section in CLAUDE.md, open [the project-root
delegation-queue.md for Minimal/Core, or context/delegation-queue.md for
Standard] and read Ticket [N] under Full ticket specs. That ticket is your
entire scope.

Confirm that this session's active model/mode meets the ticket's Required
capability. A same or stronger model may execute a Junior-safe ticket. If the
host does not expose the active model/mode, ask me to confirm it before starting.

Confirm that no other session is editing this checkout. If this ticket is part
of parallel execution, confirm that this session has its own Git worktree and
branch before changing files.

Do not read or start any other ticket in the queue. Do not touch files
outside what Ticket [N] lists. If anything in it is ambiguous or needs a
value that isn't supplied, stop and report the gap — do not guess and
proceed. When done, report completion against its "Done when" condition
specifically, not just "it works."
```

**Senior-required item (senior-capability session):**
```
Invoke the remember skill in restore mode first — I want full current project
context, not just this one item. Confirm that this is not a Junior-only session;
if the active capability cannot be determined, ask me before starting.

This item was kept Senior-required in the tier-resolved delegation queue rather
than delegated, because: [the one-line reason the delegate skill gave].

It's part of the plan approved through the charter skill for [feature name]. Relevant
section of that plan:

[paste the specific plan section this item covers]

This wasn't written as a self-contained ticket — Senior-required items
aren't, by design. Treat it as open-ended within that plan's scope:
resolve judgment calls as they come up rather than expecting everything
pre-decided. Confirm you understand the item and its "why it's
Senior-required" reason before starting.
```
