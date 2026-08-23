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

**Release:** Banka 1.1.0. This release version identifies the Banka package;
the separate state schema identifies the on-disk project format. Banka 1.1.0
uses state schema 2. See [VERSION](VERSION) and [CHANGELOG.md](CHANGELOG.md).

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
| `delegate` | Splits an approved plan into Junior-safe tickets for fresh-session execution and keeps judgment-heavy work Senior-required. Model choice remains explicit and user-controlled. |
| `dredge` | Diagnoses a build failure before responding to it — targeted fix, hard reset, or genuine rethink are different problems. |
| `moor` | Captures a UI pattern or engineering outcome once it's settled, so the next session builds on it instead of drifting. |
| `remember` | Saves session state on close, restores it on open — always checking disk/git reality first, never trusting this conversation's own memory. |
| `scale` | Promotes a project exactly one tier at a time, Minimal → Core → Standard, only when a real threshold is met. |
| `survey` | Checks a build against what was planned, the project's own declared rules, and production-readiness — then routes real findings to the right next skill. |
| `watershed` | Runs a genuinely contested or high-stakes call through five independent perspectives, then consolidates one recommendation. |
| `linis` | Cleans narrative residue from settled files while preserving operational history, provenance, compatibility facts, and load-bearing rationale. Never runs against active work. |

Each skill's full behavior lives in its own `SKILL.md` under [skills-kit/](skills-kit/) — the table above is the quick-reference, not the source of truth.

## Installing the Skills Kit

`skills-kit/` is the canonical source for all nine skills. Choose the discovery
path for the runtime you use.

### Claude Code

Paste this into a fresh Claude Code session — no pre-cloning needed, the agent
does it:

```
Clone https://github.com/partikularwaters/Banka.git to a temporary directory,
then install its Skills Kit: copy each skills-kit/*/SKILL.md into
~/.claude/skills/<skill-name>/SKILL.md as-is. Before installing, check
~/.claude/commands/, ~/.claude/skills/, and, if this is a specific project,
its own .claude/commands/ and .claude/skills/, for any existing file using
one of these nine names: charter, delegate, dredge, linis, moor, remember,
scale, survey, watershed. If you find one, don't delete it unilaterally —
back it up and ask me how to reconcile it before installing over it.
```

Invoke skills with `/skill-name`, for example `/charter` or `/remember restore`.

Full install details and rationale: [protocol/Banka.md](protocol/Banka.md), Section 7.

### Codex

Paste this into a fresh Codex session — no pre-cloning needed, the agent does
it:

```
Clone https://github.com/partikularwaters/Banka.git to a temporary directory,
then install its Skills Kit for the current user: link (or, if the checkout
doesn't preserve symlinks, copy) each of these nine skills-kit/<skill>
directories into ~/.agents/skills/<skill>/: charter, delegate, dredge, linis,
moor, remember, scale, survey, watershed. Before installing, check
~/.agents/skills/ and the projects I use for an existing Banka skill with the
same name — Codex can show duplicate same-named skills and does not merge
them, so migrate or remove an old project-local copy only after confirming
it isn't customized. Confirm every installed entry contains a readable
SKILL.md.
```

Invoke skills with `$skill-name`, for example `$charter` or `$remember restore`.

Run `scripts/check-repo-integrity.sh` from the cloned checkout to verify all
nine canonical `SKILL.md` files and names, confirm repository-local Banka
duplicates have not been reintroduced, check the generated Banka block
markers, and scan for known obsolete terminology.

The Banka source repository is not itself a Banka-enabled application project:
it intentionally has no project-state `AGENTS.md`, `CLAUDE.md`, `/core/`, or
`/context/`.
Read-only skills can inspect an explicitly supplied subject and these repository
docs; state-writing skills stop rather than treating the repository as Minimal.

## The build loop

```
charter → plan, wait for approval (reads IDEA-SCOPE.md too)
   |
delegate → optional: split approved work into Junior-safe tickets
   |
[build]
   |
moor → capture what's worth remembering
   |
survey → check plan-alignment, system integrity, prod-readiness
   |    ├─→ dredge     if something is actually broken
   |    └─→ watershed  if it's a genuine multi-angle judgment call
   |
remember save → close the session
```

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
its normal output. gstack informed selected review habits, but is not a Banka
dependency, replacement workflow, or Craft Layer module; see
[garrytan/gstack](https://github.com/garrytan/gstack) for the canonical source,
without copying its instructions or command catalog.

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

Banka's original five-skill foundation was inspired by [JavaScript Mastery / Adrian Hajdin's earlier agent-skills workflow](https://github.com/jsmastery-pro/skills), whose five commands were `architect`, `remember`, `review`, `recover`, and `imprint`. Banka's Standard-tier nine-file context layer was inspired by [JavaScript Master's nine-file context template](https://github.com/jsmastery-pro/context-driven-dev). The current JavaScript Mastery skills repository has evolved into a broader workflow, and both upstream projects evolve independently from Banka; Banka does not mirror their current commands or contracts. gstack informed the newer operational-perspective review discipline; [garrytan/gstack](https://github.com/garrytan/gstack) remains an influence, not a dependency or replacement workflow.

## Optional: Craft Layer modules

Banka stays agnostic about stack and framework, but defers to genuinely strong outside authorities for specific craft domains once a project opts in — e.g. [emilkowalski/skills](https://github.com/emilkowalski/skills) for animation and interaction feel. See Section 7.6 (module standard) and Section 7.7 (reference instance) in the protocol doc.

## Learn more

- [system-map.md](system-map.md) — the full connective picture of how Banka works.
- [BANKA-ADOPTION-GUIDE.md](BANKA-ADOPTION-GUIDE.md) — how new and existing projects enter Banka, including adoption conditions and preparation paths.
- [protocol/Banka.md](protocol/Banka.md) — the authoritative rules: adoption workflow, the complexity rubric, the Layer Principle, all three tiers' exact output, the Skills Kit, and Craft Layer modules.
- [CHANGELOG.md](CHANGELOG.md) — Banka 1.0.0 release metadata and earlier milestones.
- [CONTRIBUTING.md](CONTRIBUTING.md) — contribution guidance, including Banka's transparent AI-assistance commit convention.

## License

MIT — see [LICENSE](LICENSE).
