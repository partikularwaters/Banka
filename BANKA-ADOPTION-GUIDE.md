# Banka Adoption Guide

Use this guide when bringing a project under Banka management.

Banka may be entered from a new project or an existing project. Before adoption,
determine whether the project already has decision-ready scope and, for an
existing project, whether readiness evidence already exists for Banka.

Banka knows its companion protocols but does not reproduce their rules. When a
companion protocol is needed, apply its current canonical version to the project
and consume its output before continuing Banka adoption.

## Entry flow

```
Start Banka adoption
        |
        v
Is decision-ready scope present?
   |           |
  no          yes
   |           |
   v           |
Clarify        |
scope          |
   |           |
   +-----------+
        |
        v
Is this an existing
or brownfield project?
   |               |
  no              yes
   |               |
   v               v
Banka          Is current readiness
adoption       already established?
                   |           |
                  no          yes
                   |           |
                   v           |
             Banka Docking     |
                   |           |
            Ready for Banka    |
                   |           |
                   +-----------+
                         |
                         v
                   Banka adoption
                         |
                         v
                   Banka operation

A brownfield project may reveal inadequate scope during Docking.
If that happens:

Docking
   |
   v
Scope inadequate
   |
   v
Scope clarification
   |
   v
Docking resumes
   |
   v
Ready for Banka
   |
   v
Banka adoption

## 1. Establish decision-ready scope

Banka needs enough reliable scope — decision-ready scope — to understand the
intended outcome, constraints, boundaries, and relevant decisions.

If decision-ready scope is present, continue.

If scope is materially unclear, pause Banka adoption and clarify it before
continuing.

[Adaptive Scope Mapping Protocol (ASMP)](https://github.com/partikularwaters/adaptive-scope-mapping-protocol)
is one available route for turning unclear intent into decision-ready scope.
ASMP is not required when another valid scope source already exists.

Banka consumes decision-ready scope; it does not require a particular scope
filename or scoping method.

## 2. Establish readiness evidence for existing projects

For a new project with decision-ready scope, continue to Banka adoption.

For an existing or brownfield project, determine whether current evidence
already establishes readiness for Banka.

[Banka Docking Protocol](https://github.com/partikularwaters/banka-docking-protocol)
is Banka's canonical preparation protocol for existing-project adoption.

When Docking is required, apply its current canonical protocol against the
existing project. Docking establishes project reality, identifies only the
readiness work required before handoff, and records its result in
`ADOPTION-ASSESSMENT.md`.

Do not duplicate Docking's assessment rules or readiness workflow in Banka.

If Docking determines that scope is inadequate, complete scope clarification
first and then return to Docking. Do not bypass the remaining Docking workflow
by proceeding directly from scope clarification to Banka.

Resume Banka adoption only when Docking establishes `Ready for Banka` and the
owner chooses to continue.

`Ready for Banka` means Banka may begin adoption. It does not mean adoption is
already complete.

## 3. Adopt the project into Banka

Once required scope and readiness are sufficient, Banka takes responsibility
for establishing the project's managed structure.

Banka should:

1. consume the available scope and, when applicable, Docking handoff;
2. inspect existing Banka state before creating or replacing anything;
3. choose the smallest Banka tier appropriate to the project's actual needs;
4. establish the required `AGENTS.md` source-of-truth and session-state
   structure for the selected tier;
5. make applicable Banka skills discoverable and, where Claude Code is used,
   add its exact one-line `CLAUDE.md` import to `AGENTS.md`;
6. preserve relevant existing project knowledge instead of duplicating or
   silently replacing it;
7. record current state, decisions, risks, owner dependencies, and next work in
   the appropriate Banka-managed locations; and
8. verify that a new session can recover enough durable state to continue
   safely.

Use the current Banka protocol and tier definitions rather than copying their
rules into this guide.

## 4. Existing Banka state

An existing project may already contain Banka files, tier claims, skills,
instructions, or session state.

Treat these as evidence of prior Banka use, not automatic proof that the current
project still conforms to the current Banka protocol.

Inspect and preserve valid existing state. Reconcile obsolete or conflicting
state deliberately. Do not destroy historical project knowledge merely to make
the repository resemble a fresh Banka installation.

For an active schema-2 project, the marked block in root `AGENTS.md` is the
current Banka source of truth. Its tier marker must match the project's
structure: Minimal keeps live state in the block, Core uses `/core/`, and
Standard uses `/context/`. `CLAUDE.md`, when present, is only the exact
`@AGENTS.md` import used by Claude Code; it is not a second state file.

Recognizable older CLAUDE-first Banka structures are compatibility-read-only.
They may be inspected safely when a read-only operation permits it, but Banka
does not rewrite, promote, or otherwise mutate them. A migration must be
explicitly requested, previewed file by file, and confirmed before it runs.
Conflicting files, malformed markers, two state directories, or a tier that
does not match its structure require reconciliation rather than a guess. The
complete classification and migration sequence live in
[protocol/Banka.md](protocol/Banka.md#section-3-runtime-authority-and-minimal-state).

## 5. Adoption completion

Banka adoption is complete only when:

- decision-ready scope is present;
- any required Docking assessment has reached `Ready for Banka`;
- the appropriate Banka tier and schema-2 `AGENTS.md` source-of-truth
  structure exist;
- applicable runtime instructions and Banka capabilities are available, with
  the exact `CLAUDE.md` import present when Claude Code compatibility is
  needed;
- current state, decisions, risks, owner dependencies, and next actions are
  durably recorded;
- existing project knowledge has been preserved or deliberately reconciled; and
- a new session can recover the project's Banka-managed state sufficiently to
  continue safely (the Cold Agent Test, [protocol/Banka.md](protocol/Banka.md#section-3-runtime-authority-and-minimal-state) §3.1).

If these conditions are not met, describe the remaining gap and treat Banka
adoption as in progress.

## 6. After adoption

Once adoption is complete, normal Banka operation begins.

From this point, use the current Banka protocol, skills, state-management rules,
and project-specific instructions.

ASMP or Docking may be used again if a future condition genuinely requires
them, but they are not recurring Banka ceremony.

## Ecosystem boundary

**ASMP defines scope. Docking verifies readiness. Banka adopts and operates.**

Banka requires decision-ready scope, not ASMP. ASMP is an independently usable
scoping protocol and one available route when scope needs substantial
clarification.

Existing projects must be ready before Banka adoption. Banka Docking is Banka's
canonical protocol for establishing that readiness when it has not already been
established.

Banka routes to companion protocols when needed, applies their current canonical
versions, and consumes their outputs without copying their internal rules.
