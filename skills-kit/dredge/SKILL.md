---
name: dredge
description: When something goes wrong during a build — including when the report can't be reproduced at all — diagnose what type of failure it is before deciding how to respond. Targeted fix, hard reset, full rethink, or a reproduction gap — the right response depends on the right diagnosis.
---

Not every problem is a bug. Not every bug needs debugging. Diagnose the failure first, then prescribe the response — two separate steps, never swapped.

## Context Contract

**Required:** the user's failure description · once diagnosed, the
implicated file/function.

**Conditional:** an already resolved Banka classification, only in the Hard
Reset path, to determine how to phrase the next-session handoff · wider
codebase context, only if a first fix fails and re-diagnosis is needed.

**Excluded by default:** the codebase beyond what the diagnosis implicates ·
no upfront state-resolution matrix — dredge doesn't run one.

**Outputs:** a diagnosed failure mode with reasoning, plus a mode-specific
proposal held for confirmation — or, when reproduction itself can't be
confirmed, an `[OPEN — needs verification]` flag and a stop instead of a
proposal.

**Write authority:** none.

## Step 1 — Describe What Went Wrong

```
Describe what is wrong. Be specific:
- What did you expect to happen?
- What happened instead?
- How many times have you tried to fix it already?
```

The number of fix attempts matters — it distinguishes a fresh problem from a session that's already gone wrong.

## Step 2 — Identify the Failure Mode

**Mode 0 — Cannot reproduce.** The report describes a real interaction, but a genuine attempt to trigger it — following the same steps — does not produce the described behavior. → Not yet confirmed as any of the three modes below; diagnose the gap itself first. **Response: Reproduction diagnosis (Step 3D).**

**Mode 1 — A specific thing is broken.** Isolated, rest of the project works, first/second attempt, error is clear and specific. → Normal bug, root cause is findable. **Response: Targeted fix (Step 3A).**

**Mode 2 — The session has gone wrong.** Multiple fix attempts made things worse, code is tangled with fixes patching fixes, it's no longer clear what the original problem was. → The session itself is polluted; more prompting compounds the damage. **Response: Hard reset (Step 3B).**

**Mode 3 — The foundation is wrong.** Code runs but the behavior is fundamentally wrong — a misunderstood requirement, library API, or architectural pattern. Fixing individual pieces won't help because the approach itself is incorrect. **Response: Rethink (Step 3C).**

State which mode this is, and why, before proceeding.

## Step 3A — Targeted Fix

Get the exact error/behavior, the specific file/function, and expected-vs-actual. Read only what's directly relevant. State the root cause plainly (not the symptom), then the fix that addresses it — not a workaround. Wait for confirmation before changing anything.

If the fix doesn't work: stop. Don't suggest another fix immediately — the root cause diagnosis was probably wrong. Re-diagnose from scratch. Two wrong diagnoses in a row means this may actually be Mode 2 or 3.

## Step 3B — Hard Reset

Acknowledge plainly this isn't a failure, it's the correct response to a polluted context. Extract what's worth keeping (original feature intent, what's actually correct so far, what's been learned about what doesn't work) into a reset note. Instruct: save the note, end this session, and start fresh. If this conversation already has a safely resolved active or readable-legacy Banka classification, invoke the remember skill in restore mode there; otherwise let remember perform its own state resolution before deciding whether restore applies. Approach again with the reset note as context. Do not continue in this session.

## Step 3C — Rethink

Name the wrong assumption explicitly: what was assumed vs. what's actually true. Propose the correct approach, what gets discarded, what can be kept. Do not start rebuilding immediately — present the analysis and wait for the developer to agree.

**If, after this diagnosis, more than one plausible correct approach remains** — not just "the old approach was wrong" but genuine disagreement about what the right one is — suggest the watershed skill for a wider, multi-angle pass before committing to a direction, rather than picking one here on a single perspective.

## Step 3D — Reproduction Diagnosis

Check, in order:

1. **Same steps, exactly?** Re-walk the reported sequence literally, not from memory of what it probably meant — a skipped precondition or a slightly different path is the most common cause.
2. **Same environment/state?** Different data, different account/session state, different config, different browser or OS can make code genuinely correct in one place and genuinely broken in another.
3. **Transient or racy?** Something intermittent needs a different response entirely — you can't fix what you can't reliably trigger. Add logging/instrumentation instead of attempting a direct patch.

If one of these explains the gap, that's the actual finding — report it plainly (e.g., "this only reproduces with an empty cart, not a full one") and re-run Step 2 now that it's confirmed.

If none of them explain it and the behavior still won't reproduce: do not guess at a fix for something unconfirmed. Mark it `[OPEN — needs verification: exact repro steps, environment details, or a screenshot/log from when it occurred]` and stop. Report what was already tried and ruled out, so the next attempt doesn't repeat the same three checks.

## The Principle

The worst thing to do when something is broken is keep doing the same thing faster. Diagnose first. Different failures need different responses.
