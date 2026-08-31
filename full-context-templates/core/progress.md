<!-- Progress: milestones, completed work, and session-to-session memory — update after every session -->

# Progress

**Current Phase:** Phase 1 — [First milestone name]

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

## Session Memory Bank

**Context:** [Compressed summary of everything the scoping conversation established — enough that a fresh session needs zero re-explanation]

**Known Issues / Open Decisions:** [Anything explicitly left open]

**Next Immediate Step:** [The very first concrete action]

**Keeping this section lean:** promote durable, standing facts to the file
that owns them (`core/architecture.md`, `core/design.md`), not here; a
durable decision worth its own reasoning goes to the Logbook
(`decisions/NNNN-title/`, Protocol Section 2.11) instead of being written
inline here — never compressed, never overflowed; tag narrative by the
distinct line of work it belongs to, not one flat story (3rd concurrent
thread: pause and confirm; 4th: state why in writing).

If narrative here crosses ~2,000 words, move the excess into
`overflow/session-notes/` (creating it if it doesn't exist yet; numbered
sequentially — `01-...`, then `02-...` once `01-...` itself crosses ~2,000
words) — never force a split against still-active work. Add or update:

## Overflow Index
| File | Type | Covers |
| --- | --- | --- |
| `overflow/session-notes/01-session-notes.md` | narrative | [what it covers] |

Each overflow file carries its own short Contents note at its own top.

## Decisions Index

_Empty until a decision clears the Logbook's eligibility bar (Section 2.11)
— durable, standing, and carrying real reasoning worth preserving. Status
is `Accepted` or `Superseded by [NNNN]` — a superseded decision's record is
never rewritten, only replaced by a new one._

| ID | Title | Status | Summary |
| --- | --- | --- | --- |
| `0001` | `[title]` | `Accepted` | `[one-line summary]` |
