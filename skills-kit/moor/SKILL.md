---
name: moor
description: After building any UI component or resolving a notable engineering outcome, extract what matters and save it to the correct project file — the UI registry for UI patterns, the session-state file for everything else. So every future session builds on what's already established instead of drifting from it.
---

**First, resolve the project's structure:** `/context/` → Standard tier — nine
files under `/context/`; `/core/` → Core tier — four files under `/core/`;
`CLAUDE.md` → Minimal tier — state lives inline. If none exists, stop: this is
not a Banka-enabled project and there is no defined destination to moor into.
Never create Banka state implicitly.

UI consistency and institutional memory depend on every session capturing what
it settled in a place a future session — possibly using a different
user-selected model — will read before building something similar.

## How to Invoke

Claude Code: `/moor`, `/moor [filepath]`, or `/moor audit`.
Codex: `$moor`, `$moor [filepath]`, or `$moor audit`.

If no filepath is given, identify recently created/modified component files automatically.

**Use audit mode when:** the project's UI already exists and consistency is uncertain, multiple sessions have passed without invoking moor, something looks visually off but it's hard to pinpoint why, or before establishing `ui-registry.md` for the first time on an existing project.

---

## Step 1 — Determine what's being captured

- **A UI component pattern** (background, border, radius, text roles, spacing, interactive states, shadow, accent usage — not width/height, layout positioning, or responsive variants, which are too context-dependent to be a consistency rule) → goes to the UI registry (Minimal: a Component Registry note inside `CLAUDE.md`'s Project Overview; Core: `core/design.md`; Standard: `context/ui-registry.md`).
- **A general engineering outcome, decision, or resolved problem** → goes to the session-state file (Minimal: `CLAUDE.md`'s Session Notes; Core: `core/progress.md`; Standard: `context/progress-tracker.md`).
- **A changed global token, folder structure, or invariant** → update the file that actually owns it directly (Minimal: inline in `CLAUDE.md`; Core: `core/design.md` for tokens, `core/architecture.md` for structure/invariants/conventions; Standard: `ui-tokens.md`, `architecture.md`, `code-standards.md` respectively) — never just log that it changed, actually update the source.

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
Moored [Component Name] → [CLAUDE.md / core/design.md / context/ui-registry.md]

Captured: [brief list]

Any future component of this type should match these patterns.
```

Flag anything inconsistent or surprising found during extraction.

---

## Audit Mode

Scans the whole codebase, finds conflicts, establishes a clean baseline before any further single-component capturing happens.

1. **Scan** every UI component file. Build a complete picture of current visual patterns in use.
2. **Identify conflicts** — for each property, list every variation found (with file references) and a recommendation on which to standardize on. Flag every hardcoded value found.
3. **Wait for developer confirmation** before writing anything — present the audit, do not fix or update the registry yet.
4. **Write the confirmed baseline** once approved, labeled clearly as established via audit, with a date.
5. **List what needs fixing** — every component that deviates from the new baseline, so it can be addressed systematically or as encountered.

## The Rule

Build something worth remembering. Invoke moor. Move on. A registry that's sometimes updated is unreliable — consistency is a habit, not a feature.
