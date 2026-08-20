<!--
Non-Banka execution handoff. This repository intentionally has no Banka project
state, so this file is not a delegation-queue.md and must not be interpreted as
one. It is a ready-to-paste task brief for a fresh senior-capability session.
-->

# Banka Agent-Runtime Authority Migration — Fresh-Session Handoff

**Prepared:** 2026-08-20
**Repository:** `/Users/madridj1689/Code/projects/Banka`
**Required capability:** Senior-capability session
**Status:** Direction settled; implementation plan still requires Charter approval

## Ready-to-paste opening message

> Work in `/Users/madridj1689/Code/projects/Banka`. This is the Banka source
> repository, which is intentionally not itself a Banka-managed project. The
> Banka–gstack integration should be treated as the accepted baseline whether
> it has already been committed or is still present as known dirty work; dirty
> files alone are not evidence of concurrency. I confirm the previous editing
> sessions have ended and this session owns the shared checkout unless I state
> otherwise. Stop for changed paths that the handoff or current Git history
> cannot explain.
>
> Read `banka-agent-runtime-authority-handoff.md` completely. Then invoke
> `$charter` on the two settled changes described there. Do not implement until
> you present the plan and I explicitly approve it. After approval, invoke
> `$delegate` if the plan contains genuinely Junior-safe mechanical tickets;
> keep all cross-cutting authority and compatibility decisions Senior-required.
> Implement the Senior-required work in this session. When implementation and
> any delegated tickets are complete, invoke `$survey` against the approved
> plan and the repository's authoritative documentation.

## Settled direction

### 1. Delegate must return the handoff messages

When the Delegate skill successfully writes a delegation queue, its response
must include a ready-to-paste fresh-session handoff message for every
Junior-safe ticket. Do not merely point the user to sample prompts elsewhere.

Each handoff message must carry enough information to start safely without this
conversation's memory, including:

- the exact queue path and ticket number;
- the required capability and dependency state;
- the files in and out of scope;
- the required verification and done conditions;
- whether the ticket inherits an accepted dirty baseline;
- the coordinator's ownership handoff when sessions share one checkout;
- the rule that dirty files, one worktree, index-lock absence, and process
  inspection do not prove or disprove concurrent editing;
- the instruction to stop only for unexplained drift, missing authority, an
  unmet dependency, or a material ambiguity the ticket does not resolve.

Update the canonical Delegate skill and its canonical queue template together
so their contracts do not diverge. Preserve serial execution as the default in
a shared checkout and separate worktrees plus branches as the requirement for
parallel execution.

### 2. AGENTS.md becomes the runtime-neutral authority entry

Reverse the current runtime-specific authority relationship:

- `AGENTS.md` is the canonical, runtime-neutral project entry and instruction
  source.
- For Minimal projects, canonical Banka project state lives in `AGENTS.md`.
- For Core and Standard projects, `AGENTS.md` is the canonical router into
  `/core/` or `/context/`; the files in those directories remain the detailed
  domain state.
- `CLAUDE.md` becomes a thin Claude Code compatibility shim that imports or
  points to `AGENTS.md` without duplicating Banka state.
- Add similarly thin runtime shims only for runtimes that do not prioritize
  `AGENTS.md`.
- There must be one authority chain, not synchronized duplicate sources.

This is a versioned compatibility migration, not a filename swap. The plan must
inventory and consistently update every affected contract, including:

- protocol tier generation and generated blocks;
- Minimal, Core, and Standard structure descriptions;
- every skill's tier detection and state-resolution rules;
- `scale` promotion behavior;
- Delegate queue resolution;
- templates and runtime shims;
- README, system map, adoption/install guidance, and examples;
- integrity checks and obsolete-authority terminology detection;
- migration behavior for existing projects that currently have `CLAUDE.md` as
  authority, including deterministic handling when both files exist.

Do not modify ASMP or Docking merely to make Banka's internal migration easier.
If an external compatibility change is genuinely required, report it as a
separate proposal rather than silently expanding scope.

## Required planning decisions

Charter must resolve these before implementation:

1. The exact generated contents of `AGENTS.md` and the Claude Code shim at each
   Banka tier.
2. The deterministic authority rule for legacy projects with only
   `CLAUDE.md`, new projects with only `AGENTS.md`, and transitional projects
   containing both.
3. Whether migration is automatic, explicit, or compatibility-read-only until
   the user invokes a migration path.
4. Whether a Banka version marker is needed to prevent ambiguous detection.
5. Which mechanical documentation or test updates are Junior-safe after the
   senior authority contract is settled.
6. The exact Delegate response format for one ticket and for multiple tickets.

Do not leave these choices for delegated sessions to infer.

## Recommended Banka skill sequence

1. **`$charter` — required.** Produce the authority-migration blueprint and
   wait for explicit approval before editing.
2. **`$delegate` — conditional after approval.** Split only mechanical,
   independently verifiable work. The authority contract, legacy behavior, and
   cross-cutting skill/runtime changes remain Senior-required.
3. **Implementation.** Execute Senior-required items serially in this checkout;
   run delegated tickets serially unless the user explicitly supplies separate
   worktrees and branches.
4. **`$survey` — required.** Review plan alignment, authority consistency,
   compatibility, generated structures, and repository checks. Survey reports;
   it does not silently fix findings.
5. **`$dredge` — only if behavior or integrity checks are actually broken.**
6. **`$watershed` — only if a consequential authority or migration choice
   remains genuinely contested after Charter.**
7. **`$linis` — optional after acceptance.** Use only after the migration is
   settled to remove obsolete narrative residue without erasing provenance or
   compatibility history.

Do not invoke `$remember`, `$moor`, or `$scale` for repository session state:
this source repository is intentionally non-Banka-managed.

## Verification expectations

At minimum, the completed work must demonstrate:

- every repository integrity check passes;
- `git diff --check` passes;
- generated Minimal, Core, and Standard examples form one unambiguous authority
  chain;
- Claude Code's shim reaches the canonical `AGENTS.md` instructions without
  duplicating them;
- all skills resolve the same tier and authority source;
- existing projects receive documented, deterministic compatibility behavior;
- Delegate writes the queue and returns a usable handoff message for each
  Junior-safe ticket;
- accepted dirty state is not misclassified as concurrent work;
- ASMP and Docking remain unchanged unless separately authorized;
- no new Banka command, lifecycle gate, or persistent agent persona is created.

## Completion response

Report:

- the approved decisions and migration behavior;
- files changed;
- Senior-required work performed;
- Junior-safe tickets produced and their ready-to-paste handoff messages;
- verification commands and results;
- Survey findings and any remaining compatibility risks.
