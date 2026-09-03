<!-- Progress tracker: live build status and task tracking — update this after every session -->

# Progress Tracker

**Last updated:** [YYYY-MM-DD]
**Current phase:** [Phase name]
**Overall status:** [e.g. In progress / Blocked / On track]

---

## Threshold Check

_Mechanical, not estimated — `remember`, `moor`, and `linis` run
`bash scripts/check-banka-thresholds.sh` and update this from its actual
output, never a guess (Protocol Section 2.9). This file no longer holds
Session Notes or the Decisions Index itself — each lives in its own file
with its own Threshold Check; these are rollup rows only, so a session
reading just this file never loses visibility into either._

_Last run: [date]. Run `bash scripts/check-banka-thresholds.sh` to refresh._

| File | Words | Threshold | Status |
| --- | --- | --- | --- |
| [`session-notes.md`](session-notes.md) | [N] | ~2,000 | [OK / OVER — action needed] |
| [`decisions-index.md`](decisions-index.md) | [N] | ~2,000 | [OK / OVER — action needed] |

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

**Keeping this file lean:** durable decisions belong in the Logbook via
[`decisions-index.md`](decisions-index.md), never written inline here.
Session narrative belongs in [`session-notes.md`](session-notes.md), not
here — this file is task-tracking only.
