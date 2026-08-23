# Changelog

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
