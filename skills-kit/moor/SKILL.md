---
name: moor
description: After building a UI component or changing a token/invariant, ground the capture in what actually changed — not recollection of the conversation — and save it to the correct project file. So every future session builds on what's already established instead of drifting from it.
---

A UI pattern or invariant that only lives in git history and this conversation is invisible to every future session — moor grounds its capture in the actual diff, not memory of the conversation, and moves it into the one file a later session will actually read before building something similar.

## Context Contract

**Required:** the changed file(s) — resolved from `git diff`/`git status`,
or an explicit filepath — being captured · the resolved destination file
for the tier and capture type (see Step 1).

**Conditional:** every existing UI component file in the project — audit
mode only, to build the whole-codebase baseline · evidence that `survey`
has passed this build, before capturing a UI pattern or an invariant/token
change — use the schema-specific evidence source in Step 1; audit mode
is exempt.

**Excluded by default:** width/height, layout mechanics, positioning,
animation/transition timing, and responsive breakpoint variants — Step 2
lists these as deliberately not extracted · anything with no corresponding
file change — a decision, conclusion, or rationale visible only in
conversation belongs to `remember`, not moor.

**Outputs:** a registry or owning-file entry (single-capture mode), or a
proposed baseline plus a deviation list (audit mode) — audit mode's baseline
is written only after developer confirmation.

