---
name: remember
description: Save what matters at the end of a session so the next session picks up exactly where you left off. Or restore context at the start of a new session so nothing is lost between them — and never trust this conversation's own memory over what's actually on disk.
---

AI has no memory between sessions. Every new session starts blank. This skill fixes that — but the fix is the file on disk, never this conversation's own recollection of it, since another session may have touched the project since this conversation last looked.

**First, resolve the project's structure:** check which folder exists. `/context/` → Standard tier — session state lives in `context/progress-tracker.md`; a changed invariant belongs in whichever specific domain file actually owns it, not in progress-tracker.md. `/core/` → Core tier — session state lives in `core/progress.md`. Neither → Minimal tier — session state lives in `CLAUDE.md`'s Session Notes section directly.

## Security Boundary

Never persist secrets — API keys, tokens, passwords, private keys, cookies, connection strings, or any credential-like value. If useful but sensitive, store a redacted placeholder (`[REDACTED_API_KEY]`). If unsure, treat as sensitive and omit.

## How to Invoke

`/remember save` — at end of session.
`/remember restore` — at start of new session.
No argument given → ask which is meant.

---

## Save Mode

### Before writing anything: check for concurrent drift

If this project uses version control, run the equivalent of `git log` and `git status` **before** trusting anything this conversation believes about the project's current state. If a commit exists that this conversation didn't make, another session touched this project since — read what actually changed from disk/git, not from this conversation's assumptions, before writing the save. This applies every single time, not just when something seems off.

### What to capture

Think like handing off to an equally skilled colleague who knows nothing about today's session:

- **What was built** — specific files, features completed. Precise, not vague ("created X, Y, Z; feature works end to end").
- **Decisions made** — architectural choices future work depends on, with the reasoning, not implementation detail visible in the code.
- **Problems solved** — anything that took real time to figure out, so it isn't solved twice.
- **Current state** — exactly what works, what's partial, what's known-broken.
- **What comes next** — specific enough to start immediately.
- **Open questions** — anything genuinely unresolved.

Do not capture: implementation detail visible in the code itself, anything already documented in the context files, or the blow-by-blow process of how something was built — only what was built and decided.

### Safety check, then write

Run a final pass for anything secret-shaped before writing. If the session-state file already exists with unsaved content, summarize what's currently there and confirm before overwriting:

```
[CLAUDE.md's Session Notes / core/progress.md / context/progress-tracker.md] already has content from a previous session:
[one-line summary]. Overwrite? (yes / no)
```

### Format

```markdown
# Memory — [Feature or Session Name]

## What was built
## Decisions made
## Problems solved
## Current state
## Next session starts with
## Open questions
```

Confirm after writing: `Memory saved. Next session: run /remember restore to pick up from here.`

---

## Restore Mode

### Step 1 — Check for drift before anything else

If version control is in use, run its equivalent of `git log --oneline -10` and `git status` immediately — even if the session-state file looks complete and current. **A project folder worked by more than one session (including a different Claude Code session, possibly running concurrently) can have real changes on disk that no saved memory file mentions yet.** Treat this as standing practice, not a one-off check triggered only when something seems wrong — the whole point is that a stale assumption looks exactly like a correct one until it's checked.

### Step 2 — Read everything available

Read the resolved session-state file first (`CLAUDE.md`'s Session Notes, `core/progress.md`, or `context/progress-tracker.md`). Under Core or Standard tier, also read every other file listed in `CLAUDE.md`'s Source of truth section. Do not scan beyond what's actually referenced.

Never repeat or surface raw secrets from any source, even in restored context — summarize in redacted form only.

### Step 3 — Confirm what was restored

Do not start building. Summarize so the developer can verify accuracy:

```
Memory restored. Here is where we are:

**Git/version-control check:** [confirmed matches saved state / found drift — describe it]
**Last session:** [what was built]
**Current state:** [what works right now]
**Decisions in place:** [key locked decisions]
**Next up:** [what should start next]

Is this correct?
```

Only proceed after confirmation.

### If memory is incomplete, unclear, or contradicted by what's on disk

Say so honestly. Do not guess or silently reconcile a contradiction — surface it and let the developer decide which is authoritative.

## The Rule

Every session ends with `/remember save`. Every session starts with `/remember restore` — and restore always means checking disk/version-control reality first, this conversation's own memory second.
