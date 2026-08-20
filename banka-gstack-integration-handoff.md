<!--
Non-Banka execution handoff. This repository intentionally has no Banka project
state, so this file is not a delegation-queue.md and must not be interpreted as
one. It borrows the delegate skill's ticket discipline for repository work only.
-->

# Banka–gstack Integration — Non-Banka Execution Handoff

**Generated from:** `banka-gstack-integration-plan.canvas.tsx`  
**Generated:** 2026-08-20  
**Status:** Senior-required items complete; Junior-safe tickets ready

## Authority and boundary

This is an ordinary repository-maintenance handoff, not Banka-managed project
state. The Banka source repository intentionally has no `/context/`, `/core/`,
or project-state `CLAUDE.md`, so this file does not create or imply a Banka tier,
session memory, or delegation queue.

The approved direction is to adopt selected gstack review habits as embedded
Banka operational perspectives. Do not install gstack, add a gstack router,
create new Banka commands, add generated project-state files, or change ASMP or
Docking behavior.

## Execution order

1. Senior-required items A, B, and C are complete. Their implementation and
   semantic-pilot record appear below.
2. Execute Tickets 1 and 2. They are independent after A and B are complete,
   but must run serially when sharing this checkout.
3. Execute Ticket 3 after Tickets 1 and 2 pass review.

Do not begin a dependent item early. A fresh session isolates conversation
history, not files. Parallel work requires a separate Git worktree and branch
per session; otherwise use one ticket at a time in this checkout.

## Ready for fresh-session execution

- [ ] Ticket 1: Synchronize public documentation — document operational
  perspectives in `README.md` and `system-map.md` without changing the lifecycle.
- [ ] Ticket 2: Strengthen repository integrity checks — protect the nine-skill
  inventory and the Watershed perspective vocabulary.
- [ ] Ticket 3: Verify the ecosystem boundary — run all three repository checks
  and report drift without editing files.

## Completed in senior-capability execution

- [x] **Item A — Define the canonical operational-perspective contract.**
  Senior-required because it establishes a new authoritative protocol concept
  and must preserve tier, runtime, and ecosystem boundaries.
- [x] **Item B — Embed the contract in Charter, Survey, and Watershed.**
  Senior-required because it changes cross-cutting skill behavior and requires
  judgment about approval gates, review authority, conditional triggers, and
  multi-perspective isolation.
- [x] **Item C — Run and judge the Oykon semantic pilot.** Senior-required because
  semantic success cannot be reduced to string or structural checks; the
  reviewer must decide whether the new discipline improves behavior without
  creating scope creep or a hidden workflow layer.

## Split and merge reasoning

- README and system-map synchronization are one ticket because both describe
  the same accepted contract and neither can be considered correct while they
  disagree.
- Integrity-script work remains separate because it touches one established
  shell check and has an independently checkable result.
- Final ecosystem verification remains separate because it is read-only and
  should evaluate the completed documentation and integrity work together.
- No Senior-required item is merged into a Junior-safe ticket.

## Full ticket specifications

### Ticket 1: Synchronize public documentation

**Tier:** Junior-safe  
**Required capability:** Junior-safe or higher; a stronger model may execute this ticket  
**Dependencies:** Senior-required items A and B must already be complete and reviewed.  
**Pattern to match:** `README.md` under `## The build loop`, and
`system-map.md` under `## Stage 3 — The Build Loop (skills-kit/)`  
**Files to touch:**

- `README.md`
- `system-map.md`

**Files to NOT touch:**

- `protocol/Banka.md`
- everything under `skills-kit/`
- everything under `full-context-templates/`
- `scripts/check-repo-integrity.sh`
- `BANKA-ADOPTION-GUIDE.md`
- `banka-gstack-integration-plan.canvas.tsx`
- this handoff file
- every file in the ASMP and Docking repositories

**Spec:**

1. In `README.md`, add a concise `### Operational perspectives` subsection
   within `## The build loop`, after the paragraph explaining skill invocation
   and before the paragraph beginning `Delegated tickets run serially`.
2. State all of the following, without adding new behavior:
   - An operational perspective is a temporary accountability frame embedded
     inside an existing Banka skill.
   - The canonical perspectives are Outcome Owner, User, Builder, Maintainer,
     and Risk Owner.
   - Perspectives are not personas, commands, lifecycle gates, generated
     project files, or persistent project roles.
   - A skill applies only the perspectives relevant to its existing purpose and
     still emits its normal output.
   - gstack informed selected review habits, but is not a Banka dependency,
     replacement workflow, or Craft Layer module. Link `garrytan/gstack` by its
     canonical GitHub URL; do not copy its instructions or command catalog.
