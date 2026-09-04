<!-- Verified Index: durable, mechanically-checked record of what survey said was true and what the repo actually shows — never decision content, never survey's own report. -->

# Verified Index

## Threshold Check

_Mechanical, not estimated — `remember`, `verify`, and `linis` run
`bash scripts/check-banka-thresholds.sh` and update this from its actual
output, never a guess (Protocol Section 2.9)._

_Last run: [date]. Run `bash scripts/check-banka-thresholds.sh` to refresh._

| File | Words | Threshold | Status |
| --- | --- | --- | --- |
| `verified-index.md` (this file) | [N] | ~2,000 | [OK / OVER — action needed] |

---

_Empty until `verify` reconciles a `survey` verdict against real repo
evidence (`scripts/verify-claims.sh`'s output — never verify's own
narrative read). Each row cites the ticket or plan it verified against —
the one already-durable anchor in the pipeline — and the commit it was
checked at, never the claim's full text. Once this table crosses ~2,000
words, start `overflow/verified/01-verified-index.md` (next: `02-...`,
same convention as every other overflow file) and link to it from here —
rows never get archived out for being old._

| ID | Ticket/Plan | Commit | Claims checked | Verdict | Date |
| --- | --- | --- | --- | --- | --- |
| `0001` | `Ticket 3` / `[charter plan citation]` | `abc1234` | `[what was checked]` | `MET / MISSING / BLOCKED` | `[date]` |
