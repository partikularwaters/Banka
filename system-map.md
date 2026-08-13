<!-- System map: how every piece of this framework connects, end to end. Read this first if you're
     trying to understand the whole shape rather than one file in isolation. Not part of the protocol
     itself — this is the orientation doc the protocol doc doesn't try to be. -->

# System Map

One diagram, then one paragraph per stage. If a file reference below looks wrong, the file itself is authoritative — this doc explains connections, it doesn't redefine anything.

The diagram uses indentation and arrows so labels can change without breaking
fixed-width alignment.

```
STAGE 0 — External Scoping (optional)
  Any scoping process, or the user's own notes. Runtime-independent.
  Output: a document with a real shape — purpose, users, feature scope,
  constraints, and a definition of done.
    |
    |  handed to a supported coding-agent runtime
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
  Minimal:  one CLAUDE.md state file + AGENTS.md Codex entry, no state folder
  Core:     CLAUDE.md router + AGENTS.md Codex shim + /core/ (4 files)
  Standard: CLAUDE.md router + AGENTS.md Codex shim + /context/ (9 files)
  Section 2.6 (Layer Principle) governs every default written in:
  Agnostic (identity layer) vs. Hard Default (quality layer)
    |
    |  a real project now exists on disk
    v

STAGE 3 — The Build Loop (skills-kit/, exposed per supported runtime)
  charter    -> plan, wait for approval (reads IDEA-SCOPE.md too)
  delegate   -> optional: split an approved plan into Junior-safe tickets
                for fresh-session execution; model choice stays user-controlled
  [build]
  moor       -> capture a UI pattern or engineering outcome
  survey     -> check plan-alignment, system integrity, prod-ready
      -> dredge    if something is actually broken
      -> watershed if it is a genuine multi-angle judgment call
  remember save -> close the session

  Loop repeats every session. remember restore opens the next one.
    |
    |  the project outgrows its tier
    v

STAGE 4 — Promotion (Protocol §6, skill: scale)
  Minimal -> Core -> Standard, always one tier at a time,
  triggered by real thresholds, never guessed or skipped.


Orthogonal, not a stage — can attach at any point in Stage 3:

  Craft Layer Modules (Protocol §7.6 manifest, §7.7 reference)
  Opt-in, external, never bundled — e.g. emilkowalski/skills.
  Agnostic until installed -> Hard Default for that one domain.

Also orthogonal:

  linis — scoped cleanup pass, run once a version ships or a milestone
  closes. Never run against active work.

Codex discovery (repository-local, not project state):

  .agents/skills/* -> symlinks to skills-kit/*
  $skill-name invokes a skill in Codex; Claude Code uses /skill-name.
```

---

## Stage 0 — External Scoping (optional)

Not part of this framework, and not required by it — Section 1.5's State 3 exists precisely so nothing breaks if this stage is skipped entirely. Any process that produces a document with the right shape counts, regardless of its filename or which framework produced it: a stated purpose, users, a staged feature scope, constraints, and a definition of done. A dedicated scoping protocol run in a separate chat surface is one way to get there; a person's own notes in the same shape count equally. If that document also already contains this protocol's own complexity rubric (§2), recorded as individual per-question answers rather than a summary, Stage 1 reads the resulting tier directly instead of re-running it.

## Stage 1 — Scoping Intake (§1.5)

The seam between the two systems. Checks, in order: does a scope document exist with a rubric already run (State 1 — skip straight to stating the tier), does one exist without a rubric (State 2 — read it, then run §2), or does neither exist (State 3 — run a lightweight, unbranded scoping pass built into this protocol itself). Whichever state applies, the resolving document gets saved as `IDEA-SCOPE.md` at the project root before any tier files are generated — permanent, never edited afterward, sitting beside the generated structure rather than inside it.

## Stage 2 — Tier Generation (§3 / §4 / §5)

The tier resolved in Stage 1 determines the file shape: Minimal has one Banka state file (`CLAUDE.md`) and no state folder; Core adds four files under `/core/`; Standard uses nine files under `/context/`. Each tier may also include a minimal `AGENTS.md` Codex entry that points to the existing Banka state without duplicating it. Every default written into shared state is governed by §2.6's Layer Principle — Agnostic defaults (stack, language, styling) get contrasted, never picked for the user; Hard Defaults (error handling, comment policy, the registry in §2.6) get stated as settled fact.

## Stage 3 — The Build Loop (skills-kit/)

The nine skills are exposed through the supported runtime's discovery location
and used across every Banka-enabled project regardless of tier. Each resolves
Standard from `/context/`, Core from `/core/`, and Minimal from `CLAUDE.md`; if
none exists, it treats the repository as unstructured rather than assuming
Minimal. A typical session runs charter → optional delegate → build → moor →
survey, with dredge or watershed used when routed there. Remember closes and
restores sessions after checking disk and version-control reality. Claude Code
uses `/skill-name`; Codex uses `$skill-name`.

## Stage 4 — Promotion (§6, scale)

A project can outgrow its tier. The scale skill promotes exactly one tier at a time — Minimal → Core, or Core → Standard, never skipping — only when a real threshold is met or explicitly requested, and always shows what moved where before anything old gets deleted.

## Orthogonal: Craft Layer Modules (§7.6 / §7.7) and linis

Two mechanisms can engage at any point in Stage 3: a Craft Layer module is Agnostic until a project opts in, then Hard Default for that domain only. Linis removes narrative residue from settled files while preserving operational history, provenance, compatibility facts, and load-bearing rationale.