3. Add a concise `## Influences and attribution` section in `README.md` after
   `## This repo's own structure` and before `## Optional: Craft Layer modules`.
   It must state:
   - Banka's original five-skill foundation was inspired by JavaScript
     Mastery / Adrian Hajdin's earlier agent-skills workflow. Name the earlier
     five commands exactly as documented by the linked context repository:
     `architect`, `remember`, `review`, `recover`, and `imprint`.
   - Banka's Standard-tier nine-file context layer was inspired by JavaScript
     Mastery's nine-file context template.
   - Link both canonical sources:
     `https://github.com/jsmastery-pro/skills` and
     `https://github.com/jsmastery-pro/context-driven-dev`.
   - The current JavaScript Mastery skills repository has evolved into a
     broader workflow, and both upstream projects evolve independently from
     Banka. Do not imply that Banka mirrors their current commands or contracts.
   - gstack informed the newer operational-perspective review discipline. Link
     `https://github.com/garrytan/gstack` and state that it remains an influence,
     not a dependency or replacement workflow.
4. Keep the skills table at exactly nine rows. If the completed Senior work
   materially changes the quick-reference wording, revise only the descriptions
   for `charter`, `survey`, and `watershed`; do not add a perspective skill.
5. In `system-map.md`, add one compact line inside Stage 3 explaining that
   applicable operational perspectives are embedded inside existing skills.
6. Add one short paragraph under the prose `## Stage 3 — The Build Loop
   (skills-kit/)` explaining that perspectives alter the way a skill examines
   its subject, not Banka's lifecycle or authority boundaries.
7. Preserve these existing facts exactly in substance:
   - ASMP defines scope.
   - Docking verifies readiness.
   - Banka adopts and operates.
   - Charter still waits for plan approval.
   - Survey remains report-only and routes findings.
   - Watershed remains exceptional for contested or high-stakes decisions.

**Done when:**

- Both files use the same five perspective names and the same definition.
- Neither file introduces a new command, skill, gate, generated artifact, or
  gstack installation step.
- The README names and links both JavaScript Mastery sources and gstack, while
  describing all three as influences rather than current Banka authorities.
- The Stage 0–4 order in `system-map.md` is unchanged.
- The README skills table still lists exactly the nine existing Banka skills.
- `git diff --check -- README.md system-map.md` exits successfully.

**Do not:**

- Do not change canonical protocol or skill behavior to make the prose fit.
- Do not use “AI team,” “persona simulator,” or character-role framing.
- Do not imply that ASMP or Docking depends on this perspective model.
- Do not stage, commit, push, or edit this handoff's checkboxes.

### Ticket 2: Strengthen repository integrity checks

**Tier:** Junior-safe  
**Required capability:** Junior-safe or higher; a stronger model may execute this ticket  
**Dependencies:** Senior-required items A and B must already be complete and reviewed.  
**Pattern to match:** existing checks and the `fail` helper in
`scripts/check-repo-integrity.sh`  
**Files to touch:**

- `scripts/check-repo-integrity.sh`

**Files to NOT touch:**

- `README.md`
- `system-map.md`
- `protocol/Banka.md`
- everything under `skills-kit/`
- everything under `full-context-templates/`
- `BANKA-ADOPTION-GUIDE.md`
- both integration artifacts in the repository root
- every file in the ASMP and Docking repositories

**Spec:**

Extend the existing script using its current Bash style and `fail` helper:

1. Count discovered `skills-kit/*/SKILL.md` files and require that count to
   equal the length of the existing `skills` array. This must detect an
   unexpected tenth skill as well as a missing skill; do not replace the
   existing per-skill name checks.
2. Require the canonical protocol heading
   `## SECTION 7.1: OPERATIONAL PERSPECTIVES` to exist exactly once in
   `protocol/Banka.md`.
3. Fail when `skills-kit/watershed/SKILL.md` contains the standalone word
   `persona` or `personas`, case-insensitively. Do not scan generated
   `## Persona` headings elsewhere in the protocol; their migration is
   explicitly out of scope.
4. Require all five labels—`Outcome Owner`, `User`, `Builder`, `Maintainer`,
   and `Risk Owner`—to occur in `skills-kit/watershed/SKILL.md`.
5. Preserve the current checks for canonical names, repository-local
   duplicates, Banka block markers, and obsolete terminology.

**Done when:**

