---
name: watershed
description: Get a wider, multi-angle critique of code, a plan, or an idea through five distinct critical perspectives, followed by a sixth consolidation pass. Use when a decision is contested, high-stakes, or one careful survey is not enough.
argument-hint: [describe the code, plan, or idea to audit]
---

A single reviewer, however careful, has one perspective. Some decisions are worth more than that — not because the reviewer is bad at reviewing, but because different failure modes are visible from different angles, and a security-minded read misses what a maintainability-minded read catches, and neither catches what a real end-user's experience would.

This skill does not replace survey (which checks against *this project's own declared rules*) or dredge (which diagnoses a specific known failure). It's for the case where the question is genuinely open — a plan not yet committed to, a piece of code with no obvious single "correct" answer, an architectural fork where reasonable engineers would land in different places.

---

## Step 0 — Confirm what's being audited and why

Before running anything, be clear with the user: is this code, a plan/proposal, or an idea/direction? And what's the actual decision at stake — what would change depending on what this audit finds? An audit with no clear stake behind it just produces five opinions with nowhere to land.

## Step 1 — Read what's needed

Read the explicitly supplied subject, or the most recent relevant work in this
session if no subject was supplied. Before reading project state, inspect
`AGENTS.md`, the complete contents of `CLAUDE.md`, `/core/`, `/context/`, and
the required tier files. Active schema 2 requires one complete Banka block in
`AGENTS.md` containing these exact comments exactly once and in this order:
`<!-- BANKA:START -->`, `<!-- BANKA:STATE-SCHEMA: 2 -->`, exactly one of
`<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, or
`<!-- BANKA:TIER: Standard -->`, then `<!-- BANKA:END -->`. The declared tier
must match the filesystem shape and required files. `CLAUDE.md` must be exactly
`@AGENTS.md`; if it is missing, schema 2 is still active for a runtime that
discovers `AGENTS.md` directly, but report that Claude Code compatibility is
unavailable.

A matching Minimal shape has neither `/core/` nor `/context/`. Core has
`/core/` and its `overview.md`, `architecture.md`, `design.md`, and
`progress.md`, with no `/context/`. Standard has `/context/` and its
`project-overview.md`, `architecture.md`, `build-plan.md`, `code-standards.md`,
`library-docs.md`, `ui-tokens.md`, `ui-rules.md`, `ui-registry.md`, and
`progress-tracker.md`, with no `/core/`.

Stop state-dependent work for competing authority, malformed/partial/duplicate
or unknown Banka markers, a non-exact `CLAUDE.md` beside schema 2, an exact shim
with missing authority, both state directories, tier mismatch, or missing
required tier files. Do not choose, repair, or normalize any of these states.

Without valid schema 2, recognize legacy Banka state only when `CLAUDE.md` has
the `# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old AGENTS block pointing to it. Legacy is
compatibility-read-only: report that classification and read its chain when
safe for the audit, but do not change Banka state. Incomplete legacy state or a
broken old shim is a stop condition. If neither schema 2 nor recognizable
legacy state exists, treat the repository as unstructured/non-Banka, not
Minimal.

For active or safely readable legacy state, use `/context/` for Standard,
`/core/` for Core, and the Banka-owned `AGENTS.md` block for schema-2 Minimal or
legacy `CLAUDE.md` for legacy Minimal. For an unstructured repository, use the
supplied subject and relevant repository documentation, state that no Banka
state was found, and do not invent project-specific invariants.

## Step 2 — Run five independent audits

Check whether this environment has a subagent- or parallel-task-dispatch tool available (something that can spawn a separate model call and return its result, distinct from just continuing this session). If one exists, use it: dispatch all five perspectives below as separate calls, run in parallel, each given the subject and context files read in Step 1 plus that perspective's paragraph verbatim as its entire instruction. Wait for all five to return before Step 3. Dispatching them one at a time and calling it parallel doesn't count — if the tool can't actually run them concurrently, that's the fallback path below, not this one.

If no such tool exists, fall back: apply each perspective fully in turn, in this session, clearly labeled, and do not let one perspective's conclusions leak into the next's framing before it's done.

Whichever path runs, Step 3's report states which one plainly — never left for the user to guess.

**A caveat that holds regardless of which path ran:** all five perspectives are the same underlying model reading the same context, differing only in which paragraph below they were given. That buys isolated framing and stops one lens from anchoring another — genuinely useful — but it is not the independence five different human reviewers would bring, and the report should not imply otherwise.

**1. Outcome Owner — Purpose, Value & Scope**
Accountable for whether the subject achieves its intended purpose. Is this the right problem, or a proxy? Is the proposed scope the most direct path to the outcome? What should be held, reduced, or expanded, and what would happen if nothing were done? Reject both speculative additions and false minimalism; recommend the smallest scope that fully achieves the named outcome.

**2. User — Real-World Usability**
Accountable for whether a real person can accomplish the recurring goal in the actual operating context. Trace the end-to-end workflow. Where would the person become confused, blocked, misled by technically correct behavior, or unable to recover from a visible failure? Ignore internal elegance unless it changes the user's result.

**3. Builder — Architecture & Project-Specific Correctness**
Accountable for whether the system can be built correctly within this project's declared boundaries. Check architecture, data flow, interfaces, tests, technical completeness, and the project's own invariants and conventions. Identify decisions the proposal leaves for implementation to invent and any place general best practice is being substituted for project-specific truth.

**4. Maintainer — Future-Session Continuity**
Assumes a different session — possibly running a different user-selected model,
possibly months later — has to pick this up with zero memory of today. Is intent
documented, or only implementation? Would
`ui-registry.md`/`progress-tracker.md`/naming actually prevent drift, or just
look like they would?

**5. Risk Owner — Security, Failure & Recovery**
Accountable for preventing unacceptable failure. Where does this break under bad input, a malicious actor, a race condition, data loss, an irreversible action, a dependency failing, or a value nobody checked? State every material failure as a concrete scenario, identify its blast radius, and determine whether prevention, recovery, or explicit risk acceptance exists.

Each perspective produces a short, direct report — findings only, no hedging, no attempt to sound balanced. Disagreement between perspectives is expected and useful; do not soften one perspective's view to make it agree with another's.

## Step 3 — Consolidate

Adopt a sixth role — **the Consolidator** — genuinely distinct from the five above: it doesn't generate new findings, it resolves and prioritizes the ones already produced.

```
## Audit — [Subject]

**Method:** [parallel subagent dispatch / sequential role-play in this session — state which one actually ran]

### Findings by perspective
[Brief, attributed summary from each of the 5 — not full reports, the headline of each]

### Where they agree
[Findings more than one perspective independently raised — these carry the most weight]

### Where they conflict
[Named tensions — e.g. the Outcome Owner wants X removed as indirect scope, while
the Builder says X is required by an existing invariant. State the tension plainly;
do not silently pick a side without saying so.]

### Recommendation
[A clear, prioritized, actionable recommendation — not an average of five opinions,
an actual judgment call, with the reasoning for it stated openly, including which
perspective's concern it prioritizes over which other one, and why.]
```

The Consolidator's job is to make a real recommendation, not to present five viewpoints and leave the user to referee them — that would just move the work of judgment onto the user instead of doing it.

## Step 4 — Hand back, don't act

Present the consolidated audit and stop. Do not implement the recommendation automatically — the user decides whether to follow it, and may reasonably weigh the tradeoffs differently than the Consolidator did.

## When not to reach for this

Don't use watershed for routine checklist review (survey does that faster and is usually sufficient) or for a specific, already-identified bug (dredge diagnoses that directly). Reach for this when the actual question is "which direction is right," not "did we do the thing we already decided correctly."
