# Banka Adoption Guide

Use this guide when bringing a project under Banka management.

Banka may be entered from a new project or an existing project. Before adoption,
determine whether the project already has adequate scope and, for an existing
project, whether it is ready for Banka.

Banka knows its companion protocols but does not reproduce their rules. When a
companion protocol is needed, apply its current canonical version to the project
and consume its output before continuing Banka adoption.

## Entry flow

```
Start Banka adoption
        |
        v
Is scope adequate?
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

A brownfield project may reveal inadequate scope during Docking. If that happens:
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

## 1. Establish adequate scope

Banka needs enough reliable scope to understand the intended outcome,
constraints, boundaries, and relevant decisions.

If scope is adequate, continue.

If scope is materially unclear, pause Banka adoption and clarify it before
continuing.

[Adaptive Scope Mapping Protocol (ASMP)](https://github.com/partikularwaters/adaptive-scope-mapping-protocol)
is one available route for turning unclear intent into decision-ready scope.
ASMP is not required when another adequate scope source already exists.

Banka consumes adequate scope; it does not require a particular scope filename
or scoping method.

## 2. Establish brownfield readiness when required

For a new project with adequate scope, continue to Banka adoption.

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

Once prerequisite scope and readiness are sufficient, Banka becomes
authoritative for adoption.

Banka should:

1. consume the available scope and, when applicable, Docking handoff;
2. inspect existing Banka state before creating or replacing anything;
3. choose the smallest Banka tier appropriate to the project's actual needs;
4. establish the required Banka source-of-truth and session-state structure;
5. establish runtime instructions and make applicable Banka skills discoverable;
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

Current Banka remains authoritative for the resulting tier and managed
structure.

## 5. Adoption completion

Banka adoption is complete only when:

- prerequisite scope is adequate;
- any required Docking assessment has reached `Ready for Banka`;
- the appropriate Banka tier and source-of-truth structure exist;
- applicable runtime instructions and Banka capabilities are available;
- current state, decisions, risks, owner dependencies, and next actions are
  durably recorded;
- existing project knowledge has been preserved or deliberately reconciled; and
- a new session can recover the project's Banka-managed state sufficiently to
  continue safely.

If these conditions are not met, describe the remaining gap and treat Banka
adoption as in progress.

## 6. After adoption

Once adoption is complete, normal Banka operation begins.

From this point, use the current Banka protocol, skills, state-management rules,
and project-specific instructions.

ASMP or Docking may be used again if a future condition genuinely requires
them, but they are not recurring Banka ceremony.

## Ecosystem boundary

**ASMP scopes. Docking prepares. Banka adopts and operates.**

Banka requires adequate scope, not ASMP. ASMP is an independently usable
scoping protocol and one available route when scope needs substantial
clarification.

Existing projects must be ready before Banka adoption. Banka Docking is Banka's
canonical protocol for establishing that readiness when it has not already been
established.

Banka routes to companion protocols when needed, applies their current canonical
versions, and consumes their outputs without copying their internal rules.