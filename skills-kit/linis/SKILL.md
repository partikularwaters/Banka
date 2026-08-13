---
name: linis
description: Clean up narrative residue in settled files after a milestone without removing operational history, provenance, compatibility facts, or load-bearing rationale. Proposes every cleanup before applying it and never runs against active work.
argument-hint: [optional — specific settled file(s); defaults to files changed in the current completed milestone]
---

*Linis* — Filipino for "clean." Code and context files accumulate the residue of how they were built: a name here, a date there, a line quoting what someone said mid-session, a comment narrating an experiment instead of stating its settled result. None of that is wrong to have *during* a build — some of it is exactly what `remember` and the session-state file (`CLAUDE.md`'s Session Notes, `core/progress.md`, or `context/progress-tracker.md`, depending on tier) are supposed to capture while work is active. But once a version ships or a milestone closes, that residue stops being useful context and starts being clutter a future session has to read past to find what actually matters.

This skill does not touch correctness — it never changes what code does. It only changes how it's described.

---

## Step 0 — Determine scope

Default: files changed in the current completed milestone, resolved from the
session-state file and version-control diff. Do not expand this to a repo-wide
cleanup unless the user explicitly requests that scope. If the user specifies a
narrower scope, respect it.

Resolve project structure before reading state: `/context/` → Standard,
`/core/` → Core, `CLAUDE.md` → Minimal. If none exists, treat the repository as
unstructured rather than assuming Minimal; use the supplied milestone/diff to
resolve scope and do not create Banka state files.

**Never run this against active, in-progress work** — check the session-state file first; if the scope includes something still marked in-progress, ask before touching it. Cleanup is for what's settled, not what's still being decided.

## Step 1 — Scan for each offending pattern

For every file in scope, check for:

**1. Names or identity references** — the user's real name, a nickname, "the user," "as [X] mentioned," or any phrasing that identifies a specific person rather than describing a project decision. → Remove or generalize entirely. A decision reads as the project's decision, not a transcript of who said what.

**2. Narrative dates** — a timestamp attached to settled explanatory prose
purely to mark *when it was discussed*, with no ongoing technical relevance. →
Remove. Never remove dates from active operational structures such as Decisions
Made, Session Notes, releases, migrations, compatibility records, or audit
entries merely because they are dates. Keep any date that affects technical
truth or traceability.

**3. Direct quotes of the user's own words** — anything in quotation marks attributing specific phrasing to the person. → Paraphrase into a settled, generalized statement, or remove if it adds nothing beyond flavor.

**4. Present-tense "trying it out" framing** — "let's see if this works," "testing whether," "trying this approach for now," anything that narrates an experiment in progress rather than stating its result. → If the experiment succeeded and is now the approach: restate as a settled fact, past tense, no hedging ("uses X because Y" not "trying X to see if Y works"). If it failed or was abandoned: remove entirely, unless the *fact that it was tried and rejected* has real forward value (see rule 6) — in which case compress to one settled sentence, not a narrative.

**5. Elaborate, storytelling explanations** — a comment or doc passage that walks through the reasoning at length, in a conversational voice, rather than stating the point directly. → Compress to the essential, authoritative statement. A comment justifies a non-obvious decision in one or two sentences; it does not narrate the thought process that arrived there.

**6. Pure historical artifacts with no forward value** — session logistics
("fixed a typo," "renamed a variable," "discussed X, decided to revisit later"
with no later resolution ever recorded), one-off debugging notes about a problem
now fully resolved, anything a future session gains nothing from reading. →
Remove entirely. Preserve rejected approaches when forgetting them could repeat
a security, correctness, compatibility, or architectural failure.

## Step 2 — What to keep, unchanged in substance

- Settled decisions and their reasoning, restated as fact: past tense, declarative, no hedging, no attribution to a person — e.g. "Business Fund is always computed from Gross Profit, not revenue — a past audit found revenue-based computation was a copy-paste error, not a valid alternative," not "[User] pointed out on [date] that we should double check this, and after some back and forth we agreed..."
- Genuine "why" comments matching this project's own comment policy (see `code-standards.md`) — a non-obvious reason something is the way it is, stated briefly.
- Operational history: dated decisions, session handoffs, releases, migrations,
  compatibility constraints, audit trails, and unresolved issues.
- Provenance, attribution, licensing, and third-party authority records.
- Rejected alternatives whose rationale prevents a known regression or repeated
  failure.
- Anything already in a fully generalized, factual, past-tense form — leave it as-is, don't rewrite something that already passes.

## Step 3 — Present before applying

Do not silently rewrite files. Show the proposed changes as a before/after diff or a clear list of "remove this / rewrite this to this," grouped by file, before touching anything:

```
## Linis — proposed cleanup

### [file]
- REMOVE: "[exact excerpt]" — [which rule triggered this]
- REWRITE: "[exact excerpt]" → "[proposed replacement]" — [which rule triggered this]

### [file]
...

[N] removals, [M] rewrites across [X] files. Apply?
```

Wait for confirmation. Then apply exactly what was shown — no additional changes introduced during application that weren't in the proposal.

## Delegation note

Straightforward pattern-matching removals (a clearly narrative date, an obvious direct quote) are Junior-safe. Judgment calls about whether something is "merely historical" versus quietly load-bearing — especially inside a decision log, compatibility record, provenance note, or invariant's justification — are Senior-required; when genuinely unsure whether a passage matters, flag it in the proposal rather than guessing either direction.

## The Rule

Code and docs should read like settled facts about the project, not a transcript of how the project came to believe them. Run this once a version ships or a milestone closes — not continuously, and never against work still in motion.
