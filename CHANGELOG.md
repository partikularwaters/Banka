# Changelog

## 2.0.0 — 2026-08-30

**Compatibility impact:** Major. The Skills Kit install, project-adoption,
and new update prompts now pin to the newest annotated stable release tag
instead of an unrestricted default-branch clone, and stop rather than fall
back when no valid tag exists — an incompatible change to Banka's existing
onboarding contract, not an additive one.
**Required consumer action:** none for already-adopted projects — nothing
about their state, skills, or workflow changes unless they explicitly run the
new update procedure. Anyone installing, adopting, or updating via the README
prompts must wait until the `v2.0.0` annotated tag exists on `origin`;
pushing it is a separate, explicitly owner-authorized step after this release
commit lands.
**Project-state migration:** none. No generated template, tier shape, or
schema-2 marker changes.
**State-schema impact:** none — state schema stays 2. The incompatible
change is in skill/workflow behavior, not in stored project authority.

- Adds an "Updating an existing Banka-managed project" procedure to protocol
  §7: independently assesses the machine-level Skills Kit and managed
  project state, pins to an annotated stable release tag, previews every
  change, and requires explicit confirmation before touching anything.
- New README "Updating Banka" pasteable prompt; "Getting started" now routes
  already-adopted projects there instead of re-running adoption.
- The Skills Kit install and project-adoption prompts (Claude Code and
  Codex) now resolve to the newest annotated stable `vMAJOR.MINOR.PATCH` tag
  rather than an unrestricted default-branch clone, and stop instead of
  falling back when no valid tag exists.
- Fixes the Codex install prompt's temporary-directory symlink risk: a
  symlink must target a persistent checkout; a temporary checkout must be
  copied, never linked.
- `check-repo-integrity.sh` gains matching mechanical checks: the update
  prompt exists and points at the canonical protocol section, all four
  install/adopt/update prompts carry the stable-tag and
  no-unreleased-`main` language, and an installed Codex skill may be a
  verified copy as well as a symlink.
- `dredge` gains Mode 0 (cannot reproduce): a three-check reproduction
  diagnosis that runs before any of the other three failure modes apply,
  ending in re-classification or an `[OPEN — needs verification]` flag.
- `moor`'s registry and invariant/token captures now require `survey` to
  have passed this build first (cleanly, or with findings resolved or
  explicitly accepted as intentional) — general outcome/decision captures
  and audit mode are unaffected.
- Documentation currency pass across README, system-map, and the protocol:
  corrects the build-loop order to survey → moor throughout (a leftover
  instance still described moor → survey), adds "Getting started" and
  "Adopting a project" sections, and consolidates attribution to one place
  (README) instead of restating it in the protocol.
- Beginning with this release, every new changelog entry states
  compatibility impact, required consumer action, project-state migration,
  and state-schema impact as four separate judgments.

## 1.3.0 — 2026-08-26

Adds a third delegation tier and brings the public-facing docs and protocol
§7.5 into line with it.

- `delegate` now recognizes Owner-required alongside Junior-safe and
  Senior-required — work needing the owner's own credentials/account access,
  an owner-only decision, or an action category no AI session should perform
  regardless of capability. Senior-required tickets get a full contract
  instead of a one-line reason; Owner-required gets a lighter contract and a
  plain checklist instead of a session handoff.
- Every ticket template gains a structured `Depends on` field, enabling a
  unified Execution Sequence table ordering all three tiers by dependency.
- The Junior-safe handoff block is trimmed to its genuine defense-in-depth
  fields; Senior-required execution mode (current session or fresh-session
  handoff) is now a per-ticket question asked at hand-off time, not a fixed
  assumption, reusing the same handoff template rather than duplicating it.
- Fixes protocol §7.5's scripted setup prompt, which previously asserted
  Senior-required work always stays in a senior-capability session — no
  longer true once the handoff choice exists. Aligns README's skill table
  and build-loop diagram, system-map's build-loop diagram, and its Framework
  Change-Impact Map to the three-tier model.

## 1.2.0 — 2026-08-24

Adds session-state bloat prevention and correction, driven by field
feedback from a Standard-tier project whose `progress-tracker.md` grew to
320KB/869 lines over six weeks.

