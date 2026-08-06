<!-- Delegation queue: tickets written by /delegate, executed by a lighter model in a fresh session -->

# Delegation Queue

This file is empty until `/delegate` is run against an approved `/charter` plan. See the `delegate` skill for how tickets get written here.

**Rule for any session reading this file:** if you are a lighter/fresh-session model picking up a ticket, execute *only* the ticket you were given. Do not read other unstarted tickets and do not touch files outside what the ticket lists. If anything in the ticket is ambiguous or missing a value you'd need to guess, stop and report the gap — do not guess and proceed. Guessing is exactly what this file exists to prevent.

---

## Ready for a fresh, lighter-model session
_Empty. Populated by `/delegate`._

## Kept with the current session (Senior-required)
_Empty. Populated by `/delegate`._

## Full ticket specs
_Empty. Populated by `/delegate`._

## Completed
_Move tickets here once `/survey` has passed them, with the date and a one-line outcome note._

---

## Sample prompts for opening the next session

Copy whichever applies when starting a fresh session to work an item from this queue.

**Junior-safe ticket (fresh session, lighter model):**
```
Read CLAUDE.md [and everything in /core/ or /context/, if applicable] in
this project. You're picking up a delegated ticket — per the "If you are
executing a delegated ticket" section in CLAUDE.md, open
delegation-queue.md and read Ticket [N] under Full ticket specs. That
ticket is your entire scope.

Do not read or start any other ticket in the queue. Do not touch files
outside what Ticket [N] lists. If anything in it is ambiguous or needs a
value that isn't supplied, stop and report the gap — do not guess and
proceed. When done, report completion against its "Done when" condition
specifically, not just "it works."
```

**Senior-required item (fresh session, same or stronger model):**
```
Run /remember restore first — I want full current project context, not
just this one item.

This item was kept Senior-required in delegation-queue.md rather than
delegated, because: [the one-line reason /delegate gave].

It's part of the plan approved via /charter for [feature name]. Relevant
section of that plan:

[paste the specific plan section this item covers]

This wasn't written as a self-contained ticket — Senior-required items
aren't, by design. Treat it as open-ended within that plan's scope:
resolve judgment calls as they come up rather than expecting everything
pre-decided. Confirm you understand the item and its "why it's
Senior-required" reason before starting.
```