- `sh scripts/check-repo-integrity.sh` exits zero on the accepted integration.
- A temporary extra `skills-kit/<name>/SKILL.md` would make the count check fail
  if introduced; do not create such a file merely to demonstrate the check.
- The script remains readable under `set -euo pipefail` and introduces no new
  dependency beyond commands it already uses plus POSIX utilities already
  required by the repository.
- `git diff --check -- scripts/check-repo-integrity.sh` exits successfully.

**Do not:**

- Do not rewrite the script or reorder unrelated checks.
- Do not enforce the removal of existing project-level `## Persona` headings.
- Do not modify skill content to make a failing check pass.
- Do not stage, commit, push, or edit this handoff's checkboxes.

### Ticket 3: Verify the ecosystem boundary

**Tier:** Junior-safe  
**Required capability:** Junior-safe or higher; a stronger model may execute this ticket  
**Dependencies:** Senior-required items A and B, Ticket 1, and Ticket 2 must be complete and reviewed.  
**Pattern to match:** the verification commands documented by each repository's README and integrity script  
**Files to touch:** none; this is a read-only verification ticket  
**Files to NOT touch:** every file in Banka, ASMP, and Docking

**Accepted starting state:** This ticket inherits the accumulated, uncommitted
work from completed Senior Items A–C and Junior Tickets 1–2. A dirty Banka
checkout is expected and is the verification subject, not a blocker. The
accepted changed-path set is:

- `README.md`
- `protocol/Banka.md`
- `scripts/check-repo-integrity.sh`
- `skills-kit/charter/SKILL.md`
- `skills-kit/survey/SKILL.md`
- `skills-kit/watershed/SKILL.md`
- `system-map.md`
- `banka-gstack-integration-handoff.md`
- `banka-gstack-integration-plan.canvas.tsx`

Before the session starts, the coordinating user must explicitly confirm that
the Ticket 1 and Ticket 2 sessions have ended, nobody else is editing this
checkout, and the dirty state above is accepted as Ticket 3's baseline. One
registered worktree is the expected serial-execution setup. Neither dirty files
nor a single worktree is evidence of concurrent activity.

**Spec:**

1. Capture `git status --short` for all three repositories before verification.
2. Compare Banka's changed paths with the accepted set above. Stop for an
   unexplained path, but do not stop merely because an accepted path is dirty.
3. Do not attempt to prove session ownership with Git status, worktree count,
   index-lock checks, or process inspection. Ownership comes from the
   coordinator's explicit handoff.
4. Run these commands exactly from any directory:

```bash
sh /Users/madridj1689/Code/projects/Banka/scripts/check-repo-integrity.sh
sh /Users/madridj1689/Code/projects/banka-docking-protocol/scripts/check-repo-integrity.sh
bash /Users/madridj1689/Code/projects/adaptive-scope-mapping-protocol/scripts/check-repo-integrity.sh
git -C /Users/madridj1689/Code/projects/Banka diff --check
git -C /Users/madridj1689/Code/projects/Banka status --short
git -C /Users/madridj1689/Code/projects/banka-docking-protocol status --short
git -C /Users/madridj1689/Code/projects/adaptive-scope-mapping-protocol status --short
```

5. Inspect the Banka diff and report:

- whether every integrity command passed;
- whether ASMP and Docking remain unmodified;
- whether the Banka change set is limited to the approved protocol, three
  skills, two public docs, integrity script, and the two root integration
  artifacts;
- any unexpected tracked or untracked file, without deleting or modifying it;
- whether the nine-skill inventory, tier templates, Stage 0–4 order, Charter
  approval gate, Survey report-only boundary, and Watershed escalation boundary
  remain intact.
6. Capture the three repository statuses again. Stop and report possible
   concurrent drift if any status changed during this read-only session.

**Done when:**

- The report names each command and its exit result.
- The report distinguishes structural-check success from the already-completed
  semantic pilot recorded under Senior-required item C; it does not rerun or
  overstate that pilot.
- The verification session leaves all three working trees byte-for-byte
  unchanged from its starting state.
- Banka's before/after status snapshots match exactly, and ASMP and Docking are
  clean in both snapshots.

**Do not:**

- Do not fix, format, stage, commit, clean, reset, or delete anything.
- Do not treat a clean checkout as proof that prose semantics are correct.
- Do not treat expected dirty files or one registered worktree as concurrency.
- Do not run the Oykon semantic pilot; it is complete and recorded above.

## Senior-required item briefs

