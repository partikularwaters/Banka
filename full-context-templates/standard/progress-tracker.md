<!-- Progress tracker: live build status and task tracking — update this after every session -->

# Progress Tracker

**Last updated:** [YYYY-MM-DD]
**Current phase:** [Phase name]
**Overall status:** [e.g. In progress / Blocked / On track]
**Completed so far:** [N] tasks across [M] phases (mechanical count — see scripts/check-banka-thresholds.sh; copy its output here verbatim, never hand-count)

---

## Threshold Check

_Mechanical, not estimated — `remember` and `linis` run
`bash scripts/check-banka-thresholds.sh` and update this from its actual
output, never a guess (Protocol Section 2.9). This file no longer holds
Session Notes or the Decisions Index itself — each lives in its own file
with its own Threshold Check, so those two rows are rollups only. Completed
was never split into its own file (Protocol Section 2.9, Track B check 2),
so its row is a direct in-file count instead — a session reading just this
file never loses visibility into any of the three._

_Last run: [date]. Run `bash scripts/check-banka-thresholds.sh` to refresh._

| File | Words | Threshold | Status |
| --- | --- | --- | --- |
| Completed (this file) | [N] | ~2,000 | [OK / OVER — action needed] |
| [`session-notes.md`](session-notes.md) | [N] | ~2,000 | [OK / OVER — action needed] |
| [`decisions-index.md`](decisions-index.md) | [N] | ~2,000 | [OK / OVER — action needed] |

---

## Completed
- [x] [Task — e.g. Project initialized with Next.js + Tailwind]
- [x] [Task]
- [x] [Task]

**Archiving this section:** the moment `**Current phase:**` above changes,
the *previous* phase's entries here are permanently settled — archive them
immediately to `overflow/completed/01-completed.md` (next: `02-...`, same
sequential-numbering convention as every other overflow file, each with its
own short Contents note at the top) and add a row below. A still-open
phase's entries stay here regardless of size — never force an archive
against unsettled work; the ~2,000-word figure is only a fallback for when
the current phase has grown large with nothing yet to cut. The running total
above is never hand-updated after archiving — re-run
`scripts/check-banka-thresholds.sh` and copy its computed count in, the same
way the Threshold Check block below is refreshed.

## Completed Archive Index
| Phase | File | Covers |
| --- | --- | --- |
| `Phase 1` | [`overflow/completed/01-completed.md`](overflow/completed/01-completed.md) | `[date range, N tasks]` |

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

**Keeping this file lean:** durable decisions belong in the Logbook via
[`decisions-index.md`](decisions-index.md), never written inline here.
Session narrative belongs in [`session-notes.md`](session-notes.md), not
here — this file is task-tracking only.
