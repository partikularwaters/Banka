---
name: dredge
description: When something goes wrong during a build, diagnose what type of failure it is before deciding how to respond. Targeted fix, hard reset, or full rethink — the right response depends on the right diagnosis.
---

Not every problem is a bug. Not every bug needs debugging. Diagnose the failure first, then prescribe the response — two separate steps, never swapped.

## Step 1 — Describe What Went Wrong

```
Describe what is wrong. Be specific:
- What did you expect to happen?
- What happened instead?
- How many times have you tried to fix it already?
```

The number of fix attempts matters — it distinguishes a fresh problem from a session that's already gone wrong.

## Step 2 — Identify the Failure Mode

**Mode 1 — A specific thing is broken.** Isolated, rest of the project works, first/second attempt, error is clear and specific. → Normal bug, root cause is findable. **Response: Targeted fix (Step 3A).**

**Mode 2 — The session has gone wrong.** Multiple fix attempts made things worse, code is tangled with fixes patching fixes, it's no longer clear what the original problem was. → The session itself is polluted; more prompting compounds the damage. **Response: Hard reset (Step 3B).**

**Mode 3 — The foundation is wrong.** Code runs but the behavior is fundamentally wrong — a misunderstood requirement, library API, or architectural pattern. Fixing individual pieces won't help because the approach itself is incorrect. **Response: Rethink (Step 3C).**

State which mode this is, and why, before proceeding.

## Step 3A — Targeted Fix

Get the exact error/behavior, the specific file/function, and expected-vs-actual. Read only what's directly relevant. State the root cause plainly (not the symptom), then the fix that addresses it — not a workaround. Wait for confirmation before changing anything.

If the fix doesn't work: stop. Don't suggest another fix immediately — the root cause diagnosis was probably wrong. Re-diagnose from scratch. Two wrong diagnoses in a row means this may actually be Mode 2 or 3.

## Step 3B — Hard Reset

Acknowledge plainly this isn't a failure, it's the correct response to a polluted context. Extract what's worth keeping (original feature intent, what's actually correct so far, what's been learned about what doesn't work) into a reset note. Instruct: save the note, end this session, start fresh, `/remember restore` if memory exists, approach again with the reset note as context. Do not continue in this session.

## Step 3C — Rethink

Name the wrong assumption explicitly: what was assumed vs. what's actually true. Propose the correct approach, what gets discarded, what can be kept. Do not start rebuilding immediately — present the analysis and wait for the developer to agree.

**If, after this diagnosis, more than one plausible correct approach remains** — not just "the old approach was wrong" but genuine disagreement about what the right one is — that's a good moment to suggest `/watershed` for a wider, multi-angle pass before committing to a direction, rather than picking one here on a single perspective.

## The Principle

The worst thing to do when something is broken is keep doing the same thing faster. Diagnose first. Different failures need different responses.