These are intentionally not Junior-safe tickets. A senior-capability session
must recover the approved blueprint, inspect the relevant repository sources,
and resolve judgment calls within the boundaries below.

### Item A: Define the canonical operational-perspective contract

**Primary file:** `protocol/Banka.md`  
**Required result:** Add `## SECTION 7.1: OPERATIONAL PERSPECTIVES` under the
Skills Kit section. Define the five perspectives, applicability discipline,
evidence and output rules, and explicit non-goals. State that perspectives are
embedded behavior—not commands, gates, persistent roles, generated files,
Craft Layer modules, or a gstack dependency. Preserve the existing generated
`## Persona` fields; their migration is a separate versioned decision.

### Item B: Embed perspectives in existing skills

**Primary files:**

- `skills-kit/charter/SKILL.md`
- `skills-kit/survey/SKILL.md`
- `skills-kit/watershed/SKILL.md`

**Required result:** Charter applies Outcome Owner by default and activates
other perspectives only when their trigger is relevant, without weakening its
language-alignment or approval gates. Survey retains its three layers and
report-only boundary while adding user-flow, maintainability, concrete-failure,
and evidence discipline. Watershed uses the five canonical perspective names,
removes internal persona terminology, preserves isolated audits and
consolidation, and remains exceptional rather than routine. Do not change the
other six skills in this first release.

### Item C: Run and judge the Oykon semantic pilot

Run the three approved scenarios from the blueprint:

1. Charter an Oykon inventory-forecasting feature and verify the Outcome Owner
   challenges the premise without silently changing scope.
2. Survey a cost-calculation implementation with a missing material price and
   verify it reports the visible failure instead of accepting `Cost = 0` or
   fixing the implementation automatically.
3. Run Watershed on an Oykon architectural fork and verify the five
   perspectives produce distinct findings followed by one recommendation.

Record the observed behavior in the review handoff or commit/PR description,
not in a new Banka project-state file. If a scenario exposes a semantic defect,
return to Item A or B deliberately; do not patch around it in documentation.

## Senior semantic-pilot record

**Date:** 2026-08-20  
**Method:** Instruction-level dry run against the three approved synthetic
Oykon scenarios. This validates the skill contracts; it is not a claim that an
Oykon application or deployment was executed. Watershed's five revised
perspective briefs were evaluated separately before consolidation so their
responsibilities could be compared without treating one lens as the others.

### Scenario 1 — Charter: inventory forecasting

**Result:** PASS. The Outcome Owner is always active and must test whether
forecasting is the direct solution or a proxy for inaccurate inventory state or
missing production visibility. Any move to hold, reduce, or expand scope becomes
an explicit recommendation that waits for user agreement. The other
perspectives activate only when their triggers apply, so the scenario does not
automatically become a five-part review.

### Scenario 2 — Survey: missing material price

**Result:** PASS. A calculation that converts a missing material price into
`Cost = 0` fails production readiness: it creates a concrete visible-risk
scenario, does not preserve truthful cost state, and lacks a defined recovery
path. The new evidence rule prevents a `PASS` without code, test, observed
behavior, or a declared rule. Survey still reports and routes the finding; it
does not change the implementation.

### Scenario 3 — Watershed: Oykon domain-model fork

**Subject:** Choose between a shallow `Orders / Inventory / Costs` model and an
explicit `Order / Production Run / Material Consumption / Cost Event` model.

**Distinct perspective findings:**

- **Outcome Owner:** the model must reduce production mistakes and support
  trustworthy costing; extra entities are justified only when they trace those
  outcomes rather than merely making the design look comprehensive.
- **User:** the explicit model matches the operator's real sequence from order
  receipt through material check, production, completion, and cost review.
- **Builder:** production runs, consumption, and cost events establish clearer
  data ownership and prevent implementation from inventing those boundaries
  across unrelated tables later.
- **Maintainer:** explicit events improve traceability and future change safety,
  provided their lifecycle and naming are documented rather than inferred.
- **Risk Owner:** the shallow model makes missing prices, partial consumption,
  retries, and cost corrections easier to collapse into silent or irreversible
  data errors.

**Consolidated recommendation:** adopt the explicit production and cost-event
concepts needed for the named operational flow, but do not add unrelated
forecasting, partner-payment, marketplace, or reporting abstractions. This
prioritizes the Outcome Owner's scope boundary while accepting the Builder,
Maintainer, User, and Risk Owner evidence that the shallow model cannot safely
represent the core workflow.

**Result:** PASS. The five canonical perspectives produced distinct findings,
the consolidation made a real choice, and the skill still hands the decision
back without implementation.

