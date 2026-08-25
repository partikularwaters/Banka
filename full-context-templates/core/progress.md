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
that owns them (`core/architecture.md`, `core/design.md`), not here; mark a
reversed decision `[SUPERSEDED — see <new decision>]` rather than leaving it
looking current; write long rationale as a one-line entry plus a link to
`overflow/decisions/01-decisions-detail.md`, not an inline paragraph; tag
narrative by the distinct line of work it belongs to, not one flat story
(3rd concurrent thread: pause and confirm; 4th: state why in writing).

If this crosses ~2,000 words of narrative or ~1,500 of decisions, or a
superseded entry gets swept, move the excess into `overflow/session-notes/`
or `overflow/decisions/` respectively (creating whichever doesn't exist
yet; each numbered sequentially — `01-...`, then `02-...` once `01-...`
itself crosses ~2,000 words) — never force a split against still-active
work. Add or update:

## Overflow Index
| File | Type | Covers |
| --- | --- | --- |
| `overflow/session-notes/01-session-notes.md` | narrative | [what it covers] |
| `overflow/decisions/01-decisions-detail.md` | decision detail | [what it covers] |

Each overflow file carries its own short Contents note at its own top.
