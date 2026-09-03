<!-- Canonical Banka state-resolution mechanism. Every Skills Kit skill that
resolves project state (all but dredge, which only needs this conditionally
— see its own Context Contract) points here instead of embedding this
content itself. This file travels with the Skills Kit install — see
Protocol Section 7 for both runtimes' install steps. -->

Read this in full before touching project state. It classifies the project;
it does not decide what to do with the classification — that's each skill's
own job, stated in its own file right after the pointer that brought you
here.

## 1. Schema-2 detection

Inspect `AGENTS.md`, the complete contents of `CLAUDE.md`, `/core/`,
`/context/`, and the required tier files.

Active schema 2 requires one complete Banka block in `AGENTS.md`, these
exact comments exactly once, in this order:

1. `<!-- BANKA:START -->`
2. `<!-- BANKA:STATE-SCHEMA: 2 -->`
3. Exactly one of `<!-- BANKA:TIER: Minimal -->`, `<!-- BANKA:TIER: Core -->`, `<!-- BANKA:TIER: Standard -->`
4. `<!-- BANKA:END -->`

The declared tier must match the filesystem shape and required files below.
`CLAUDE.md` must be exactly `@AGENTS.md`. If `CLAUDE.md` is missing, schema 2
is still active for a runtime that discovers `AGENTS.md` directly — report
that Claude Code compatibility is unavailable, nothing more.

## 2. Matching tier shapes

| Tier | Directory | Required files | Must NOT have |
| --- | --- | --- | --- |
| Minimal | none | (state lives in the `AGENTS.md` block itself) | `/core/`, `/context/` |
| Core | `/core/` | `overview.md`, `architecture.md`, `design.md`, `progress.md`, `session-notes.md`, `decisions-index.md` | `/context/` |
| Standard | `/context/` | `project-overview.md`, `architecture.md`, `build-plan.md`, `code-standards.md`, `library-docs.md`, `ui-tokens.md`, `ui-rules.md`, `ui-registry.md`, `progress-tracker.md`, `session-notes.md`, `decisions-index.md` | `/core/` |

## 3. Stop conditions

Stop state-dependent work — do not choose, repair, or normalize any of
these states — for:

- Competing authority
- Malformed, partial, duplicate, or unknown Banka markers
- A non-exact `CLAUDE.md` beside an active schema-2 `AGENTS.md`
- An exact `CLAUDE.md` shim with missing authority (no valid `AGENTS.md` block behind it)
- Both `/core/` and `/context/` present at once
- Tier marker and filesystem shape disagreeing
- Missing required tier files

## 4. Legacy detection

Recognize legacy Banka state only when `CLAUDE.md` has the
`# Project Operating Protocol` heading and exactly one complete legacy tier
shape, with or without an old `AGENTS.md` block pointing to it.

- Legacy is compatibility-read-only by default: report the classification,
  read its chain when safe, and do not change Banka state until an
  explicitly requested, previewed, and confirmed migration completes.
  (A skill with write authority may narrow this further — see that skill's
  own addendum after its pointer to this file.)
- Incomplete legacy state or a broken old shim is a stop condition.
- If neither schema 2 nor recognizable legacy state exists, treat the
  repository as unstructured/non-Banka — never assume Minimal, never
  create Banka state implicitly.

## What this file does not cover

Where the classification above routes to *within* the project — which file
to plan from, write to, or review against for a given tier — is each
skill's own job. This file ends at "here is the project's Banka state";
it never decides what a skill does next.
