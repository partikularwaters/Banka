# Banka

Banka helps coding agents pick up a project reliably across sessions. It keeps
the project's purpose, decisions, current state, and working rules in a clear,
durable structure, so the next session starts from what the project knows—not
from a guess at what the last conversation meant.

It begins with an adoption workflow that checks whether the project is ready
for reliable AI-assisted work. It then provides reusable skills for the build
loop: planning, delegation, review, recovery, and session handoff. Banka is
agnostic about the stack and deliberate about quality.

Small projects stay simple. As a project genuinely needs more room, Banka adds
structure one tier at a time: Minimal, Core, then Standard. That proportional
structure is the primary reliability benefit. It can also reduce unnecessary
context because future sessions have fewer ambiguous places to search, but
that is a consequence—not a promise of universal token efficiency.

**Release:** Banka 2.0.1. This release version identifies the Banka package;
the separate state schema identifies the on-disk project format. Banka 2.0.1
uses state schema 2. See [VERSION](VERSION) and [CHANGELOG.md](CHANGELOG.md).

**New here?** Jump straight to [Getting started](#getting-started) to begin.

## Why "Banka" 🛶

*Banka* — shortened from *bangka*, Tagalog for the traditional Philippine
outrigger boat — is simple, stable, and built to be steered deliberately
rather than left to drift. That's the role this framework plays: it doesn't
build the project for you, it keeps it pointed at a chosen destination through
every session in between. Decision-ready scope sets the heading. The Skills Kit —
`charter`, `survey`, `dredge`, `moor`, and the rest — is the crew that keeps
the vessel on course, correcting drift instead of letting each session start 
over from nowhere. The destination is never abstract: a haven, the harbor a
project was actually scoped to reach, not just wherever momentum happens to
leave it.

```
Project entry ──►  adoption conditions evaluated
        |
        v
adoption review  ──►  tier resolved: Minimal / Core / Standard
        |
        v
tier generation  ──►  Banka project state established
        |
        v
the build loop (skills-kit/, repeats every session)
        |
        v
promotion, if the project outgrows its tier
```

This is the compressed version. For the full picture—one diagram, one paragraph
per stage, every arrow explained—read [system-map.md](system-map.md) first.
[protocol/Banka.md](protocol/Banka.md) is the exact technical contract; if
anything here or in the system map differs, the protocol wins.

## Entering Banka

You can start with Banka. You do not need to determine in advance how a
project should enter the adoption process.

Banka requires two conditions before adoption can begin: decision-ready scope
and sufficient readiness evidence. If those conditions are not already present,
the project may need additional clarification or preparation before Banka
adoption proceeds.

```
Start with Banka
      |
      v
Does the project have
decision-ready scope?
      |              |
     no             yes
      |              |
      v              |
Clarify scope        |
(using an appropriate |
scope method)        |
      |              |
      +--------------+
             |
             v
Is this an existing
or brownfield project?
      |              |
     no             yes
      |              |
      v              v
Banka adoption   Does sufficient
begins           readiness evidence exist?
                       |              |
                      no             yes
                       |              |
                       v              |
                 Prepare readiness    |
                 evidence             |
                 (using an appropriate|
                 readiness method)    |
                       |              |
                       +--------------+
                              |
                              v
                       Banka adoption
                              |
                              v
                       Banka operation
```

## Conditions for adoption

Before Banka adopts a project, two conditions must be present.

### Decision-ready scope

Banka requires a clear enough destination to structure reliable AI-assisted
work: a stated purpose, users, a staged feature scope, constraints, and a
definition of done — the exact checklist [protocol/Banka.md](protocol/Banka.md#section-15-scoping-intake) §1.5 runs against.

A specific scoping method is not required. The requirement is that the intended
outcome is sufficiently clear to guide decisions.

### Readiness evidence

Banka requires enough understanding of the project's current state before
operating on an existing project. Readiness evidence and the `Ready for Banka`
status are Banka Docking's own terms, not Banka's — Docking's protocol defines
both precisely; Banka only requires that the evidence exist, however it was
established.

A specific preparation method is not required. The requirement is that the
project's readiness has been sufficiently established.

## Related protocols

The following protocols are optional. Banka does not require them when
decision-ready scope and sufficient readiness evidence already exist through
other means.

**ASMP ([Adaptive Scope Mapping Protocol](https://github.com/partikularwaters/adaptive-scope-mapping-protocol))** defines decision-ready scope from
unclear, evolving, or incomplete intent. It is one method for creating
decision-ready scope before Banka adoption.

**Docking ([Banka Docking Protocol](https://github.com/partikularwaters/banka-docking-protocol))** verifies readiness evidence for existing or
brownfield projects. It is one method for preparing a project whose current
state has not yet been sufficiently established.

**ASMP defines scope. Docking verifies readiness. Banka adopts and operates.**

These protocols remain independently useful and are not dependencies of Banka.

## The skills

Nine Skills with one canonical source, exposed through each supported runtime's
discovery location and used across every Banka project regardless of tier:

| Skill | What it does |
| --- | --- |
| `charter` | Thinks through what's about to get built like a senior engineer would, before any code — surfaces decisions, produces a plan you confirm first. |
| `delegate` | Splits an approved plan into Junior-safe tickets, Senior-required work (current session or fresh-session handoff, decided per ticket), and Owner-required work only the project owner can do. Model choice remains explicit and user-controlled. |
| `survey` | Checks a build against what was planned, the project's own declared rules, and production-readiness — then routes real findings to the right next skill. |
| `dredge` | Diagnoses a build failure before responding to it — including when it can't be reproduced at all — targeted fix, hard reset, or genuine rethink are different problems. |
| `watershed` | Runs a genuinely contested or high-stakes call through five independent perspectives, then consolidates one recommendation. |
| `moor` | Captures a UI pattern or engineering outcome once it's settled — registry and invariant captures wait for survey to pass first — so the next session builds on it instead of drifting. |
| `remember` | Saves session state on close, restores it on open — always checking disk/git reality first, and keeping the session-state file itself from bloating as it grows. |
| `scale` | Promotes a project exactly one tier at a time, Minimal → Core → Standard, only when a real threshold is met. |
| `linis` | Cleans narrative residue from settled files while preserving operational history, provenance, compatibility facts, and load-bearing rationale. Never runs against active work. |

Each skill's full behavior lives in its own `SKILL.md` under [skills-kit/](skills-kit/) — the table above is the quick-reference, not the source of truth.

## Getting started

New to Banka? [Install the Skills Kit](#installing-the-skills-kit) once per
machine, then [adopt a project](#adopting-a-project) to bring Banka into a
specific repo. Already using Banka? Follow [Updating Banka](#updating-banka)
instead of adopting the project again.

## Installing the Skills Kit

`skills-kit/` is the canonical source for all nine skills. Choose the discovery
path for the runtime you use.

If Banka is already installed as real directories for one supported runtime,
an experienced multi-runtime user may instead link a second runtime's Banka
skill directories to that first installation. Link only to the real primary
installation — never another symlink, a temporary checkout, or a Banka clone
used for development. Updating the primary copy updates both runtimes; moving
or deleting it breaks the linked runtime. Independent copies remain supported
when the runtimes should not share updates.

### Claude Code

Paste this into a fresh Claude Code session — no pre-cloning needed, the agent
does it:

```
Clone https://github.com/partikularwaters/Banka.git to a temporary directory,
fetch tags, and check out the newest annotated stable vMAJOR.MINOR.PATCH tag
by semantic-version order. Verify that the tag is annotated and its commit's
VERSION matches the tag, and do not use newer unreleased commits from the
default branch. If no valid stable tag exists, stop instead of falling back to
the default branch. Before installing, check
~/.claude/commands/, ~/.claude/skills/, and, if this is a specific project,
its own .claude/commands/ and .claude/skills/, for any existing file using
one of these nine names: charter, delegate, dredge, linis, moor, remember,
scale, survey, watershed. If you find one, don't delete it unilaterally —
back it up and ask me how to reconcile it before installing over it.
Run scripts/check-repo-integrity.sh in the selected checkout to verify the
repository contents. Then copy each complete skills-kit/<skill-name>/ directory
into ~/.claude/skills/<skill-name>/ as-is. Verify every installed skill
directory exactly matches the selected release before removing the temporary
checkout.
```

Invoke skills with `/skill-name`, for example `/charter` or `/remember restore`.

Full install details and rationale: [protocol/Banka.md](protocol/Banka.md), Section 7.

### Codex

Paste this into a fresh Codex session — no pre-cloning needed, the agent does
it:

```
Clone https://github.com/partikularwaters/Banka.git to a temporary directory,
fetch tags, and check out the newest annotated stable
vMAJOR.MINOR.PATCH tag by semantic-version order. Verify that the tag is
annotated and its commit's VERSION matches the tag, and do not use newer
unreleased commits from the default branch. If no valid stable tag exists, stop
instead of falling back to the default branch. Before installing, check
~/.agents/skills/ and the projects I use for an existing Banka skill with the
same name — Codex can show duplicate same-named skills and does not merge
them, so migrate or remove an old project-local copy only after confirming
it isn't customized. Run scripts/check-repo-integrity.sh in the selected
checkout to verify the repository contents. Then copy each complete
skills-kit/<skill> directory into ~/.agents/skills/<skill>/ for these nine
skills: charter, delegate, dredge, linis, moor, remember, scale, survey,
watershed. Confirm every installed entry contains a readable SKILL.md and
exactly matches the selected release before removing the temporary checkout.
```


Invoke skills with `$skill-name`, for example `$charter` or `$remember restore`.

The install prompts run `scripts/check-repo-integrity.sh` before removing the
source checkout. It verifies repository contents — all nine canonical
`SKILL.md` files and names, project-entry blocks, and known obsolete terminology
— while the separate tag/`VERSION` checks establish release provenance and the
post-copy comparison verifies the installation.

The Banka source repository is not itself a Banka-enabled application project:
it intentionally has no project-state `AGENTS.md`, `CLAUDE.md`, `/core/`, or
`/context/`.
Read-only skills can inspect an explicitly supplied subject and these repository
docs; state-writing skills stop rather than treating the repository as Minimal.

## Adopting a project

Once the Skills Kit is installed, paste this into a fresh session working in
your project's directory:

```
Clone https://github.com/partikularwaters/Banka.git to a temporary directory,
fetch tags, and check out the newest annotated stable vMAJOR.MINOR.PATCH tag
by semantic-version order. Verify that the tag is annotated and its commit's
VERSION matches the tag, and do not use newer unreleased commits from the
default branch. If no valid stable tag exists, stop instead of falling back to
the default branch. Then read protocol/Banka.md in full and follow its instructions
exactly, starting with the "TO THE AI AGENT READING THIS" banner. Apply it to
this project.
```

## Updating Banka

Use this for a project Banka already manages. It updates the machine-level
Skills Kit and assesses project state separately; it does not re-adopt or
silently restructure the project. The canonical safety and verification rules
live in [the protocol's update procedure](protocol/Banka.md#updating-an-existing-banka-managed-project).

Paste this into a fresh session working in the managed project's directory:

```
Update this existing Banka-managed project to the newest stable Banka release.

Clone https://github.com/partikularwaters/Banka.git to a safe location, fetch
tags, and check out the newest annotated stable vMAJOR.MINOR.PATCH tag by
semantic-version order. Verify that the tag is annotated and its commit's
VERSION matches the tag, and do not use newer unreleased commits from the
default branch. If no valid stable tag exists, stop instead of falling back to
the default branch. Read that release's VERSION, CHANGELOG.md, and the complete
"Updating an existing Banka-managed project" procedure in protocol/Banka.md.
Treat this as an update, not adoption, tier promotion, or implicit migration.

Before changing anything, inspect this project's AGENTS.md, complete CLAUDE.md,
/core/, /context/, required tier files, and the installed Banka skills for the
runtime or intentionally shared runtimes I use. Classify each installed skill
as a standard copy, a symlink to a
primary runtime installation, a legacy source-checkout symlink, customized or
conflicting, a duplicate project-local entry, or missing. Resolve every
symlink before acting. A standard shared-runtime link may point only to a
verified real Banka skill directory, never another symlink, a temporary
checkout, or a development clone. Preview conversion of a legacy
source-checkout symlink to a real primary copy, but leave it untouched if I
decline. If the
project's current Banka release cannot be established from durable evidence,
label the baseline unknown and compare its actual contents to the target
release instead of guessing.

First report the target release, compatibility and workflow impact, state-schema
impact, skill differences, required project-state changes, and an exact
file-by-file preview that names everything left untouched. Preserve the tier,
project-specific state and history, content outside the marked Banka block, and
customized skills. Do not replace skills, mutate project state, change tiers,
or migrate legacy authority until I explicitly confirm the preview. After
confirmation, apply only the approved changes and run the protocol's full
verification and Cold Agent Test. Refresh each independent primary copy once,
compare it exactly with the tagged skills-kit/, and verify every linked runtime
afterward instead of copying over its links.
```

## The build loop

```
charter → plan, wait for approval (reads IDEA-SCOPE.md too)
   |
delegate → optional: split approved work into Junior-safe, Senior-required,
   and Owner-required items
   |
[build]
   |
survey → check plan-alignment, system integrity, prod-readiness
   |    ├─→ dredge     if something is actually broken
   |    └─→ watershed  if it's a genuine multi-angle judgment call
   |
moor → capture what's worth remembering (registry/invariant captures wait
   |    for survey to pass first)
   |
remember save → close the session
```

`charter → delegate`, `survey → moor`, and `remember save → restore` are
enforced orderings — `delegate` refuses to run without an approved `charter`
plan, `moor`'s registry and invariant/token captures require survey to have
passed first (see `moor`'s own file for the general-outcome and audit-mode
exceptions), and every session ends with save, starts with restore.

Use `/skill-name` in Claude Code and `$skill-name` in Codex. The loop repeats
every session; the remember skill in restore mode opens the next one. The scale
skill runs orthogonally whenever a project outgrows its current tier.

### Operational perspectives

[Protocol §7.1](protocol/Banka.md#section-71-operational-perspectives) defines
an operational perspective as a temporary accountability frame embedded inside
an existing Banka skill. The canonical perspectives are Outcome Owner, User,
Builder, Maintainer, and Risk Owner. Perspectives are not personas, commands,
lifecycle gates, generated project files, or persistent project roles. A skill
applies only the perspectives relevant to its existing purpose and still emits
its normal output. gstack informed selected review habits but is not a Banka
dependency, replacement workflow, or Craft Layer module (see Influences and
attribution below).

Delegated tickets run serially when sessions share one checkout. Parallel work
requires a separate Git worktree and branch per ticket because a fresh session
isolates conversation history, not files. Local and hosted models can both
execute Banka tickets when their host can read project state, edit the assigned
checkout/worktree, and run verification; Banka does not launch or orchestrate
models itself.

## What gets written, and where

This is what Banka generates *inside a project you build* — not this repo's own layout (see below).

| Artifact | Path | Written by |
| --- | --- | --- |
| `IDEA-SCOPE.md` | project root | Section 1.5 — permanent record of original scope, never edited afterward |
| `AGENTS.md` | project root | Sections 3/4/5 — the canonical, runtime-neutral Banka source of truth. Its one marked schema-2 block declares the tier and routes to any tier files. |
| `CLAUDE.md` | project root | Claude Code compatibility import only: exactly `@AGENTS.md` plus a newline. It contains no separate project state. |
| Core files (`overview.md`, `architecture.md`, `design.md`, `progress.md`) | `/core/` | Core-tier generation; restructured by `scale` on promotion |
| Standard files (nine files) | `/context/` | Standard-tier generation; restructured by `scale` on promotion |
| `delegation-queue.md` | project root (Minimal/Core) or `/context/` (Standard) | `delegate` |
| UI patterns | `ui-registry.md` (Standard) / `core/design.md` (Core) / inline (Minimal) | `moor` |
| Session state | `progress.md`, `progress-tracker.md`, or the marked `AGENTS.md` block's Session Notes | `moor`, `remember` |

### Current state and migration

For technical readers, `AGENTS.md` is the source of truth in every active
schema-2 Banka project. Its marked block contains `BANKA:START`,
`BANKA:STATE-SCHEMA: 2`, the declared tier, and `BANKA:END`. Minimal keeps live
state in that block; Core routes to `/core/`; Standard routes to `/context/`.
Claude Code follows the exact one-line `CLAUDE.md` import to the same state.

Older CLAUDE-first Banka projects remain readable for compatible read-only
work. Banka never silently converts them. Migration requires an explicit
request, a preview of the file-by-file result, confirmation, and a final check
that one matching schema-2 structure remains. The complete detection matrix
and migration sequence are in [protocol/Banka.md](protocol/Banka.md#section-3-runtime-authority-and-minimal-state).

## This repo's own structure

```
Banka/
├── protocol/Banka.md              # the core handoff protocol
├── VERSION                        # Banka package release version
├── CHANGELOG.md                   # retrospective milestones and release notes
├── scripts/check-repo-integrity.sh # repository-local packaging smoke check
├── scripts/check-cold-downstream.sh # simulates a cold install, catches downstream-unreachable references
├── system-map.md                  # one-doc orientation, start here
├── skills-kit/                    # the nine Skills — install once, use everywhere
│   └── {charter,survey,dredge,remember,moor,scale,delegate,watershed,linis}/SKILL.md
└── full-context-templates/
    ├── project-entry/             # canonical AGENTS.md tier blocks and Claude shim
    ├── core/                      # the four Core-tier files
    ├── standard/                  # the nine Standard-tier files
    └── delegation-queue.md        # tier-agnostic, used by delegate
```

## Influences and attribution

Banka's original five-skill shape and Standard tier's nine-file layer were inspired by [JavaScript Mastery](https://github.com/jsmastery-pro/skills)'s earlier agent-skills workflow and [context template](https://github.com/jsmastery-pro/context-driven-dev) — both evolve independently now, and Banka doesn't mirror their current form. [gstack](https://github.com/garrytan/gstack) informed the operational-perspective discipline; an influence, not a dependency.

## Optional: Craft Layer modules

Banka stays agnostic about stack and framework, but defers to genuinely strong outside authorities for specific craft domains once a project opts in — e.g. [emilkowalski/skills](https://github.com/emilkowalski/skills) for animation and interaction feel. See Section 7.6 (module standard) and Section 7.7 (reference instance) in the protocol doc.

## Learn more

- [system-map.md](system-map.md) — the full connective picture of how Banka works.
- [BANKA-ADOPTION-GUIDE.md](BANKA-ADOPTION-GUIDE.md) — how new and existing projects enter Banka, including adoption conditions and preparation paths.
- [protocol/Banka.md](protocol/Banka.md) — the authoritative rules: adoption workflow, the complexity rubric, the Layer Principle, all three tiers' exact output, the Skills Kit, and Craft Layer modules.
- [CHANGELOG.md](CHANGELOG.md) — release metadata and version history.
- [CONTRIBUTING.md](CONTRIBUTING.md) — contribution guidance, including Banka's transparent AI-assistance commit convention.

## License

MIT — see [LICENSE](LICENSE).
