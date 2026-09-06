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
the one already-durable anchor in the pipeline — the commit it was checked
at, and the exact invocation copied verbatim from the script's own output,
never paraphrased. File/diff evidence uses `--revision <full-sha>` for
replay against retained Git objects. Live checks and test runs are observations,
not replayable historical evidence; record dirty paths and runtime details
in Evidence scope, and keep different scopes in separate rows. A `MET` in this
table means the specified evidence was found — a file exists, a diff
touched a path, a command exited `0` — never that the claim itself is
correct; read Invocation and Claims checked together to know exactly what
was actually confirmed. Once this table crosses ~2,000 words, start
`overflow/verified/01-verified-index.md` (next: `02-...`, same convention
as every other overflow file) and link to it from here — rows never get
archived out for being old._

| ID | Ticket/Plan | Commit | Evidence scope | Claims checked | Invocation | Verdict | Date |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `0001` | `Ticket 3` / `[charter plan citation]` | `[full SHA]` | `commit-pinned` | `[what was checked]` | `` `--revision <full-sha> --check-file src/foo.ts` `` | `MET / MISSING / BLOCKED` | `[date]` |
