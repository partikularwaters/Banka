---
name: watershed
description: Get a wider, multi-angle critique of a piece of code, a plan, or an idea by evaluating it through five distinct critical perspectives, then a sixth pass that consolidates them into one clear, prioritized recommendation. Use when a decision is genuinely contested, high-stakes, or a single reviewer's perspective (even a careful one, like /survey) isn't enough.
argument-hint: [describe the code, plan, or idea to audit]
---

A single reviewer, however careful, has one perspective. Some decisions are worth more than that — not because the reviewer is bad at reviewing, but because different failure modes are visible from different angles, and a security-minded read misses what a maintainability-minded read catches, and neither catches what a real end-user's experience would.

This skill does not replace `/survey` (which checks against *this project's own declared rules*) or `/dredge` (which diagnoses a specific known failure). It's for the case where the question is genuinely open — a plan not yet committed to, a piece of code with no obvious single "correct" answer, an architectural fork where reasonable engineers would land in different places.

---

## Step 0 — Confirm what's being audited and why

Before running anything, be clear with the user: is this code, a plan/proposal, or an idea/direction? And what's the actual decision at stake — what would change depending on what this audit finds? An audit with no clear stake behind it just produces five opinions with nowhere to land.

## Step 1 — Read what's needed

Read the subject itself (`$ARGUMENTS`, or the most recent relevant work in this session), and this project's context files (architecture, code standards, ui-rules, etc., resolved by checking which folder exists — `/context/` for Standard tier, `/core/` for Core tier, or inline in `CLAUDE.md` for Minimal tier) so every persona below is grounded in this project's actual reality, not a generic one.

## Step 2 — Run five independent audits

Check whether this environment has a subagent- or parallel-task-dispatch tool available (something that can spawn a separate model call and return its result, distinct from just continuing this session). If one exists, use it: dispatch all five personas below as separate calls, run in parallel, each given the subject and context files read in Step 1 plus that persona's paragraph verbatim as its entire instruction. Wait for all five to return before Step 3. Dispatching them one at a time and calling it parallel doesn't count — if the tool can't actually run them concurrently, that's the fallback path below, not this one.

If no such tool exists, fall back: adopt each persona fully in turn, in this session, clearly labeled, and do not let one persona's conclusions leak into the next's framing before it's done.

Whichever path runs, Step 3's report states which one plainly — never left for the user to guess.

**A caveat that holds regardless of which path ran:** all five personas are the same underlying model reading the same context, differing only in which paragraph below they were given. That buys isolated framing and stops one lens from anchoring another — genuinely useful — but it is not the independence five different human reviewers would bring, and the report should not imply otherwise.

**1. The Skeptic — Security & Failure Modes**
Assumes the worst case. Where does this break under bad input, a malicious actor, a race condition, a dependency failing, or a value nobody thought to check? Every failure mode this persona finds gets stated as a concrete scenario, not a vague "could be more robust."

**2. The Minimalist — Simplicity & Scope**
Assumes the proposal is over-built until proven otherwise. What's here that wasn't actually asked for? What abstraction exists for a future need that may never come? Where would a simpler version lose nothing that actually matters right now?

**3. The User Advocate — Real-World Usability**
Ignores internal elegance entirely. Would an actual person, in the actual context this gets used, succeed at using this without confusion, without a support request, without giving up? What's technically correct but practically unusable?

**4. The Maintainer — Future-Session Continuity**
Assumes a different session — possibly a different, less capable model (see the `delegate` skill), possibly months later — has to pick this up with zero memory of today. Is intent documented, or only implementation? Would `ui-registry.md`/`progress-tracker.md`/naming actually prevent drift, or just look like they would?

**5. The Domain Enforcer — Project-Specific Correctness**
The strictest, most literal-minded persona. Checks purely against this project's own declared invariants, conventions, and prior decisions (its context files) — not general best practice, not the auditor's own taste. Where does this quietly contradict something this project already committed to?

Each persona produces a short, direct report — findings only, no hedging, no attempt to sound balanced. Disagreement between personas is expected and useful; do not soften a persona's view to make it agree with another's.

## Step 3 — Consolidate

Adopt a sixth role — **the Consolidator** — genuinely distinct from the five above: it doesn't generate new findings, it resolves and prioritizes the ones already produced.

```
## Audit — [Subject]

**Method:** [parallel subagent dispatch / sequential role-play in this session — state which one actually ran]

### Findings by perspective
[Brief, attributed summary from each of the 5 — not full reports, the headline of each]

### Where they agree
[Findings more than one persona independently raised — these carry the most weight]

### Where they conflict
[Named tensions — e.g. the Minimalist wants X removed, the Domain Enforcer says X is
required by an existing invariant. State the tension plainly; do not silently pick a
side without saying so.]

### Recommendation
[A clear, prioritized, actionable recommendation — not an average of five opinions,
an actual judgment call, with the reasoning for it stated openly, including which
persona's concern it prioritizes over which other one, and why.]
```

The Consolidator's job is to make a real recommendation, not to present five viewpoints and leave the user to referee them — that would just move the work of judgment onto the user instead of doing it.

## Step 4 — Hand back, don't act

Present the consolidated audit and stop. Do not implement the recommendation automatically — the user decides whether to follow it, and may reasonably weigh the tradeoffs differently than the Consolidator did.

## When not to reach for this

Don't use `/watershed` for routine checklist review (`/survey` does that faster and is usually sufficient) or for a specific, already-identified bug (`/dredge` diagnoses that directly). Reach for this when the actual question is "which direction is right," not "did we do the thing we already decided correctly."
