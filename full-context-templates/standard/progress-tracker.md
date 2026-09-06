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

Create `overflow/decisions/` when a long rationale needs its own detail file,
this section crosses ~1,500 words, or a superseded entry is swept out in full.
When the first overflow file of either type is created, add one shared
`## Overflow Index` section to this file at the same time. Its table schema is
`File | Type | Covers`, with one row per decision or session-notes overflow
file. Do not add the section before an overflow file exists. Each overflow file
carries its own short Contents note at its top so it can be found without
reading it in full.

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
open. Add or update the shared Overflow Index described under Decisions Made,
and give the new overflow file its own short Contents note at its
top, naming the arc it covers.

**[Date]**
- [What was done]
- [What broke or needs attention]
- [What to do next session]
