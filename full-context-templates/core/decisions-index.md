<!-- Decisions Index: routing table into the Logbook (decisions/) — never decision content itself -->

# Decisions Index

## Threshold Check

_Mechanical, not estimated — `remember` and `linis` run
`bash scripts/check-banka-thresholds.sh` and update this from its actual
output, never a guess (Protocol Section 2.9)._

_Last run: [date]. Run `bash scripts/check-banka-thresholds.sh` to refresh._

| File | Words | Threshold | Status |
| --- | --- | --- | --- |
| `decisions-index.md` (this file) | [N] | ~2,000 | [OK / OVER — action needed] |

---

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
