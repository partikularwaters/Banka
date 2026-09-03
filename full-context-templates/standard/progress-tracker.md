<!-- Progress tracker: live build status — update this after every session -->

# Progress Tracker

**Last updated:** [YYYY-MM-DD]
**Current phase:** [Phase name]
**Overall status:** [e.g. In progress / Blocked / On track]

---

## Threshold Check

_Mechanical, not estimated — `remember`, `moor`, and `linis` run
`bash scripts/check-banka-thresholds.sh` and update this from its actual
output, never a guess (Protocol Section 2.9). This file's own sections
only; anything split into its own file gets a rollup row here instead of
its own full check._

_Last run: [date]. Run `bash scripts/check-banka-thresholds.sh` to refresh._

| Section | Words | Threshold | Status |
| --- | --- | --- | --- |
| Session Notes | [N] | ~2,000 | [OK / OVER — action needed] |
| Decisions Index | [N] | ~2,000 | [OK / OVER — action needed] |

---

## Completed
- [x] [Task — e.g. Project initialized with Next.js + Tailwind]
- [x] [Task]
- [x] [Task]

## In Progress
- [ ] [Task currently being worked on]
- [ ] [Task currently being worked on]

## Up Next
- [ ] [Next task to start]
- [ ] [Task after that]
- [ ] [Task after that]

## Blocked
- [ ] [Task] — **Blocked by:** [what's blocking it]

---

## Known Issues
| Issue | Severity | Status |
|-------|----------|--------|
| [Description of issue] | High / Medium / Low | Open / In progress / Resolved |
| [Description of issue] | High / Medium / Low | Open / In progress / Resolved |

---

## Decisions Index

_Empty until a decision clears the Logbook's eligibility bar (Protocol
Section 2.11) — durable, standing, and carrying real reasoning worth
preserving. A durable decision goes to `decisions/NNNN-title/` (its own
`decision.md`/`rationale.md` pair, never compressed, never overflowed) —
this table only routes to it, it is never the decision content itself.
Status is `Accepted` or `Superseded by [NNNN]` — a superseded decision's
record is never rewritten, only replaced by a new one. Once this table
crosses ~2,000 words, start `overflow/decisions-index/01-decisions-index.md`
(next: `02-...`) and link to it from here (rows never get archived out for
being old — a decision stays just as useful to see years later)._

| ID | Title | Status | Summary |
| --- | --- | --- | --- |
| `0001` | [`[title]`](decisions/0001-title/decision.md) | `Accepted` | `[one-line summary]` |

---

## Session Notes
[Brief notes from the last few sessions — what was done, what broke, what to watch for.]

**Keeping this section lean:** tag entries by the distinct line of work they
belong to (a sub-heading is enough), not one flat narrative — a third
concurrently open thread is worth a pause to confirm all are genuinely
active; a fourth needs a stated one-line reason in writing before it's
tagged.

The moment a tagged thread genuinely concludes, archive it immediately to
`overflow/session-notes/01-session-notes.md` (the next sequentially
numbered file in that folder, once `01-...` itself crosses ~2,000 words) —
don't wait for this section to also cross a size threshold. Never force a
split against a thread that's still open; the ~2,000-word figure is only a
fallback for when nothing here is settled yet. Add or update this Overflow
Index, added the first time it's needed, each row a real link:

## Overflow Index
| File | Type | Covers |
| --- | --- | --- |
| [`overflow/session-notes/01-session-notes.md`](overflow/session-notes/01-session-notes.md) | narrative | [what it covers] |

Each overflow file carries its own short Contents note at its own top,
naming what it covers, so it can be found without reading it in full.

**[Date]**
- [What was done]
- [What broke or needs attention]
- [What to do next session]