- Adds Protocol §2.9: a two-track mechanism — write-time prevention
  (promotion, supersession, write-shape, and thread-tagging checks) and
  threshold-triggered correction (per-thread settledness evaluation,
  sequential overflow-file splitting, a Decisions-section ceiling).
  Thresholds are provisional starting values per Fill-In Discipline Rule 4.
- Adds an `overflow/` folder convention (Standard: `context/overflow/`;
  Core: `core/overflow/`) and an Overflow Index, both created lazily —
  never pre-declared in a new project's generated files.
- Extends `remember` (full mechanism) and `moor` (promotion and write-shape
  only) to operationalize §2.9; extends `charter`'s Outcome Owner check to
  catch a plan bundling unrelated threads before it reaches `delegate`;
  adds a disambiguation note to `scale` distinguishing its tier-level
  promotion from §2.9's within-tier promotion check.
- Fixes a self-containment gap found via real-world testing: the initial
  downstream-facing rules referenced `protocol/Banka.md`, which never
  travels with a Banka-managed project. The compact operational rules now
  live in each tier's own session-state template, and `remember`/`moor`
  read from there directly rather than citing an unreachable document.
- A follow-up review found that fix itself incomplete (missing
  overflow-file mechanics in the templates, an unresolvable self-heal
  instruction, and a write-authority conflict in `moor`) — all three
  closed, and `scripts/check-cold-downstream.sh` added to simulate an
  actual cold install (installed skills plus rendered tier output only,
  nothing else from this repo) so this class of bug is caught mechanically
  going forward.
- Adds a Framework Change-Impact Map to `system-map.md`.

## 1.1.0 — 2026-08-23

Makes disciplines the framework already practiced explicit, informed by
principles identified in an audit of ICM (github.com/RinDig/icm-architect).
No tier, skill, required project file, or runtime dependency was added; this
release reinforces the existing architecture rather than extending it.

- Adds a Context Contract standard (protocol Section 2.7) and a matching
  Context Contract section — Required, Conditional, Excluded by default,
  Outputs, Write authority — to every skill in the Skills Kit.
- States the One Home per Fact authority principle explicitly (Section 2.8),
  citing the repository's existing byte-identical integrity checks as the
  mechanism that already enforces it.
- Names the Cold Agent Test as a cross-referenced review lens (Section 3.1),
  wired as an explicit completion condition into the migration sequence
  (Section 3.2) and the promotion path (Section 6).
- Adds a Framework Change-Impact Map to `system-map.md` — a maintenance-only
  dependency table for editing Banka itself.
- Adds a structural integrity check requiring exactly one Context Contract
  section per skill.

## 1.0.0 — 2026-08-21

Formal Banka 1.0.0 release metadata. This is a repository milestone recorded
retrospectively; it does not assert that a Git tag was created or that a
package was published.

- Establishes Banka 1.0.0 as the package release version.
- Establishes schema 2 as the current on-disk Banka project-state format:
  `AGENTS.md` contains the canonical marked block, while `CLAUDE.md` is the
  exact one-line Claude Code import.
- Records deterministic compatibility reading and explicit, previewed,
  confirmed migration for older CLAUDE-first Banka projects.
- Brings the protocol, project-entry templates, skills, delegation handoff,
  and public documentation into the same AGENTS-first contract.

`1.0.0` is Banka's release version. `2` is the state-schema version used inside
Banka-managed projects; the values identify different things and do not imply
matching release or publication history.

## Retrospective milestones before 1.0.0

The following classifications summarize repository history without assigning
release numbers, tags, or publication dates.

- **Foundation:** established the tiered Banka protocol and reusable skills.
- **Runtime-neutral operation:** made the skills available through supported
  runtime discovery paths while retaining one canonical skills source.
- **Adoption and readiness:** clarified decision-ready scope, brownfield
  readiness, and the independent roles of ASMP and Banka Docking.
- **Operational perspectives:** added temporary Outcome Owner, User, Builder,
  Maintainer, and Risk Owner review frames within existing skills.
- **Schema-2 reliability migration:** made project state structurally
  unambiguous through canonical `AGENTS.md` state, tier markers, a thin Claude
  Code import, deterministic detection, and confirmed migration.

Companion protocols are independently versioned and remain pre-1.0 according
to their own repositories. This changelog does not change or make compatibility
claims for them.
