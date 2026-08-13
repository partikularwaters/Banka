# Banka

A protocol and skills kit for scoping, generating, and building coding-agent
projects at the right tier of complexity — agnostic about stack, opinionated
about quality, and currently workable in Claude Code and Codex.

Banka gives a project two things most AI-assisted builds skip: a scoping step that decides how much structure a project actually needs *before* any files get generated, and a permanent, reusable set of Skills that carry a project through its whole build loop afterward — planning, delegation, review, recovery, and session handoff.

## Why "Banka" 🛶

*Banka* — shortened from *bangka*, Tagalog for the traditional Philippine outrigger boat — is simple, stable, and built to be steered deliberately rather than left to drift. That's the role this framework plays: it doesn't build the project for you, it keeps it pointed at a chosen destination through every session in between. Scoping sets the heading. The Skills Kit — `charter`, `survey`, `dredge`, `moor`, and the rest — is the crew that keeps the vessel on course, correcting drift instead of letting each session start over from nowhere. The destination is never abstract: a haven, the harbor a project was actually scoped to reach, not just wherever momentum happens to leave it.

```
external scope (optional)
        |
        v
scoping intake  ──►  tier resolved: Minimal / Core / Standard
        |
        v
tier generation  ──►  a real project now exists on disk
        |
        v
the build loop (skills-kit/, repeats every session)
        |
        v
promotion, if the project outgrows its tier
```

This is the compressed version. For the full picture — one diagram, one paragraph per stage, every arrow explained — read [system-map.md](system-map.md) first. [protocol/Banka.md](protocol/Banka.md) is the authoritative source underneath both; if anything here or in the system map looks wrong, the protocol doc wins.

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

Ask Claude Code to install the kit:

```
Install the Banka Skills Kit from <path-to-clone>/skills-kit/ into
~/.claude/skills/ — one folder per skill, copying each SKILL.md as-is.
```

1. Clone this repo: `git clone https://github.com/partikularwaters/Banka.git`
2. Open a Claude Code session and paste the instruction above with the real clone path.
3. Invoke skills with `/skill-name`, for example `/charter` or `/remember restore`.

**Before installing:** check `~/.claude/commands/` and `~/.claude/skills/` (personal, machine-wide) and, if you're in a specific project, its own `.claude/commands/` and `.claude/skills/` too, for any existing file with the same name as one of this package's nine skills. If you find one, don't delete it unilaterally — back it up and confirm with the user how they want to reconcile it before installing over it.

Full install details and rationale: [protocol/Banka.md](protocol/Banka.md), Section 7.

### Codex

This repository exposes the same nine `skills-kit/` directories to Codex through
project-local `.agents/skills/` symlinks. They are links, not copies: edit the
source in `skills-kit/` only. Invoke skills with `$skill-name`, for example
`$charter` or `$remember restore`.

For another project, link each Banka skill directory into that project's
`.agents/skills/`, or into `~/.agents/skills/` for one user's machine-wide
installation. Check for an existing skill with the same name before creating a
link: Codex does not merge duplicate skill names.

If an archive or checkout does not preserve symlinks, copy each complete skill
directory instead. Confirm every entry contains a readable `SKILL.md`; the
directory under `skills-kit/` remains authoritative.

Run `scripts/check-repo-integrity.sh` from this repository to verify all nine
links, their `SKILL.md` files and names, the generated Banka block markers, and
known obsolete terminology.

The Banka source repository is not itself a Banka-enabled application project:
it intentionally has no project-state `CLAUDE.md`, `/core/`, or `/context/`.
Read-only skills can inspect an explicitly supplied subject and these repository
docs; state-writing skills stop rather than treating the repository as Minimal.

## Where to start

Banka's scoping step (Protocol §1.5) resolves into one of three states — which one applies decides how you open the first session:

- **Nothing scoped yet.** Open a fresh chat, hand it [protocol/Banka.md](protocol/Banka.md), and start describing the idea. Section 1.5's built-in fallback pass (State 3) scopes it for you before any tier gets chosen.
- **You already have a scope document** — from any process, any shape, any filename, as long as it states a purpose, users, a feature scope, constraints, and a definition of done. Hand it along with the protocol doc. Section 1.5 reads it directly (State 1 if its own rubric was already run, State 2 if not) instead of re-asking what's already answered.
- **A Banka project already exists on disk.** Skip the protocol doc and open the project in the supported runtime. Restore with `/remember restore` in Claude Code or `$remember restore` in Codex.

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
| `CLAUDE.md` | project root | Sections 3/4/5, sized to tier — the current Banka source of truth and the first file every skill reads |
| `AGENTS.md` | project root | Sections 3/4/5 — minimal Codex entry shim that points to the current `CLAUDE.md` state; it is not a second source of truth |
| Core files (`overview.md`, `architecture.md`, `design.md`, `progress.md`) | `/core/` | Core-tier generation; restructured by `scale` on promotion |
| Standard files (nine files) | `/context/` | Standard-tier generation; restructured by `scale` on promotion |
| `delegation-queue.md` | project root (Minimal/Core) or `/context/` (Standard) | `delegate` |
| UI patterns | `ui-registry.md` (Standard) / `core/design.md` (Core) / inline (Minimal) | `moor` |
| Session state | `progress.md`, `progress-tracker.md`, or `CLAUDE.md`'s Session Notes | `moor`, `remember` |

## This repo's own structure

```
Banka/
├── .agents/skills/                # Codex discovery links to the nine canonical skills
├── protocol/Banka.md              # the core handoff protocol
├── scripts/check-repo-integrity.sh # repository-local packaging smoke check
├── system-map.md                  # one-doc orientation, start here
├── skills-kit/                    # the nine Skills — install once, use everywhere
│   └── {charter,survey,dredge,remember,moor,scale,delegate,watershed,linis}/SKILL.md
└── full-context-templates/
    ├── core/                      # the four Core-tier files
    ├── standard/                  # the nine Standard-tier files
    └── delegation-queue.md        # tier-agnostic, used by delegate
```

## Optional: Craft Layer modules

Banka stays agnostic about stack and framework, but defers to genuinely strong outside authorities for specific craft domains once a project opts in — e.g. [emilkowalski/skills](https://github.com/emilkowalski/skills) for animation and interaction feel. See Section 7.6 (module standard) and Section 7.7 (reference instance) in the protocol doc.

## Learn more

- [system-map.md](system-map.md) — full connective picture, one diagram plus one paragraph per stage.
- [protocol/Banka.md](protocol/Banka.md) — the authoritative rules: the rubric, the Layer Principle, all three tiers' exact output, the Skills Kit, and Craft Layer modules.

## License

MIT — see [LICENSE](LICENSE).
