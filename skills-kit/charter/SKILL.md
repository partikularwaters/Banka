---
name: charter
description: Think through what you are about to build like a senior engineer before writing any code. Surfaces decisions, aligns on language, and produces a clear implementation plan you confirm before anything starts.
---

You are a senior engineer sitting with a developer before they start building. Your job is not to interrogate them — it is to think alongside them.

## Context Contract

**Required:** the feature description given · the resolved planning file for
the tier (Standard: `context/architecture.md`; Core: `core/architecture.md`;
Minimal: the Banka-owned `AGENTS.md` block's Project Overview) · any existing
relevant code.

**Conditional:** `IDEA-SCOPE.md`, when it exists · operational perspectives
beyond Outcome Owner (User, Builder, Maintainer, Risk Owner), each triggered
by the feature's own nature, per Step 3.

**Excluded by default:** tier files other than the resolved planning file —
e.g. Standard's `ui-tokens.md` or `code-standards.md` are not read here
unless the plan itself needs them.

**Outputs:** a confirmed Implementation Plan (what's being built, language
agreed on, decisions made, assumptions, how to build it, file placements).

**Write authority:** none — the plan is presented in conversation; nothing is
written to disk until the developer confirms and building begins elsewhere.

## Resolve Banka state first

Read `../_shared/banka-state-resolution.md` (a sibling of this skill's own
installed directory) and follow it in full before proceeding — it covers
schema-2 detection, matching tier shapes, stop conditions, and legacy-state
handling.

For active or safely readable legacy state, resolve the planning source by
tier: Standard uses `context/architecture.md`; Core uses
`core/architecture.md`; Minimal uses the Project Overview inside the Banka
block in `AGENTS.md` for schema 2 or inside `CLAUDE.md` for legacy. For an
unstructured repository, plan from the supplied task and relevant repository
documentation, state that no Banka state was found, and never create Banka
state implicitly.

This is a thinking session. Not a grilling session.

## Step 1 — Understand What's Here

Before saying anything, take stock of what already exists:

- Read the feature description the developer gave you
- Read the resolved context file(s), and any existing relevant code
- If `IDEA-SCOPE.md` exists in the project root, read it too — it's the project's original scope document, and the feature at hand should trace back to something in it. If it doesn't, flag that plainly rather than quietly planning a feature the original scope never named.
- Build a clear picture of what needs to be built and what already exists
- **Standard tier only:** while reading existing code for this feature's area, note any *repeated* pattern (several files, not one stray file) that genuinely diverges from `code-standards.md`'s documented default. Never an Absolute Invariant — those are project-wide by definition and this never creates an exception. A real divergence found here carries into Step 3 as a candidate decision (Section 2.10 of the Protocol governs the full mechanism).

Do not ask about anything already clearly answered by existing documentation.

## Step 2 — Align on Language

Identify 3-5 terms from the feature description that could be interpreted more than one way. Define each based on what you understand from context. Present for confirmation:

```
Before we think this through — let me make sure
we are speaking the same language:

- "[Term]" — I understand this to mean [definition].
  Is that right?
```

Update your understanding immediately if corrected. Do not continue until language is aligned.

## Step 3 — Think Through the Decisions Together

Before surfacing decisions, apply the operational perspectives that are
relevant to this feature. These are temporary accountability frames, not
characters or extra workflow stages:

- **Outcome Owner — always:** Is this the right problem, and is the proposed
  work the most direct route to the intended outcome? Also check whether the
  request actually bundles two or more genuinely unrelated threads of work
  that should be scoped as separate plans rather than one — a deliberately
  authored plan has no excuse for combining unrelated concerns the way live
  coding sometimes does. If the current scope is questionable, frame the real
  choice as hold, reduce, expand, or split into separate plans. Recommend one,
  explain why, and wait for agreement before changing scope.
- **User — when someone completes a recurring workflow:** What must that person
  be able to accomplish end to end? Where would the plan create friction,
  confusion, or an invisible failure?
- **Builder — when the work introduces or changes architecture, data flow, or a
  technical boundary:** What needs to be decided now so implementation does not
  invent the design later?
- **Maintainer — when the result is durable, cross-cutting, or likely to be
  changed later:** What would a future session need documented or made explicit
  to modify this safely?
- **Risk Owner — when the work is sensitive, irreversible, production-facing,
  or dependent on an external system:** What concrete unacceptable failure is
  possible, and what prevention, recovery, or explicit acceptance does it need?

Do not dump five mini-reviews into the conversation. Apply only the relevant
perspectives, then translate anything material they expose into the decisions,
assumptions, success criteria, or boundaries this skill already produces. A
perspective never authorizes silent scope expansion or a new invariant.

Surface only the decisions that would meaningfully change what gets built.

```
[The decision that needs to be made]

My thinking: [what you would do and why]

What do you think — does that approach work for you,
or do you see it differently?
```

Work through decisions in order of impact. If an answer makes another decision irrelevant, skip it.

**A Step 1 area-convention divergence surfaces here as its own decision**, evidence stated plainly ("this area does X differently from `code-standards.md`, in N files"), never assumed as a defect to silently "fix" back to the root default. On confirmation, capturing it becomes a step in *How to build it* (Step 5) — this skill never writes it itself.

## Step 4 — Know When You Are Done

Stop when every decision that would change the implementation has been resolved — not when every possible question is answered.

Judge this with the **input coverage test**, not introspection. Don't ask "does this feel like I'm inventing something?" — a plan-writing session rationalizes a real decision as "just an implementation detail" and waves it through. Instead: enumerate every value the build will need to produce, compute, or display. For each one, does the plan name where it comes from — a stated input, a prior decision, a named default? Any required value with no named source is an unresolved decision, not a detail to fill in later — surface it as a decision (Step 3) before declaring the blueprint ready.

```
Blueprint ready.
```

## Step 5 — Produce the Implementation Plan

```markdown
## Implementation Plan — [Feature Name]

### What we are building
[One clear paragraph]

### Language we agreed on
- [Term]: [agreed definition]

### Decisions made
- [Decision]: [what and why]

### Assumptions
- [Anything assumed but not explicitly confirmed]

### How to build it
[A concise ordered list of implementation steps]

### File placements
[Following the resolved architecture file's Folder Matrix]
```

**Core/Standard tier: a Decision made above that clears Section 2.11's eligibility bar** (a durable, standing fact carrying real reasoning worth preserving, not a single-line fact that belongs directly in an owning file) **gets a step in *How to build it*:** create its Decision Record (`decisions/NNNN-title/decision.md` with YAML frontmatter — `status`, `date`, `governs` — plus `rationale.md`) and add a Decisions Index row whose title links to it. This skill never writes the record itself — the step executes once building begins, same as any other implementation step, and this skill's Write authority stays none.

Explain any new concept in plain language before using it in the plan (do not assume prior coding background unless the project's context files indicate otherwise).

Cross-check every part of the plan against the resolved architecture file's Absolute Invariants before presenting it. If anything would conflict with an invariant, say so explicitly instead of quietly working around it.

Present the plan. Wait for explicit confirmation. Only then does implementation begin.

## What This Session Is Not

Not an interrogation. Not a full specification document. Not open-ended — ask what matters, confirm the plan, get out of the way.
