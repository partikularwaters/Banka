<!-- Progress tracker: live build status — update this after every session -->

# Progress Tracker

**Last updated:** [YYYY-MM-DD]
**Current phase:** [Phase name]
**Overall status:** [e.g. In progress / Blocked / On track]

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

## Decisions Made
[Log important decisions here so the agent doesn't re-debate them.]

**Keeping this section lean:** promote durable, standing facts (architecture,
invariants, conventions) to the file that owns them, not here. If a new
decision reverses an earlier one, mark the earlier entry
`[SUPERSEDED — see <new decision>]` in place — never leave it looking
current. If a decision's rationale runs past a sentence or two, write a
one-line entry plus a link to `overflow/decisions/01-decisions-detail.md`
(the next sequentially numbered file in that folder, once `01-...` itself
crosses ~2,000 words), not an inline paragraph.

If this section crosses ~1,500 words, or when a superseded entry above gets
swept out in full, move the excess into `overflow/decisions/` (creating the
folder if it doesn't exist yet) and add or update this Overflow Index — one
shared table covering both decisions and session-notes overflow, added the
first time either is needed:

## Overflow Index
| File | Type | Covers |
| --- | --- | --- |
| `overflow/decisions/01-decisions-detail.md` | decision detail | [what it covers] |

Each overflow file carries its own short Contents note at its own top,
naming what it covers, so it can be found without reading it in full.

- **[Date]** — [Decision made and why]
- **[Date]** — [Decision made and why]

---

## Session Notes
[Brief notes from the last few sessions — what was done, what broke, what to watch for.]

**Keeping this section lean:** tag entries by the distinct line of work they
belong to (a sub-heading is enough), not one flat narrative — a third
concurrently open thread is worth a pause to confirm all are genuinely
active; a fourth needs a stated one-line reason in writing before it's
tagged.

If this section crosses ~2,000 words, archive whichever tagged thread has
genuinely concluded to `overflow/session-notes/01-session-notes.md` (the
next sequentially numbered file in that folder, once `01-...` itself
crosses ~2,000 words) — never force a split against a thread that's still
open. Add or update the same Overflow Index used by Decisions Made (see
above), and give the new overflow file its own short Contents note at its
top, naming the arc it covers.

**[Date]**
- [What was done]
- [What broke or needs attention]
- [What to do next session]