## Senior Survey record

**Subject:** Senior-required Items A, B, and C  
**Project-state note:** This repository is intentionally unstructured/non-Banka;
the review used the approved canvas, this handoff, and the authoritative
repository documentation rather than inventing project-state invariants.

### Layer 1 — Plan alignment

PASS. The canonical contract defines exactly five temporary perspectives and
the agreed non-goals. Charter, Survey, and Watershed embed them without adding a
skill, command, mode, gate, or generated artifact. The Oykon semantic pilot is
recorded above. Public README/system-map synchronization remains intentionally
delegated to Ticket 1 rather than being silently absorbed into Senior scope.

### Layer 2 — System integrity

PASS. The Skills Kit remains nine skills; generated tier templates and the
Stage 0–4 lifecycle are untouched. Charter's language and explicit-approval
gates remain in place, Survey remains report-only, and Watershed still performs
isolated review followed by consolidation and hand-back. ASMP and Docking have
no working-tree changes.

### Layer 3 — Production readiness

PASS for this documentation/skill change. `git diff --check` and all three
repository integrity scripts pass. The external provenance claims were checked
against the current canonical gstack and JavaScript Mastery repositories, while
the prose explicitly distinguishes historical influence from current upstream
behavior. Junior Ticket 2 will add mechanical regression checks for the new
contract; Ticket 3 will repeat final read-only ecosystem verification after all
Junior work.

### Summary

0 issues remain across 3 layers. Senior-required work is ready for the three
Junior-safe tickets.

## Fresh-session prompts

### Junior-safe ticket

```text
Open /Users/madridj1689/Code/projects/Banka/banka-gstack-integration-handoff.md
and read only Ticket [N] under “Full ticket specifications.” That ticket is
your entire scope. Confirm its dependencies are complete.

The coordinating user must explicitly tell you that the previous session has
ended and transfer this checkout to you. Existing dirty files may be accepted
outputs from finished tickets; Git status does not prove another session is
active. Compare the actual changed paths with the ticket's accepted starting
state or the coordinator's stated baseline. Stop for unexplained drift or an
unclosed session, not merely because the checkout is dirty. If work is actually
parallel, stop unless this session has a separate Git worktree and branch.

Do not infer requirements from this conversation; use the ticket and the exact
pattern files it names. Do not touch files outside its “Files to touch” list.
If any dependency or required value is missing, stop and report the gap rather
than guessing. When finished, report each “Done when” condition individually.
Do not stage or commit.
```

### Ticket 3 — read-only final verification

Use this only after Tickets 1 and 2 have completed and passed Senior Survey:

```text
Open /Users/madridj1689/Code/projects/Banka/banka-gstack-integration-handoff.md
and read only Ticket 3 under “Full ticket specifications.” Ticket 3 is your
entire scope and is read-only.

Coordinator confirmation: the Senior sessions and Junior Ticket 1 and Ticket 2
sessions have ended. No other session is editing this checkout. Ownership of
the checkout is transferred to you for read-only Ticket 3 verification. The
dirty Banka files listed under Ticket 3's “Accepted starting state” are expected
completed work and must not be treated as a blocker or reset. One registered
worktree is expected because execution is serial.

Capture the three repositories' status before doing anything. Stop only if:
- a dependency is incomplete;
- an actual changed path is outside Ticket 3's accepted set;
- the coordinator confirmation above is missing; or
- repository status changes during your read-only verification.

Do not infer concurrent activity from dirty files, one worktree, or the absence
of an index lock. Run the exact verification commands in Ticket 3, touch no
files, and report every “Done when” condition individually. Do not fix, format,
stage, commit, push, clean, reset, or delete anything.
```

### Senior-required item

```text
Open /Users/madridj1689/Code/projects/Banka/banka-gstack-integration-plan.canvas.tsx
and /Users/madridj1689/Code/projects/Banka/banka-gstack-integration-handoff.md.
Read the named Senior-required item and the repository sources it cites.
Confirm that this is a senior-capability session and that no other session is
editing this checkout. Preserve the Banka/ASMP/Docking authority boundaries and
resolve judgment calls explicitly before editing. Do not stage or commit.
```

## Completion handling

After each Junior-safe ticket finishes, review it in a senior-capability
session using the Survey skill against the ticket's `Done when` conditions.
Only the coordinating senior session should mark a checkbox complete in this
artifact. Run shared-checkout tickets serially unless separate worktrees and
branches were explicitly assigned.
