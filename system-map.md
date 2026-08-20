<!-- System map: how every piece of this framework connects, end to end. Read this first if you're
     trying to understand the whole shape rather than one file in isolation. Not part of the protocol
     itself — this is the orientation doc the protocol doc doesn't try to be. -->

# System Map

One diagram, then one paragraph per stage. If a file reference below looks
wrong, the file itself is authoritative — this doc explains connections,
it doesn't redefine anything.

The diagram uses indentation and arrows so labels can change without breaking
fixed-width alignment.

```
STAGE 0 — Project Assessment (Protocol §0)
  Banka evaluates whether the project satisfies two conditions.

  Is decision-ready scope present?
    no  -> clarify scope before adoption continues
           -> Any valid scoping method is acceptable; ASMP is one available route
    yes -> continue

  Is this an existing / brownfield project?
    no  -> proceed to Banka scoping intake
    yes -> does sufficient readiness evidence already exist?
             no  -> apply Banka Docking
                    -> Docking must reach `Ready for Banka`
             yes -> continue

  Adoption conditions satisfied
    |
    |  Banka adoption may proceed
    v

STAGE 1 — Scoping Intake (Protocol §1.5)
  State 1: scope doc + rubric already run -> read tier directly
  State 2: scope doc, no rubric           -> read substance, run §2
  State 3: no scope document              -> run lightweight Banka intake
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
    |  Banka project state established
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

Codex discovery (user-level, shared by every repository):

  ~/.agents/skills/* -> symlinks to Banka/skills-kit/*
  $skill-name invokes a skill in Codex; Claude Code uses /skill-name.
```

---

## Stage 0 — Project Assessment (§0)

Before Banka adoption begins, Banka evaluates whether the project satisfies two
adoption conditions.

Decision-ready scope is required, but Banka does not require a particular
scoping method, artifact name, or protocol. If the available scope is not
decision-ready, clarify it before continuing. The Adaptive Scope Mapping
Protocol (ASMP) is one available route for producing decision-ready scope;
another valid scope source is equally acceptable.

Existing or brownfield projects have an additional readiness evidence
requirement. When current evidence does not already establish readiness, Banka
routes the project through the current Banka Docking Protocol. Docking may
itself identify scope that is unclear or not decision-ready; when that happens,
complete the required scope clarification and then return to Docking. Banka
adoption resumes only after Docking establishes `Ready for Banka` and the owner
chooses to continue.

`Ready for Banka` means the prerequisites for Banka adoption have been
established. It does not mean Banka adoption is already complete.

## Stage 1 — Scoping Intake (§1.5)

Once the adoption conditions are satisfied, Banka normalizes the scope it
receives and fills only proportional gaps before resolving the project's tier.

If a scope document already contains Banka's complexity rubric (State 1), Banka
reads the recorded per-question answers and states the resulting tier. If scope
exists without the rubric (State 2), Banka reads its substance and runs §2. If
no scope document exists but the project is sufficiently developed to proceed
(State 3), Banka runs its lightweight scoping intake.

If that lightweight intake instead reveals that the project is materially
underdeveloped, stop and return to the Stage 0 scope requirement rather than
forcing the project through tier selection.

Whichever state resolves successfully, the resulting scope is saved as
`IDEA-SCOPE.md` at the project root before tier files are generated — permanent,
never edited afterward, and stored beside the generated Banka structure rather
than inside it.

## Stage 2 — Tier Generation (§3 / §4 / §5)

The tier resolved in Stage 1 determines the file shape: Minimal has one
Banka state file (`CLAUDE.md`) and no state folder; Core adds four files under
`/core/`; Standard uses nine files under `/context/`. Each tier may also include
a minimal `AGENTS.md` Codex entry that points to the existing Banka state
without duplicating it. Every default written into shared state is governed by
§2.6's Layer Principle — Agnostic defaults (stack, language, styling) get
contrasted, never picked for the user; Hard Defaults (error handling, comment
policy, the registry in §2.6) get stated as settled fact.

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

A project can outgrow its tier. The scale skill promotes exactly one tier at a
time — Minimal → Core, or Core → Standard, never skipping — only when a real
threshold is met or explicitly requested, and always shows what moved where
before anything old gets deleted.

## Orthogonal: Craft Layer Modules (§7.6 / §7.7) and linis

Two mechanisms can engage at any point in Stage 3: a Craft Layer module is
Agnostic until a project opts in, then Hard Default for that domain only.
Linis removes narrative residue from settled files while preserving operational
history, provenance, compatibility facts, and load-bearing rationale.
