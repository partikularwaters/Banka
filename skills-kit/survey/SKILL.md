---
name: survey
description: After building a feature (or evaluating a plan), verify it matches what was planned, respects the project's declared architecture and standards, and is production-ready. Reports issues clearly and routes broken behavior to dredge or contested judgment calls to watershed.
---

Building is not done when the code runs. It is done when the code is correct — and "correct" is judged against what *this project itself* has declared, never a generic external assumption about what the project must be.

## Context Contract

**Required:** the implementation plan from `charter`, if one exists, or the
feature description/task given · the resolved tier's declared files
(Standard: `architecture.md`, `code-standards.md`, `ui-tokens.md`, and
`ui-rules.md`, plus `ui-registry.md` for reuse checks; Core: `architecture.md`
and `design.md`; Minimal: the Banka-owned `AGENTS.md` block's Project
Overview).

**Conditional:** whether the resolved architecture file declares a security,
encryption, or access-isolation invariant — only then does Layer 3 treat a
violation as high severity, per its own Sensitive-data severity rule.

**Excluded by default:** repository content beyond the resolved tier files
and the supplied plan/task — survey does not invent invariants the project
never declared.

**Outputs:** a three-layer review report (Reviewer disclosure, then Plan
alignment / System integrity, each PASS or ISSUES FOUND, then Production
readiness, PASS / ISSUES FOUND / BLOCKED with a per-claim evidence ledger)
with a severity-graded issue list, and — when warranted — a routing
recommendation to `dredge` or `watershed`.

**Write authority:** none. It does not fix anything itself.

## Resolve Banka state first

Before reading project state, inspect `AGENTS.md`, the complete contents of
`CLAUDE.md`, `/core/`, `/context/`, and the required tier files. Active schema 2
requires one complete Banka block in `AGENTS.md` containing these exact comments
exactly once and in this order: `<!-- BANKA:START -->`,
`<!-- BANKA:STATE-SCHEMA: 2 -->`, exactly one of
`<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, or
`<!-- BANKA:TIER: Standard -->`, then `<!-- BANKA:END -->`. The declared tier
must match the filesystem shape and required files. `CLAUDE.md`
must be exactly `@AGENTS.md`; if it is missing, schema 2 is still active for a
runtime that discovers `AGENTS.md` directly, but report that Claude Code
compatibility is unavailable.

A matching Minimal shape has neither `/core/` nor `/context/`. Core has
`/core/` and its `overview.md`, `architecture.md`, `design.md`, `progress.md`,
`session-notes.md`, and `decisions-index.md`, with no `/context/`. Standard
has `/context/` and its `project-overview.md`, `architecture.md`,
`build-plan.md`, `code-standards.md`, `library-docs.md`, `ui-tokens.md`,
`ui-rules.md`, `ui-registry.md`, `progress-tracker.md`, `session-notes.md`,
and `decisions-index.md`, with no `/core/`.

Stop state-dependent work for competing authority, malformed/partial/duplicate
or unknown Banka markers, a non-exact `CLAUDE.md` beside schema 2, an exact shim
with missing authority, both state directories, tier mismatch, or missing
required tier files. Do not choose, repair, or normalize any of these states.

Without valid schema 2, recognize legacy Banka state only when `CLAUDE.md` has
the `# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old AGENTS block pointing to it. Legacy is
compatibility-read-only: report that classification and read its chain when
safe for the review, but do not change Banka state. Incomplete legacy state or
a broken old shim is a stop condition. If neither schema 2 nor recognizable
legacy state exists, treat the repository as unstructured/non-Banka, not
Minimal.

For active or safely readable legacy state, Standard checks span
`context/architecture.md`, `context/code-standards.md`,
`context/ui-tokens.md`, and `context/ui-rules.md`; Core checks span
`core/architecture.md` and `core/design.md`; Minimal checks the Project Overview
inside the Banka-owned `AGENTS.md` block for schema 2 or inside `CLAUDE.md` for
legacy. For an unstructured repository, review against the supplied task/plan
and relevant repository documentation, state that no Banka state was found,
and do not invent missing invariants.

## What This Skill Does Not Do

It does not fix anything itself, and it does not treat every finding as equally urgent or equally the *right kind* of problem for this skill to close out — see Step 4.

---

## Step 1 — Understand What Should Have Been Built

Read in this order: the implementation plan from the charter skill if one exists, the feature description or task given, and the resolved context file(s). If no plan exists, ask what the feature was supposed to do before reviewing — correctness can't be verified without knowing what correct looks like.

## Step 2 — Review in Three Layers

Apply the operational perspectives inside the existing three layers; do not add
a fourth layer or a separate perspective report. Use only the perspectives the
subject actually triggers.

**Layer 1 — Does it match the plan? Outcome Owner and User.** Every part of the
feature description present? Planning decisions reflected? Scope respected —
nothing extra added uninvited? Does the implemented end-to-end flow let the
intended user accomplish the recurring goal the plan named? Flag anything
planned-but-missing, built-but-not-planned, or technically present but unusable
in the real workflow.

**Layer 2 — Does it respect the system? Builder and Maintainer.** Architecture
boundaries (right responsibility in the right place, per the resolved
architecture file's System Boundaries). Design system compliance (correct
tokens, no hardcoded values — per `ui-tokens.md`/`ui-rules.md`). Code standards
(naming, structure, type discipline — per `code-standards.md`). No new pattern
introduced where an established one should have been reused (check
`ui-registry.md` for UI, existing conventions elsewhere). Could a future
session identify the intent, safely change the implementation, and keep any
nearby documentation or diagrams accurate, or is correctness hidden in
conversation memory or accidental complexity?

