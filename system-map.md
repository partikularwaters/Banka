<!-- System map: how every piece of this framework connects, end to end. Read this first if you're
     trying to understand the whole shape rather than one file in isolation. Not part of the protocol
     itself — this is the orientation doc the protocol doc doesn't try to be. -->

# System Map

One diagram, then one paragraph per stage. If a file reference below looks wrong, the file itself is authoritative — this doc explains connections, it doesn't redefine anything.

*(Kept deliberately free of box-drawing alignment — a fixed-width ASCII diagram breaks every time a skill name's length changes, which is exactly what happened here during the rename pass. Indentation and arrows only, nothing that depends on counting characters.)*

```
STAGE 0 — External Scoping (optional)
  Any scoping process, or the user's own notes. Never touches Claude Code.
  Output: a document with a real shape — purpose, users, feature scope,
  constraints, and a definition of done.
    |
    |  handed to Claude Code
    v

STAGE 1 — Scoping Intake (Protocol §1.5)
  State 1: scope doc + rubric already run  -> read tier directly
  State 2: scope doc, no rubric            -> read substance, run §2
  State 3: nothing exists                  -> run built-in fallback pass
  Writes: IDEA-SCOPE.md at project root (permanent, never edited)
    |
    |  a resolved tier: Minimal / Core / Standard
    v

STAGE 2 — Tier Generation (Protocol §3 / §4 / §5)
  Minimal:  CLAUDE.md only, inline, fixed shape
  Core:     CLAUDE.md router + /core/ (4 files)
  Standard: CLAUDE.md router + /context/ (9 files)
  Section 2.6 (Layer Principle) governs every default written in:
  Agnostic (identity layer) vs. Hard Default (quality layer)
    |
    |  a real project now exists on disk
    v

STAGE 3 — The Build Loop (skills-kit/, installed once, per machine)
  /charter    -> plan, wait for approval (reads IDEA-SCOPE.md too)
  /delegate   -> optional: split an approved plan into tickets
                 for a lighter model, fresh session per ticket
  [build]
  /moor       -> capture a UI pattern or engineering outcome
  /survey     -> check plan-alignment, system integrity, prod-ready
      -> /dredge    if something is actually broken
      -> /watershed if it is a genuine multi-angle judgment call
  /remember save -> close the session

  Loop repeats every session. /remember restore opens the next one.
    |
    |  the project outgrows its tier
    v

STAGE 4 — Promotion (Protocol §6, skill: /scale)
  Minimal -> Core -> Standard, always one tier at a time,
  triggered by real thresholds, never guessed or skipped.


Orthogonal, not a stage — can attach at any point in Stage 3:

  Craft Layer Modules (Protocol §7.6 manifest, §7.7 reference)
  Opt-in, external, never bundled — e.g. emilkowalski/skills.
  Agnostic until installed -> Hard Default for that one domain.

Also orthogonal:

  /linis — cleanup pass, run once a version ships or a milestone
  closes. Never run against active work.
```

---

## Stage 0 — External Scoping (optional)

Not part of this framework, and not required by it — Section 1.5's State 3 exists precisely so nothing breaks if this stage is skipped entirely. Any process that produces a document with the right shape counts, regardless of its filename or which framework produced it: a stated purpose, users, a staged feature scope, constraints, and a definition of done. A dedicated scoping protocol run in a separate chat surface is one way to get there; a person's own notes in the same shape count equally. If that document also already contains this protocol's own complexity rubric (§2), recorded as individual per-question answers rather than a summary, Stage 1 reads the resulting tier directly instead of re-running it.

## Stage 1 — Scoping Intake (§1.5)

The seam between the two systems. Checks, in order: does a scope document exist with a rubric already run (State 1 — skip straight to stating the tier), does one exist without a rubric (State 2 — read it, then run §2), or does neither exist (State 3 — run a lightweight, unbranded scoping pass built into this protocol itself). Whichever state applies, the resolving document gets saved as `IDEA-SCOPE.md` at the project root before any tier files are generated — permanent, never edited afterward, sitting beside the generated structure rather than inside it.

## Stage 2 — Tier Generation (§3 / §4 / §5)

The tier resolved in Stage 1 determines the file shape: Minimal (one `CLAUDE.md`), Core (`CLAUDE.md` + four files under `/core/`), or Standard (`CLAUDE.md` + nine files under `/context/`). Every default written into these files is governed by §2.6's Layer Principle — Agnostic defaults (stack, language, styling) get contrasted, never picked for the user; Hard Defaults (error handling, comment policy, the registry in §2.6) get stated as settled fact.

## Stage 3 — The Build Loop (skills-kit/)

The nine skills, installed once per machine, used across every project regardless of tier (each resolves its own tier via a folder-existence check, never by parsing `CLAUDE.md` prose). The typical shape of one working session: `/charter` plans and waits for approval (now also reading `IDEA-SCOPE.md` if present, to keep new work traceable to original scope) → optionally `/delegate` splits approved work into tickets for a lighter model in a fresh session → building happens → `/moor` captures anything worth remembering → `/survey` checks the result, routing to `/dredge` if something's actually broken or `/watershed` if it's a genuine multi-perspective judgment call → `/remember save` closes the session. `/remember restore` opens the next one, checking disk/git reality before trusting anything the last session assumed.

## Stage 4 — Promotion (§6, `/scale`)

A project can outgrow its tier. `/scale` promotes exactly one tier at a time — Minimal → Core, or Core → Standard, never skipping — only when a real threshold is met or explicitly requested, and always shows what moved where before anything old gets deleted.

## Orthogonal: Craft Layer Modules (§7.6 / §7.7) and `/linis`

Two mechanisms that can engage at any point in Stage 3, not tied to a specific stage: a Craft Layer module (§7.6's manifest, §7.7's reference instance) is Agnostic until a project opts in, then Hard Default for that one domain only. `/linis` is a cleanup pass for settled work — narrative residue, dates, quotes — run once something ships, never against work still in motion.
