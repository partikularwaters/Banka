<!-- Progress: milestones and task tracking — update after every session -->

# Progress

**Current Phase:** Phase 1 — [First milestone name]

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

## Active Milestones
- [ ] Milestone 1: [specific, objective, actionable]
- [ ] Milestone 2: [specific, objective, actionable]

## Completed Actions
- [x] Scope defined and locked in chat session prior to transfer
- [x] Data model designed

---

## Known Issues
| Issue | Severity | Status |
| ----- | -------- | ------ |
| `[Description]` | High / Medium / Low | Open / In progress / Resolved |

---

**Next Immediate Step:** [The very first concrete action]

**Keeping this file lean:** promote durable, standing facts to the file
that owns them (`core/architecture.md`, `core/design.md`), not here; a
durable decision worth its own reasoning goes to the Logbook
(`decisions/NNNN-title/`, Protocol Section 2.11) via
[`decisions-index.md`](decisions-index.md), never written inline here.
Session narrative belongs in [`session-notes.md`](session-notes.md), not
here — this file is task-tracking only.