**Layer 3 — Is it production ready? User and Risk Owner.** Error handling —
caught and handled, or silent failure? Edge cases — empty/loading/missing-data
states? Obvious bugs a real user would hit? For every new code path or external
integration, state one realistic failure scenario and verify whether the user
can see the failure, the system preserves valid state, and recovery is defined.

**Layer 3's evidence ledger.** This skill is read-only — it never launches a
server, drives a browser, or exercises anything at runtime (see the Skill Does
Not Do note and Section 7's portability requirement: `survey`'s prose stays
self-contained and host-agnostic, it does not assume a specific host's
run/browser capability). So for each Layer 3 claim, decide from what's
actually readable — code, a test that exercises the path, or an already
observed/reported behavior — and record one of three verdicts, cited inline,
never asserted bare:
- **met** — cite the exact evidence (file:line, the test name, the observed
  behavior) that supports it.
- **missing** — the evidence shows it genuinely doesn't hold (a confirmed gap
  or bug); state what's wrong.
- **blocked** — the available evidence cannot settle it either way (no
  test exercises the path, no observed behavior on record, and reading the
  code alone can't prove runtime behavior). Name what would resolve it —
  invoke this environment's run capability, or a project's own run skill or
  script if one exists, then re-run this layer. Never mark a claim `met`
  because it "looks right in the code" alone.

`blocked` is not the same as routing to `dredge` — `dredge` is for a
*confirmed* defect. A blocked claim hasn't been shown broken, only
unresolved; don't escalate it as if it were a finding.

**Evidence discipline (Layers 1–2):** before marking Layer 1 or 2 `PASS` or
claiming that a risk is handled elsewhere, identify the code, test, observed
behavior, or declared project rule that supports the claim. If the available
evidence cannot settle it, report it as unverified rather than saying it is
probably safe or covered. (Layer 3 uses the finer-grained ledger above
instead of a bare PASS/unverified call.)

**Sensitive-data severity:** if the resolved architecture file declares a security, encryption, or access-isolation invariant for this project, treat violations of *that specific declared invariant* as high priority findings — never assume a domain (e.g. "this handles sensitive data") that the project's own files didn't actually state.

**Reviewer disclosure:** state in the report whether this review is running on the same model that produced the code under review — best effort, never guessed. If this session also did the build (the common case), that's directly known. If a fresh session has no way to verify who or what authored the code, state `unknown` rather than assuming either way. A same-model result is not disqualified — a self-review still catches real issues — but the developer deciding whether a second opinion is worth asking for needs this stated plainly, not left implicit.

## Step 3 — Report

```
## Review — [Feature Name]

**Reviewer:** [same model as this build / a different model / unknown — could not verify]

### Layer 1 — Plan alignment
[PASS / ISSUES FOUND]

### Layer 2 — System integrity
[PASS / ISSUES FOUND]

### Layer 3 — Production readiness
[PASS / ISSUES FOUND / BLOCKED]
- <claim> — met: <cited evidence> | missing: <what's wrong> | blocked: <what would resolve it>
- <claim> — met: <cited evidence> | missing: <what's wrong> | blocked: <what would resolve it>

### Summary
[X] issues found across [Y] layers. [Z claims blocked, pending runtime evidence — omit if none.]
```

Layer 3's overall verdict: `PASS` only if every claim is `met`. `ISSUES FOUND`
if any claim is `missing` — a confirmed problem always outranks an unresolved
one. `BLOCKED` only if no claim is `missing` but at least one is `blocked` —
nothing confirmed broken, but not fully verified either; state this plainly
rather than rounding it up to `PASS`.

Severity guide: **Critical** (architecture violations that break future features, missing error handling causing silent failures, planned functionality entirely missing) — fix before moving on. **Important** (design-system drift, code-standard violations, real edge cases) — fix soon. **Minor** (naming, missed optimizations, cosmetic) — fix when convenient.

## Step 4 — Route to the right next step, don't just hand back a list

A finding is not always the kind of thing this skill should try to resolve by itself listing it. Distinguish:

- **A checklist violation with an obvious fix** (wrong token used, missing validation, a naming inconsistency) — stays as a normal reported issue, per Step 3. The developer fixes it directly.
- **Something visibly broken — code runs but produces wrong behavior, or won't run at all** — recommend the dredge skill rather than trying to diagnose the failure mode here; it exists specifically to separate a targeted fix from a hard reset from a genuine rethink.
- **The implementation is "correct" against the plan, but the plan itself now looks like the wrong approach** — this is Failure Mode 3 territory (see `dredge`'s Rethink path) — say so plainly and point there, rather than approving code that faithfully executes a plan you now doubt.
- **A genuine judgment call where reasonable engineers would disagree, or the stakes are high enough that one perspective (even a careful one) isn't enough** — recommend the watershed skill for a wider, multi-angle pass instead of rendering a single verdict here.
- **A Layer 3 claim marked `blocked`** — not a finding of brokenness, so it doesn't route to `dredge` or `watershed` either. Name what would resolve it (runtime evidence this skill can't gather itself) and let the developer decide whether to gather it now or accept the gap.

State the recommendation plainly and why, then stop — do not invoke another skill automatically. The developer decides whether to follow the routing.

## Let the Developer Decide

Wait for the developer to ask for a specific fix, mark something intentional, or confirm resolution and move on. The developer owns the quality decision — this skill informs it.

## The Standard

The question is not "does it work?" It's "is it correct, against what this project actually says correct means?" — and, when correctness itself is in doubt, "who should look at this next?"
