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
  Minimal:  marked AGENTS.md state block, no state folder
  Core:     AGENTS.md router + /core/ (see full-context-templates/core/)
  Standard: AGENTS.md router + /context/ (see full-context-templates/standard/)
  Claude Code compatibility: CLAUDE.md contains exactly @AGENTS.md
  Section 2.6 (Layer Principle) governs every default written in:
  Agnostic (identity layer) vs. Hard Default (quality layer)
    |
    |  Banka project state established
    v

STAGE 3 — The Build Loop (skills-kit/, exposed per supported runtime)
  charter    -> plan, wait for approval (reads IDEA-SCOPE.md too)
  delegate   -> optional: split an approved plan into Junior-safe, Senior-
                required, and Owner-required items; model choice stays
                user-controlled
  [build]
  survey     -> check plan-alignment, system integrity, prod-ready
      -> dredge    if something is actually broken
      -> watershed if it is a genuine multi-angle judgment call
      -> verify    if a Layer 3 claim is blocked (Core/Standard only)
  moor       -> capture a UI pattern or invariant/token change, grounded
                in the actual git diff (registry/invariant captures wait
                for survey to pass first, and check verify's recorded
                verdict on Core/Standard)
  applicable operational perspectives are embedded inside existing skills
  remember save -> close the session

  charter -> delegate, survey -> moor, and remember save -> restore are
  enforced orderings; moor's registry/invariant captures require survey to
  have passed first (see moor's own file for the audit-mode exception).
  survey -> verify is conditional, not enforced — only for a blocked
  Layer 3 claim on Core/Standard.

  Loop repeats every session. remember restore opens the next one.
    |
    |  the project outgrows its tier
    v

STAGE 4 — Promotion (Protocol §6, skill: scale)
  Minimal -> Core -> Standard, always one tier at a time,
  triggered by real thresholds, never guessed or skipped.


Orthogonal after adoption — Release Update (Protocol §7):

  annotated stable tag -> inspect Skills Kit and project state separately
      -> report compatibility/schema impact and exact preview
      -> owner confirms
      -> refresh standard skills and apply only release-required state changes
      -> verify discovery, authority chain, and Cold Agent Test

  Updating is not re-adoption, tier promotion, or implicit schema migration.


Orthogonal, not a stage — can attach at any point in Stage 3:

  Craft Layer Modules (Protocol §7.6 manifest, §7.7 reference)
  Opt-in, external, never bundled — e.g. emilkowalski/skills.
  Agnostic until installed -> Hard Default for that one domain.

Also orthogonal:

  linis — scoped cleanup pass, run once a version ships or a milestone
  closes. Never run against active work.

Runtime discovery (user-level, shared by every repository):

  ~/.agents/skills/*  -> symlinks to ~/.banka/versions/<tag>/skills-kit/* (Codex)
  ~/.claude/skills/*  -> symlinks to ~/.banka/versions/<tag>/skills-kit/* (Claude Code)
  Each installed release gets its own immutable git worktree at a fixed,
  shared path — never a symlink straight into a developer's own mutable
  working clone, which would couple every project to whatever that clone
  currently has checked out. Symlinking is the fresh-install default for
  both; an existing install (mutable-checkout symlink or copy) changes only
  through the confirmed update procedure (Protocol §7).
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
requirement — Docking's own term, precisely defined in its own protocol. When
current evidence does not already establish readiness, Banka routes the
project through the current Banka Docking Protocol. Docking may itself
identify scope that is unclear or not decision-ready; when that happens,
complete the required scope clarification and then return to Docking. Banka
adoption resumes only after Docking establishes `Ready for Banka` and the owner
chooses to continue — reaching that status permits adoption to begin; it does
not mean adoption is complete (Protocol §0.4).

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

The tier resolved in Stage 1 determines the file shape. `AGENTS.md` is the
canonical, runtime-neutral source of truth at every tier. Its one marked
schema-2 Banka block declares the tier: Minimal keeps live state in the block
and has no state folder; Core routes to the files under `/core/` (see
`full-context-templates/core/`); Standard routes to the files under
`/context/` (see `full-context-templates/standard/`). For Claude Code, `CLAUDE.md` is exactly
the one-line `@AGENTS.md` import, so it does not duplicate state. Every default
written into shared state is governed by §2.6's Layer Principle—Agnostic
defaults (stack, language, styling) get contrasted, never picked for the user;
Hard Defaults (error handling, comment policy, the registry in §2.6) get stated
as settled fact.

## Stage 3 — The Build Loop (skills-kit/)

The Skills Kit is exposed through the supported runtime's discovery location
and used across every Banka-enabled project regardless of tier. Each first
resolves the marked schema-2 block in `AGENTS.md`, then follows its declared
shape to Minimal's inline state, Core's `/core/`, or Standard's `/context/`.
Recognizable older CLAUDE-first projects may be read in compatibility mode but
are not rewritten until an explicitly requested, previewed, and confirmed
migration. Conflicting or incomplete state stops state-dependent work rather
than inviting a guess. A typical session runs charter → optional delegate →
build → survey → moor, with dredge or watershed used when routed there, and
verify when a Layer 3 claim is blocked (Core/Standard only). Remember
closes and restores sessions after checking disk and version-control reality.
Claude Code uses `/skill-name`; Codex uses `$skill-name`.

Protocol §7.1 defines an operational perspective as a temporary accountability
frame embedded inside an existing Banka skill — Outcome Owner, User, Builder,
Maintainer, and Risk Owner. Applicable perspectives alter the way a skill
examines its subject, not Banka's lifecycle or authority boundaries.

## Stage 4 — Promotion (§6, scale)

A project can outgrow its tier. The scale skill promotes exactly one tier at a
time — Minimal → Core, or Core → Standard, never skipping — only when a real
threshold is met or explicitly requested. It works only from active schema-2
state, shows what moves where, keeps the matching tier marker, and preserves
the exact `CLAUDE.md` import before anything old is deleted. Legacy state must
complete the confirmed migration sequence before promotion.

## Existing-project release updates (§7)

An update starts from an annotated stable release tag and treats the
machine-level Skills Kit separately from managed project state. It inspects
both, reports compatibility and state-schema impact, previews every mutation,
and waits for confirmation. Standard skills are then refreshed and project
state changes only when the release requires it. The process finishes by
verifying runtime discovery, Section 3.1's authority chain, and the Cold Agent
Test; it never substitutes for adoption, promotion, or legacy migration.

## Orthogonal: Craft Layer Modules (§7.6 / §7.7) and linis

Two mechanisms can engage at any point in Stage 3: a Craft Layer module is
Agnostic until a project opts in, then Hard Default for that domain only.
Linis removes narrative residue from settled files while preserving operational
history, provenance, compatibility facts, and load-bearing rationale.

## Framework Change-Impact Map

A maintenance aid for editing Banka itself, not a new authority. It names
where to look when a framework concept changes — it does not restate what
that concept currently is, so it can't drift into a second definition
(Protocol §2.8). Verify each row against the repository before relying on
it; several rows are already enforced by `scripts/check-repo-integrity.sh`.

| Framework concept | Inspect when changed |
| --- | --- |
| State schema markers | `protocol/Banka.md` §3, all three project-entry templates, every skill's state-resolution block, the integrity script's marker/count checks |
| Tier shape and required files | `protocol/Banka.md` §3–§5, project-entry templates, `full-context-templates/core/` and `/standard/`, `scale`, every skill's tier-shape description, the integrity script's required-file checks |
| Skill roster | `protocol/Banka.md` §7, `README.md`'s skill table, this file's Stage 3, the integrity script's skills list |
| Delegation handoff block | `delegate/SKILL.md`, `full-context-templates/delegation-queue.md`, the integrity script's byte-identical check |
| Delegation tier model | `protocol/Banka.md` §7.5, `delegate/SKILL.md`, `full-context-templates/delegation-queue.md`, `README.md`'s skill table and build loop, this file's Stage 3 |
| Operational perspectives | `protocol/Banka.md` §7.1, `charter`/`survey`/`watershed` SKILL.md, the integrity script's persona-ban and label checks |
| `CLAUDE.md` shim | `protocol/Banka.md` §3, `full-context-templates/project-entry/CLAUDE.md`, the integrity script's shim check |
| Release version | `protocol/Banka.md`'s title line, `README.md`, `CHANGELOG.md`, `VERSION`, the integrity script's version checks |
| Existing-project release update | `protocol/Banka.md` §7's update procedure, `README.md`'s install/adopt/update prompts, `BANKA-ADOPTION-GUIDE.md` §6, release compatibility/action/schema notes in `CHANGELOG.md`, annotated release tags, the integrity script's update-path checks |
| Session-state and delegation-queue bloat mechanism | `protocol/Banka.md` §2.9, `remember`/`moor`/`delegate` SKILL.md, `charter`'s Outcome Owner check, `scale`'s disambiguation note, the tier's `overflow/` folder shape, `full-context-templates/delegation-queue.md`'s own note |
| Claim verification (`verify`) | `protocol/Banka.md` §4/§5 (`verified-index.md`), §7 (roster/provenance), `verify/SKILL.md`, `survey`'s Layer 3 routing, `moor`'s promotion check, the integrity script's skills list |
| CONTRIBUTING.md adoption-time generation | `protocol/Banka.md` §8, `full-context-templates/project-entry/CONTRIBUTING.md`, the integrity script's project-entry template checks |
| Downstream self-containment | `scripts/check-cold-downstream.sh`, any skill or template that could reference protocol-only content |
