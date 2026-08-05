---
name: survey
description: After building a feature (or evaluating a plan), verify it matches what was planned, respects the project's own declared architecture and standards, and is production-ready. Reports issues clearly, and points to whichever skill actually fits the problem found — /dredge for something broken, /watershed for a genuine judgment call worth more than one perspective — rather than treating every finding the same way.
---

Building is not done when the code runs. It is done when the code is correct — and "correct" is judged against what *this project itself* has declared, never a generic external assumption about what the project must be.

**First, resolve the project's structure:** check which folder exists. `/context/` → Standard tier — checks below span `context/architecture.md`, `context/code-standards.md`, `context/ui-tokens.md`, and `context/ui-rules.md` together; never check against only one and call it complete. `/core/` → Core tier — checks span `core/architecture.md` and `core/design.md` together. Neither → Minimal tier — check everything below against `CLAUDE.md`'s Project Overview section directly.

## What This Skill Does Not Do

It does not fix anything itself, and it does not treat every finding as equally urgent or equally the *right kind* of problem for this skill to close out — see Step 4.

---

## Step 1 — Understand What Should Have Been Built

Read in this order: the implementation plan from `/charter` if one exists, the feature description or task given, the resolved context file(s). If no plan exists, ask what the feature was supposed to do before reviewing — correctness can't be verified without knowing what correct looks like.

## Step 2 — Review in Three Layers

**Layer 1 — Does it match the plan?** Every part of the feature description present? Planning decisions reflected? Scope respected — nothing extra added uninvited? Flag anything planned-but-missing or built-but-not-planned.

**Layer 2 — Does it respect the system?** Architecture boundaries (right responsibility in the right place, per the resolved architecture file's System Boundaries). Design system compliance (correct tokens, no hardcoded values — per `ui-tokens.md`/`ui-rules.md`). Code standards (naming, structure, type discipline — per `code-standards.md`). No new pattern introduced where an established one should have been reused (check `ui-registry.md` for UI, existing conventions elsewhere).

**Layer 3 — Is it production ready?** Error handling — caught and handled, or silent failure? Edge cases — empty/loading/missing-data states? Obvious bugs a real user would hit?

**Sensitive-data severity:** if the resolved architecture file declares a security, encryption, or access-isolation invariant for this project, treat violations of *that specific declared invariant* as high priority findings — never assume a domain (e.g. "this handles sensitive data") that the project's own files didn't actually state.

## Step 3 — Report

```
## Review — [Feature Name]

### Layer 1 — Plan alignment
[PASS / ISSUES FOUND]

### Layer 2 — System integrity
[PASS / ISSUES FOUND]

### Layer 3 — Production readiness
[PASS / ISSUES FOUND]

### Summary
[X] issues found across [Y] layers.
```

Severity guide: **Critical** (architecture violations that break future features, missing error handling causing silent failures, planned functionality entirely missing) — fix before moving on. **Important** (design-system drift, code-standard violations, real edge cases) — fix soon. **Minor** (naming, missed optimizations, cosmetic) — fix when convenient.

## Step 4 — Route to the right next step, don't just hand back a list

A finding is not always the kind of thing this skill should try to resolve by itself listing it. Distinguish:

- **A checklist violation with an obvious fix** (wrong token used, missing validation, a naming inconsistency) — stays as a normal reported issue, per Step 3. The developer fixes it directly.
- **Something visibly broken — code runs but produces wrong behavior, or won't run at all** — recommend `/dredge` rather than trying to diagnose the failure mode here; that skill exists specifically to separate a targeted fix from a hard reset from a genuine rethink.
- **The implementation is "correct" against the plan, but the plan itself now looks like the wrong approach** — this is Failure Mode 3 territory (see `dredge`'s Rethink path) — say so plainly and point there, rather than approving code that faithfully executes a plan you now doubt.
- **A genuine judgment call where reasonable engineers would disagree, or the stakes are high enough that one perspective (even a careful one) isn't enough** — recommend `/watershed` for a wider, multi-angle pass instead of rendering a single verdict here.

State the recommendation plainly and why, then stop — do not invoke another skill automatically. The developer decides whether to follow the routing.

## Let the Developer Decide

Wait for the developer to ask for a specific fix, mark something intentional, or confirm resolution and move on. The developer owns the quality decision — this skill informs it.

## The Standard

The question is not "does it work?" It's "is it correct, against what this project actually says correct means?" — and, when correctness itself is in doubt, "who should look at this next?"