**Write authority:** the one resolved destination file for the capture type
(UI registry or the fact's owning file, by tier), append/update in place —
never a file outside that resolved destination, and never session-state.

## Resolve Banka state first

Before reading or writing project state, inspect `AGENTS.md`, the complete
contents of `CLAUDE.md`, `/core/`, `/context/`, and the required tier files.
A valid Banka block contains these comments exactly once, in order:
`<!-- BANKA:START -->`, `<!-- BANKA:STATE-SCHEMA: 2 -->` or
`<!-- BANKA:STATE-SCHEMA: 3 -->`, exactly one `<!-- BANKA:TIER: Minimal -->`,
`<!-- BANKA:TIER: Core -->`, or `<!-- BANKA:TIER: Standard -->`, then
`<!-- BANKA:END -->`. This Skills Kit operates schema 3 only.

Minimal has neither `/core/` nor `/context/`. Core has `/core/` only:
`overview.md`, `architecture.md`, `design.md`, `progress.md`,
`session-notes.md`, `decisions-index.md`, and `verified-index.md`.
Standard has `/context/` only: `project-overview.md`, `architecture.md`,
`build-plan.md`, `code-standards.md`, `library-docs.md`, `ui-tokens.md`,
`ui-rules.md`, `ui-registry.md`, `progress-tracker.md`, `session-notes.md`,
`decisions-index.md`, and `verified-index.md`.

Schema 2 has the same Minimal shape, or Core/Standard's original four/nine
files without `session-notes.md`, `decisions-index.md`, or `verified-index.md`.
If any of those three files exists with marker `2`, stop for interrupted
migration: resume Protocol Section 3.2 directly or restore from version
control. Do not route an interrupted migration to ordinary schema-2 skills.
For valid schema 2 at any tier, stop before this skill's operating steps and
use the refusal below. Schema 2 remains supported by its own release line;
never add files or change its marker merely to run this skill.

Stop for malformed, partial, duplicate, or unknown markers, tier/file-shape
mismatch, both state directories, missing required files, or competing
root authority. `CLAUDE.md`, when present, must be exactly `@AGENTS.md`.
A missing shim only disables Claude Code compatibility; it does not bypass
schema-2 refusal for runtimes that discover `AGENTS.md` directly.
Do not repair, merge, or normalize these states implicitly.

Without a valid schema block, recognize legacy state only from a
`CLAUDE.md` with `# Project Operating Protocol` and one complete original
tier shape. Legacy is compatibility-read-only until explicit migration.
An exact shim without valid `AGENTS.md` is broken authority, not legacy.
Without active or recognizable legacy state, treat the repository as
unstructured/non-Banka — never assume Minimal or create Banka state
implicitly.

**Schema-2 refusal:** This skill requires schema 3. Use `/moor-s2` (Claude Code) or `$moor-s2` (Codex).
If unavailable, install the suffixed copies from the latest stable release
that explicitly supports schema 2. Alternatively, ask directly to migrate
using `protocol/Banka.md` Section 3.2 from a release supporting schema 3,
with a full preview and confirmation. Migration is a protocol task, not a
skill invocation; neither path runs automatically.

moor requires a state destination to write into, so its own legacy/missing-state
handling is stricter than the shared default: on legacy state, report the
classification and stop until an explicitly requested, previewed, and
confirmed migration completes — never write. If neither an active schema nor
recognizable legacy state exists, stop because no defined destination
exists.

For an active schema, resolve destinations from the declared tier: Standard
uses one of `context/ui-registry.md`, `context/ui-tokens.md`,
`context/architecture.md`, `context/code-standards.md`, or an area-override
file (Standard only); Core uses one of `core/design.md` or
`core/architecture.md`; Minimal uses the Banka-owned block in `AGENTS.md` —
resolved per capture type, see Step 1. A Minimal write changes only
the Banka-owned block and preserves all content outside it.

UI consistency and institutional memory depend on every session capturing what
it settled in a place a future session — possibly using a different
user-selected model — will read before building something similar.

## How to Invoke

Claude Code: `/moor`, `/moor [filepath]`, or `/moor audit`.
Codex: `$moor`, `$moor [filepath]`, or `$moor audit`.

If no filepath is given, resolve what changed from git: `git status`/`git diff`
for uncommitted changes, or the most recent commit if the working tree is
already clean. Never rely on memory of the conversation for what changed —
the actual diff is the source of truth, the same discipline `remember`
already applies to its own save.

**Use audit mode when:** the project's UI already exists and consistency is uncertain, multiple sessions have passed without invoking moor, something looks visually off but it's hard to pinpoint why, or before establishing `ui-registry.md` for the first time on an existing project.

---

## Step 1 — Determine what's being captured

Classify each file identified above — never a file this skill hasn't actually seen change:

- **A UI component pattern** (background, border, radius, text roles, spacing, interactive states, shadow, accent usage — not width/height, layout positioning, or responsive variants, which are too context-dependent to be a consistency rule) → goes to the UI registry (Minimal: a Component Registry note inside the Banka-owned `AGENTS.md` block's Project Overview; Core: `core/design.md`; Standard: `context/ui-registry.md`).
- **A changed global token, folder structure, or invariant** → update the file that actually owns it directly (Minimal: inside the Banka-owned `AGENTS.md` block; Core: `core/design.md` for tokens, `core/architecture.md` for structure/invariants/conventions; Standard: `ui-tokens.md`, `architecture.md`, `code-standards.md` respectively) — never just log that it changed, actually update the source.
- **An outcome belonging to an area with an existing local-override file** (Standard tier only — check `code-standards.md`'s `## Area overrides` table for the touched area) → capture there instead of the general destination above; Section 2.10 of the Protocol governs the full mechanism.
- **Anything else** — a change with no UI, token, invariant, or area content, or a decision/conclusion with no matching file change — isn't moor's job. Tell the developer to invoke `remember` if it's worth a durable narrative entry; moor has no destination for it.

A UI pattern or invariant/token capture becomes what future work is
checked against — the registry for one, charter's invariant cross-check
for the other. Capturing either before verification risks enshrining
something wrong as settled. Confirm `survey` has passed this build —
cleanly, or with findings resolved or explicitly accepted as intentional,
not just run. On Core/Standard, check `verified-index.md` for a
matching entry before capturing — not the conversation. If none exists yet,
invoke `verify` now to create one, then proceed from its recorded verdict.
On Minimal, check the conversation for evidence instead;
if unclear, stop and ask rather than assume either way. Audit mode is
exempt — see below.

The bullets above are this skill's own promotion check. If a captured
pattern's notes run past a sentence or two, that's a decision-detail write
outside this skill's own write authority — capture only a one-line summary
here and tell the developer to invoke remember for the fuller entry; do not
create a link to a file this skill has no authority to write.

## Step 2 — Extract only what matters for consistency (UI capture)

**Extract:** background, border, border color/width, border radius, text color roles, text size/weight, spacing/padding/gap, interactive states (hover/focus/active), shadow, accent usage.

**Do not extract:** width/height, flex/grid layout mechanics, positioning (absolute/relative/z-index), animation/transition timing (that's the Design Craft Add-on's domain if installed — Section 7.7), responsive breakpoint variants (capture the base pattern only).

## Step 3 — Write the entry

```markdown
### [Component Name]
File: [filepath]

| Property | Class/Value |
| -------- | ----------- |
| Background | |
| Border | |
| Border radius | |
| Text — primary | |
| Text — secondary | |
| Spacing | |
| Hover state | |
| Shadow | |

**Pattern notes:** [why a choice was made, what future components should match, what variation is allowed]
```

Append — never overwrite an existing entry for the same component type; update it in place instead.

## Step 4 — Confirm what was captured

```
Moored [Component Name] → [AGENTS.md Banka block / core/design.md / context/ui-registry.md]

Captured: [brief list]

Any future component of this type should match these patterns.
```

Flag anything inconsistent or surprising found during extraction.

---

## Audit Mode

Scans the whole codebase, finds conflicts, establishes a clean baseline before any further single-component capturing happens. Exempt from Step 1's survey-first precondition — this catalogs an already-shipped codebase's existing patterns, not fresh, unverified work. This means a genuine multi-component scan across the codebase, never a stand-in for single-capture mode's verification check on one file — a real audit has variations and conflicts to compare across files by construction; an "audit" with nothing to compare isn't one.

1. **Scan** every UI component file. Build a complete picture of current visual patterns in use.
2. **Identify conflicts** — for each property, list every variation found (with file references) and a recommendation on which to standardize on. Flag every hardcoded value found.
3. **Wait for developer confirmation** before writing anything — present the audit, do not fix or update the registry yet.
4. **Write the confirmed baseline** once approved, labeled clearly as established via audit, with a date.
5. **List what needs fixing** — every component that deviates from the new baseline, so it can be addressed systematically or as encountered.

## The Rule

Build something worth remembering. Invoke moor. Move on. A registry that's sometimes updated is unreliable — consistency is a habit, not a feature.
