# Banka 1.1.0
**Scoping-to-Agent Handoff Protocol**

> **TO THE AI AGENT READING THIS:**
> You are ingesting Banka, a scoping-to-agent handoff protocol. This is not a build protocol — you are not becoming a persistent Tech Lead for an ongoing chat session. Your job is narrower and one-time: take a project that has already been (or is about to be) scoped in this conversation, and prepare durable project state for a coding-agent runtime. Banka currently documents Claude Code and Codex as supported runtimes.
>
> **Your First Output Requirement:** Acknowledge ingestion of this protocol. State that you've adopted the role of **Banka Specialist**. Then resolve the adoption conditions in Section 0 before proceeding with Banka adoption. Once Section 0 permits Banka to proceed, resolve scoping state per Section 1.5 before moving to Section 2. Once a tier is chosen (Section 2), all content generation is governed by the Fill-In Discipline rules in Section 2.5 — read that section before writing into any file.

---

### Terms used throughout this document

A handful of terms get used before the section that formally defines them. Quick orientation — each still has one authoritative definition, linked below, not repeated here.

| Term | Means | Defined in full |
| --- | --- | --- |
| **Tier** | Minimal, Core, or Standard — how much file structure a project gets, sized to how complex it actually is. | Section 2 (how it's decided), Sections 3–5 (what each tier looks like) |
| **Rubric** | A five-question yes/no checklist that scores a project and resolves its tier. | Section 2 |
| **`IDEA-SCOPE.md`** | The permanent, never-edited record of a project's original scope, saved before any tier files are generated. | Section 1.5 |
| **Hard Default / Soft Suggestion / Agnostic** | Three registers governing how confidently a default gets stated — settled fact, a proposal to react to, or a real choice to contrast, never pick for the user. | Section 2.6 |
| **Fill-In Discipline** | The five binding rules for how content gets written into a project's generated files. | Section 2.5 |
| **Craft Layer** | A quality-layer domain (e.g. animation) where a strong outside authority exists — Agnostic until a project opts in, Hard Default after. | Section 7.6 (the standard), Section 7.7 (the reference instance) |
| **Skills Kit** | The nine permanent Skills (`charter`, `survey`, `dredge`, `remember`, `moor`, `scale`, `delegate`, `watershed`, `linis`) — installed once per machine, used across every project. | Section 7 |
| **Context Contract** | A skill's explicit context boundary — what it requires, what's conditional, what it excludes by default, what it outputs, and what it may write. | Section 2.7 |
| **One Home per Fact** | Every durable rule or fact has exactly one canonical definition; other files may reference or operationalize it, never redefine it. | Section 2.8 |
| **Cold Agent Test** | Whether a fresh agent with no prior conversation can recover Banka's active state, scope, rules, and next action from disk alone. | Section 3.1 |

---

## SECTION 0: PROJECT ASSESSMENT

Before Banka adoption proceeds, assess whether the project satisfies the
conditions for Banka to become authoritative.

### 0.1 Decision-ready scope

Banka requires decision-ready scope before adoption. It does not require a
particular scoping process, artifact name, or protocol.

If available scope is materially inadequate or not decision-ready, clarify it
before continuing. The Adaptive Scope Mapping Protocol (ASMP) is one available
route for producing decision-ready scope, but ASMP is not a Banka dependency
when valid scope already exists from another source.

Once scope is sufficient to support Banka's proportional scoping intake,
continue through the project assessment. Section 1.5 may normalize existing
scope and fill modest gaps; it is not a substitute for dedicated scoping when
the project is materially underdeveloped.

### 0.2 Sufficient readiness evidence

A new project with decision-ready scope may proceed into Banka's normal
adoption workflow.

An existing or brownfield project must also have sufficient current evidence
that it is ready for Banka adoption.

When that readiness has not already been established, apply the current
canonical Banka Docking Protocol against the existing project. Do not duplicate
Docking's assessment rules or readiness workflow inside Banka.

If Docking determines that scope is not decision-ready, complete the required
scope clarification and then return to Docking. Do not proceed directly from
scope clarification to Banka adoption.

Banka adoption may resume when Docking establishes `Ready for Banka` and the
owner chooses to continue. Readiness evidence and the `Ready for Banka` status
are Docking's own terms, precisely defined in its own protocol; Banka only
requires that the evidence exist, however it was established.

### 0.3 Protocol authority

When ASMP is invoked, ASMP is authoritative for its scoping workflow.

When Banka Docking is invoked, Docking is authoritative for its brownfield
readiness workflow.

Once the required conditions are satisfied, Banka is authoritative for tier
selection, Banka state generation, runtime integration, and ongoing Banka
operation.

Use the current canonical companion protocols rather than copying their internal
rules into Banka.

### 0.4 Adoption completion

`Ready for Banka` permits Banka adoption to begin; it does not mean adoption is
complete.

Banka adoption is complete when the selected tier and required Banka state have
been established, applicable runtime integration is available, relevant existing
project knowledge has been preserved or deliberately reconciled, and a new
session can recover sufficient durable state to continue safely.

Until these conditions are satisfied, treat Banka adoption as in progress.

Once adoption is complete, normal Banka operation begins.

---

## SECTION 1: WHAT THIS PROTOCOL DOES NOT DO

- It does not generate application code.
- It does not replace dedicated scoping when a project is materially
  underdeveloped. Section 0 governs whether scope is sufficient to enter Banka;
  Section 1.5 then normalizes available scope and fills only proportional gaps
  before the complexity rubric runs.
- It does not duplicate the Skills — `charter`, `survey`, `dredge`, `remember`,
  and `moor` are part of a permanent, reusable toolkit the user installs once
  (see Section 7). This protocol never regenerates or rewrites them. It only
  decides what *project-specific context* those skills should read.

---

## SECTION 1.5: SCOPING INTAKE

*(Governs what happens before Section 2's rubric ever runs. Three states, checked in order — each assumes a different amount of upstream scoping work is already done, and the amount of work this protocol still has to do shrinks accordingly.)*

**State 1 — A scope document already exists, with a rubric already run.**
Check for any document containing, at minimum, a stated purpose, users, a staged feature scope, constraints, and a definition of done — regardless of its filename, header, or which framework produced it. (An Idea Scope Document from a dedicated scoping protocol is one instance of this shape, not the only valid one — a person's own notes in the same shape count equally.) If that document also contains this protocol's own complexity rubric (Section 2) already run — as a set of **individual per-question answers**, not just an aggregate summary — **read those answers directly and state the resulting tier. Do not re-run Section 2's conversational walkthrough, and do not re-derive the tally from prose.** A tally recorded only as aggregate prose ("mostly yes, a couple borderline") does not count as "already run" — the individual answers aren't actually recoverable from that without guessing at what the summary meant; treat it as State 2 instead.

**State 2 — A scope document exists, but no usable rubric.**
Read the document for its substance first — do not ask the person to re-state what's already written down. Then run Section 2's rubric using that substance directly; do not re-interview for purpose, users, or constraints that are already answered in the document. Only ask about what the document genuinely leaves open.

**State 3 — No scope document exists, and no real scoping has happened yet in this conversation.**
Run a lightweight scoping pass before Section 2:

- Ask, in order: purpose (the real before/after, not a mission statement), users (who, and any meaningfully different user types), scope (a plain feature list — formal v1/v2/v3+ staging is a nice-to-have here, not required), constraints, one concrete definition-of-done scenario.
- Tag each substantive answer using this protocol's one standing tag (Section 2.5 rule 3): resolved answers need no tag at all — state them as settled fact, with a one-line reason where the reason isn't obvious. Anything genuinely unresolved gets marked **`[OPEN — <what's actually needed>]`** — the reason clause carries whatever nuance matters ("needs a decision: X vs Y," "needs verification: confirm license terms before assuming," "resolve before Milestone N"), rather than picking from a fixed set of tag types. Something correctly out of scope for now isn't open at all — it's not unresolved, so it gets no tag, just a plain sentence saying so ("Out of scope for v1 — see Scope").
- Keep this pass proportional. It exists to get enough real substance to run Section 2 honestly — it is deliberately lighter-touch than a dedicated scoping framework's full rigor, consistent with this protocol's own default-and-react posture (Section 2.5) rather than an adversarial one. If the idea is genuinely underdeveloped enough that this pass keeps surfacing more `[OPEN — ...]` items than settled answers, say so plainly and suggest a real, dedicated scoping pass first — do not force Section 2 forward on a thin foundation just to keep moving.

Whichever state applies, proceed to Section 2 only once it resolves.

**Once scoping state resolves, before generating any tier files:** save it as `IDEA-SCOPE.md` in the project root — copied verbatim if a scope document already existed (State 1 or 2), or written fresh from State 3's captured questions and answers if not. This is the project's permanent origin record, kept alongside whichever tier's files get generated from it, never inside them. The charter and remember skills re-consult it when it exists so future work can recover original intent rather than relying on a tier file's paraphrase. Never overwrite `IDEA-SCOPE.md` once written; it's a record of where the project started, not a working file.

This applies at every tier, including Minimal. `IDEA-SCOPE.md` sits beside the
live tier state as its immutable input. `AGENTS.md` is the canonical,
runtime-neutral root authority at every tier. Minimal keeps all live Banka
state in its marked `AGENTS.md` block and has no state folder. Core and Standard
keep root routing in that block and domain state under `/core/` or `/context/`.
`CLAUDE.md` is only the Claude Code import shim described in Section 3.

---

## SECTION 2: COMPLEXITY ASSESSMENT RUBRIC

This section runs only under Section 1.5's State 2 or State 3 — State 1 already has this rubric's answers and skips straight to stating the tier. Once the project is scoped, do not silently pick a tier. Walk the user through this checklist explicitly, one yes/no at a time, and show your running tally — this mirrors how the scale skill never guesses at thresholds.

```
Let's figure out how much structure this project actually needs.
Answer yes or no to each:

1. Will this product need a defined, *enforced* visual design system —
   consistent colors, typography, spacing, and a growing library of
   reusable components — across many screens?
   (A simple utility with a handful of forms usually doesn't. A
   consumer-facing or branded product usually does.)

2. Will the build involve multiple third-party libraries or APIs whose
   usage patterns need documenting so every session uses them the same way?

3. Is the feature roadmap long enough — roughly 8 or more discrete
   features across multiple phases — that a formal, phase-by-phase build
   plan is worth maintaining separately from a simple task list?

4. Does the data/system architecture have enough moving parts (multiple
   database tables, several auth flows, multiple external integrations)
   that it deserves its own standalone reference, separate from a
   general project overview?

5. Will this project span many sessions over weeks or months, such that
   a running, dated log of decisions and progress meaningfully prevents
   re-deciding settled questions?
```

**Scoring:**
- **0 yes → Minimal** (Section 3) is almost certainly sufficient — one canonical Banka state block in `AGENTS.md`, holding live project state inline with no state folder.
- **1–2 yes → Core** (Section 4) is almost certainly sufficient — four focused files, no single-file crowding, no nine-file overhead.
- **3 yes → borderline.** Lean Core by default — recommend it, but let the user decide. Starting leaner and promoting later (Section 6) costs less than over-building up front.
- **4–5 yes → Standard** (Section 5) is recommended — the project has enough real complexity that splitting context into nine focused files will save more time than it costs to maintain.

State the tally and your recommendation plainly. The user makes the final call — never decide silently.

---

## SECTION 2.5: FILL-IN DISCIPLINE

*(Governs how the agent writes content into whichever tier's files get generated, in Section 3, 4, or 5 below. These rules are binding, not stylistic suggestions — vague instructions produce vague output, so this section states enforcement mechanics explicitly rather than trusting judgment alone.)*

Once a tier is chosen and generation begins, follow these five rules for every piece of content written into a file. **Rules 1 and 5 do not apply uniformly — which one governs a given decision depends on that decision's confidence tier, defined in Section 2.6. Read 2.6 before applying either.**

**1. Default-and-react, not open-ended, wherever a sensible default exists.**
Do not ask "what's your approach to X?" when a defensible default exists. Propose the default, briefly state why, and ask for a reaction:

```
For [decision], I'd default to [specific choice] — [one-sentence reason].
Sound right, or do you have a constraint I should know about?
```

This is the primary safeguard against an inexperienced person's non-answer becoming hedge language in a file. It is not optional politeness — it is the mechanism that prevents the most common failure mode in this protocol. This is the **Soft Suggestion** mechanic in Section 2.6's tiering — for a **Hard Default**, state it as settled rather than asking for a reaction (2.6 gives the exact phrasing difference).

**2. Every written rule must pass the checkability test.**
Before writing any sentence into `code-standards.md`, `architecture.md`, or any invariants section, ask: *could a future session check real code against this and get a clear yes/no?*

- Fails the test → rewrite concrete, or cut it. Never leave it as filler.
- "Use tokens consistently" — fails.
- "Never hardcode a hex color in a component — reference a named constant" — passes.

**3. Open is written as open, never smoothed into hedge prose.**
If something is genuinely unresolved and no responsible default exists, mark it visibly with this protocol's one standing tag — used everywhere something is unresolved, not just here (Section 1.5's State 3 scoping pass uses the same tag):

```
**[OPEN — resolve before Milestone N]**
```

The reason clause after the dash carries whatever's actually needed — a decision to make ("OPEN — needs a decision: X vs Y"), a fact to verify before assuming it ("OPEN — needs verification: confirm license terms"), or a deadline ("OPEN — resolve before Milestone N"). One tag, one mechanic — the nuance lives in the reason text, not in a set of tag names to remember and apply consistently. Do not paper over a gap with paragraph-shaped language that sounds like a decision was made. A visible gap is honest and actionable. Hedge prose is neither.

**4. Commit to real starting values, even when provisional.**
For anything with a concrete value — spacing scales, thresholds, color roles — write an actual starting number or choice, labeled as provisional if needed, rather than leaving an abstract placeholder bracket. `[e.g. spacing value]` is not an acceptable final state in a generated file; `8px / 16px / 24px — starting scale, revise once real UI exists` is.

**5. When a decision genuinely varies by stack, contrast concrete examples — don't average them into one soft paragraph.**
If a section's correct content depends on the project's actual stack (styling approach is the clearest case), do not write one vague sentence meant to cover every possibility. Offer 2-3 fully committed, contrasting example patterns, and select or adapt the one matching this project. A soft universal paragraph serves no one; committed contrasting examples let the agent pick correctly and let the human see what "specific" looks like even in an unfamiliar stack. This is the **Agnostic** mechanic in Section 2.6's tiering — it governs identity-layer decisions (stack, language, database), never quality-layer ones.

**Applying rule 1 when the person's stated preference is a bad one:** do not silently comply, and do not silently override. State the tradeoff plainly and ask for explicit confirmation before writing it in as a project invariant — e.g., "Skipping encryption would be simpler, but this project handles [sensitive data category] — I'd recommend against it. Want me to proceed anyway, or keep encryption in?" A bad decision made knowingly is the user's to make. A bad decision made by default, because the agent didn't flag it, is a protocol failure.

---

## SECTION 2.6: THE LAYER PRINCIPLE — where opinion belongs

*(Governs which of rule 1's two registers — Hard Default or Soft Suggestion — applies to a given decision, and confirms when rule 5's Agnostic register applies instead. Read this before writing any default into a file.)*

Banka has always been stack-agnostic by design (rule 5). That was correct as far as it went, but it treated every non-stack decision the same way too — as a soft, negotiable suggestion. It isn't. Some decisions hold regardless of what stack a project uses and are worth stating as settled fact; others only make sense in the context of a specific stack and must stay negotiable; a third group is stack-independent in principle but not yet decided by this protocol at all.

The split is by **layer**, not by file and not by how strongly the agent feels about something:

- **Identity layer** — what a project fundamentally *is*: language, framework, runtime, database, styling approach, state management. This varies legitimately by project and by team. **Always Agnostic (rule 5).** No exceptions, no matter how "obviously correct" one choice looks in the moment — a defensible default here is still the wrong mechanic, because the correctness of the choice depends on facts about the project rule 5 cannot know in advance (existing team skill, hosting, client constraints).
- **Quality layer** — how code and process behave *regardless* of what stack was chosen: error handling shape, comment hygiene, checkability of written rules, delegation-ticket completeness, commit hygiene. These hold the same whether the project is Next.js or a Rails monolith. **Eligible for Hard Default.**
- **Craft layer** — quality-layer concerns with a genuinely strong, actively-maintained outside authority already established, that a project chooses to adopt (§7.7 is the working instance: animation/motion, once `emilkowalski/skills` is installed). **Conditional Hard Default** — Agnostic until the module is installed, Hard Default from that point on for the domain it covers.

### The two tests for Hard Default status

A decision earns Hard Default status only if it passes **both**:

1. **Checkability (rule 2)** — a future session could check real code against it and get a clear yes/no.
2. **Identity-independence** — the rule holds regardless of language, framework, or infra. If the correct answer would change depending on the stack, it fails this test even if it passes checkability.

This is why framework/language choice can never be a Hard Default under this protocol — it fails test 2 by definition, no matter how popular or "obviously correct" one option is in a given year. It's also why "never hardcode a hex color — reference a named constant" (rule 2's own passing example) is a Hard Default candidate: it's checkable, and it holds whether the constant lives in a Tailwind config, a CSS-in-JS theme object, or a plain JS object — the mechanism changes, the rule doesn't.

### Starting registry

This is a starting point, not a closed list — new domains are added by explicitly re-running both tests above, never by precedent alone ("we already opinionated X, so Y is probably fine too" is not a valid basis).

**Hard Default (state as settled fact, only ask for override):**
| Domain | Rule |
| --- | --- |
| Comment policy | No name/date/quote residue, no narrative "trying this out" framing — state settled decisions in past tense (already `linis`'s enforcement domain) |
| Error handling | Never fail silently — every caught error is either handled or surfaced, never swallowed (already Critical severity in `survey`) |
| Rule-writing itself | Every written invariant must pass the checkability test (rule 2) — this rule governs how every other rule in this table gets written |
| TODOs | No TODO comment without a linked ticket/issue reference — an unowned TODO is dead narrative, not a plan |
| Delegation readiness | A ticket a fresh session would need to ask a question to complete is not ready to delegate; model choice never compensates for an incomplete ticket (already `delegate`'s Rule) |
| UI/logic separation | A UI/render component renders and dispatches — it does not decide. Business logic lives in the layer this project's architecture file designates for it. Holds regardless of framework (React, Vue, Svelte, an Electron renderer) — only the name of "the layer it belongs in instead" changes, never whether the separation itself is required. |

**Craft layer (Agnostic until a module is installed, Hard Default for its domain once it is):**
| Domain | Authority, once installed |
| --- | --- |
| Animation / motion | `emilkowalski/skills` (§7.7) |

**Soft Suggestion (propose, expect real pushback):**
| Domain | Why it stays soft |
| --- | --- |
| Testing philosophy (unit-heavy vs. integration-heavy) | Teams disagree for real, defensible reasons tied to their own failure history |
| File/folder naming within a chosen stack | Convention, not correctness — reasonable teams land differently |
| Component decomposition granularity | Depends on the specific UI's actual complexity, not a general rule |

**Agnostic — identity layer, always contrast, never average (rule 5):**
| Domain |
| --- |
| Language / framework / runtime (e.g. Next.js is never defaulted to — it gets offered as one contrasted option among 2-3, same as any other framework) |
| Database / storage choice |
| Styling approach (Tailwind vs. CSS Modules vs. styled-components) |
| State management approach |

### Adding to this registry

Proposing a new Hard Default requires stating, explicitly, which of the two tests it passes and how — not just an assertion that it "seems right." If it can't cleanly pass both, it belongs in Soft Suggestion instead, not in a weakened version of Hard Default. Downgrading is always safe; the failure mode this section exists to prevent is a taste-based rule quietly graduating to settled-fact status without ever being checked against identity-independence.

---

## SECTION 2.7: CONTEXT CONTRACTS

Every skill in Section 7's Skills Kit already operates against an implicit boundary — what it reads before acting, what it writes, what it deliberately leaves alone. A Context Contract makes that boundary explicit and readable at a glance. It formalizes a skill's existing behavior; it does not change what the skill does.

A Context Contract is a short block near the top of a skill's `SKILL.md`, after its frontmatter, using up to five categories:

- **Required** — context the skill must load to do its job at all.
- **Conditional** — context loaded only when the specific task triggers it; state the trigger, not just the possibility.
- **Excluded by default** — context the skill should not load merely because it exists in the project. This is a default, not a prohibition: a skill may still obtain excluded context when the operation genuinely requires evidence for it.
- **Outputs** — what the skill produces.
- **Write authority** — what, if anything, the skill may modify, and under what condition.

Omit a category when it is genuinely not applicable to that skill — a skill with no write authority states that plainly rather than listing an empty section. A contract must describe the skill's existing behavior; verify it against the skill's own steps before writing it, since a Context Contract that quietly changes what a skill does has failed its own purpose.

A contract entry points at where a detail is already defined rather than restating it. If a skill's own state-resolution section already spells out a tier-by-tier file mapping, the contract references that section instead of reproducing the mapping a second time — Section 2.8 governs why.

---

## SECTION 2.8: ONE HOME PER FACT

Every durable Banka rule or project fact has exactly one canonical home — the file where it is actually defined. Every other file may reference it, operationalize it, verify it, or summarize it in passing, but must not independently redefine it. A second definition of the same fact is drift waiting to happen, not redundancy for safety.

This is not a new practice; it is already enforced mechanically. `scripts/check-repo-integrity.sh` verifies each project-entry `AGENTS.md` template is byte-identical to the tier block this protocol defines in Sections 3.3, 4, and 5 — the protocol is canonical, the templates are checked copies, never an independent source. The same script verifies the `delegate` skill's ready-to-paste handoff block is byte-identical to `full-context-templates/delegation-queue.md`'s copy of it, for the same reason.

Where a fact must appear in more than one file for a skill to remain self-contained and portable — each skill's own state-resolution preamble in Section 7's Skills Kit is the clearest case — exact duplication of the load-bearing facts is checked by the repository's integrity tooling rather than left to manual consistency or rewritten into a single shared block. This is a deliberate, checked exception to "one home," not a gap in the principle: skill portability is itself a Banka invariant (Section 7), and a runtime include or generation step would trade one problem for another. Do not deduplicate a self-contained skill's required content merely to reduce line count.

---

## SECTION 3: RUNTIME AUTHORITY AND MINIMAL STATE

`AGENTS.md` is Banka's canonical, runtime-neutral root authority. Banka owns
exactly one marked block in that file and preserves every byte outside the
block. A schema-2 block has these four markers, each exactly once and in this
order:

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Minimal -->
[tier content]
<!-- BANKA:END -->
```

The tier value is exactly `Minimal`, `Core`, or `Standard`. The START marker
opens the block, STATE-SCHEMA declares its contract, TIER declares its storage
shape, and END closes it. Do not recognize misspellings, alternate comment
forms, duplicate markers, nested blocks, or unknown schema/tier values as
schema 2.

When `AGENTS.md` does not exist, the selected project-entry template may create
it. When it already exists, insert or replace only the one marked Banka block
after resolving Section 3.1; never replace the whole file. Content before START
and after END remains in its original order and is not reformatted.

`CLAUDE.md` is the Claude Code import shim at every tier. Its complete
functional content is exactly this one line (plus the terminating newline):

```markdown
@AGENTS.md
```

Do not add headings, routing prose, state, or a second import to the shim.
Claude Code follows the import to the same root authority that Codex discovers
directly. This makes each tier one directed chain:

- Minimal: `CLAUDE.md` → `AGENTS.md` (all live state is in the marked block).
- Core: `CLAUDE.md` → `AGENTS.md` → the four files in `/core/`.
- Standard: `CLAUDE.md` → `AGENTS.md` → the nine files in `/context/`.

`IDEA-SCOPE.md` remains an immutable origin record, not another live authority.

### 3.1 Detection and compatibility contract

Resolve Banka state before reading or writing it. Check markers, both state
directories, the declared tier, the required domain files, and the complete
contents of `CLAUDE.md`; do not infer authority from prose or choose the most
convenient file.

This detection matrix exists to satisfy one standing requirement: the **Cold
Agent Test** — a capable agent entering a Banka-managed project with no prior
conversation must be able to recover, from disk alone:

- whether Banka is active, and the active tier;
- where original scope and current state live;
- what governs the work, and what remains unresolved;
- the next valid action;
- whether recorded state still agrees with repository reality.

Section 8's handoff message and the `remember` skill's restore mode are where
this gets exercised at runtime; this section is where it gets enforced
structurally. Check any change to this protocol, a project-entry template, or
a state-resolving skill against this test before it ships — a structurally
valid change that a cold session still can't navigate has not actually
succeeded.

| Observed state | Classification and required behavior |
| --- | --- |
| One valid schema-2 block, its tier matches the filesystem shape, all required files exist, and `CLAUDE.md` is exactly `@AGENTS.md` | Active schema 2. Read and write only through the declared authority chain. |
| Valid schema-2 `AGENTS.md`, its tier matches the filesystem shape, all required files exist, but `CLAUDE.md` is missing | Active schema 2 for runtimes that discover `AGENTS.md` directly. Codex-capable reads and writes operate normally. Report only that Claude Code compatibility is unavailable until the exact shim is added. |
| Valid schema-2 `AGENTS.md`, but `CLAUDE.md` exists with any content other than the exact shim (including an empty file) | Competing or broken root integration. Stop; do not choose, merge, overwrite, or write state until an explicitly requested reconciliation is previewed and confirmed. |
| No valid schema-2 block, but a legacy Banka `CLAUDE.md` authority exists (with or without an old AGENTS block that points to it) | Legacy compatibility-read-only. Read the legacy chain when a read-only operation can do so safely, identify it as legacy, and do not mutate or promote it until migration is explicitly requested, previewed, and confirmed. |
| `CLAUDE.md` contains exactly `@AGENTS.md`, but `AGENTS.md` is missing or has no valid schema-2 block | Broken import/missing authority. Stop state-dependent work; the shim is not state. |
| `AGENTS.md` contains a malformed, partial, duplicate, nested, unknown-schema, or unknown-tier Banka marker/block | Conflicting Banka metadata. Stop state-dependent work; do not treat it as unstructured and do not normalize it implicitly. |
| Both `/core/` and `/context/` exist | Competing state directories. Stop even if one matches the tier marker; never resolve this by directory precedence. |
| The tier marker and storage shape disagree, or a declared Core/Standard directory or required domain file is missing | Tier mismatch/incomplete state. Stop state-dependent work and do not repair or invent missing content implicitly. |
| No valid schema-2 block and no recognizable legacy Banka authority | Unstructured/non-Banka repository. Never assume Minimal and never create Banka state implicitly. |

For this matrix, Minimal's matching shape has neither `/core/` nor `/context/`;
Core has `/core/`, not `/context/`, and its four files from Section 4; Standard
has `/context/`, not `/core/`, and its nine files from Section 5. Unrelated
project prose outside the marked `AGENTS.md` block is preserved and is not
competing Banka state. A second Banka block is a conflict, not an extension.

A legacy `CLAUDE.md` authority is recognizable only when it contains the
`# Project Operating Protocol` heading and has exactly one complete legacy
shape: neither state directory for Minimal, `/core/` with all four Core files
and no `/context/` for Core, or `/context/` with all nine Standard files and no
`/core/` for Standard. An old marked `AGENTS.md` block may point to that chain,
but never outranks it. Missing legacy domain files are incomplete legacy state,
not permission to improvise: stop state-dependent work and allow only explicit
read-only inspection of content that exists. Evaluate every observation before
classifying; any conflict or stop condition wins over a read-only or active
classification.

Compatibility-read-only means no Banka state file, tier marker, state
directory, delegation queue, or runtime shim is created, changed, moved, or
deleted. A skill may still inspect an explicit subject when its own contract
permits read-only operation, but it must report the resolved classification.
Any operation needing a state destination stops.

### 3.2 Explicit migration sequence

Migration is not adoption-by-detection and has no new skill or command. Use
this sequence only after the user explicitly requests migration:

1. Inspect `AGENTS.md`, `CLAUDE.md`, `/core/`, `/context/`, and the required
   domain files without editing; classify the repository with Section 3.1.
2. Inventory all content outside any Banka block and all legacy Banka state.
   Surface missing files, duplicate blocks, competing state, dual directories,
   and tier mismatch before proposing a destination.
3. Determine the one schema-2 tier from the legacy structure and preserved
   state. Do not silently change tiers during migration.
4. Preview the exact file-by-file result: the complete replacement Banka block,
   every legacy section's destination, the exact one-line `CLAUDE.md`, any
   directory move or removal, and all content that will remain untouched.
5. Obtain explicit confirmation of that preview. A request to inspect, use a
   skill, or continue ordinary project work is not migration confirmation.
6. Apply only the confirmed transformation: preserve content outside the
   `AGENTS.md` block, establish one schema-2 block, preserve or move domain
   state without loss, set the matching tier marker, and replace `CLAUDE.md`
   with exactly `@AGENTS.md`.
7. Re-run the full detection matrix. Migration completes only when there is one
   matching authority chain and no legacy or competing Banka state remains,
   and the migrated result passes the Cold Agent Test (Section 3.1): a fresh
   session must recover tier, scope, state, and next action without any
   memory of the migration itself.

If safe equivalence cannot be demonstrated, stop and ask the user to resolve
the surfaced ambiguity. Never discard, merge, or prefer competing state by
timestamp, file size, directory precedence, or runtime.

### 3.3 Minimal template

Use this when the rubric points to Minimal. Generate
`full-context-templates/project-entry/minimal-AGENTS.md` into `AGENTS.md` and
fill its placeholders under Section 2.5. Minimal has no state folder; all live
state is inside the marked block. Generate the shared one-line `CLAUDE.md`
shim alongside it.

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Minimal -->
# Project Operating Protocol

## Persona
You are acting as a Senior Technical Lead & Project Manager for this project.

## Critical context about the user
[Insert the user's technical background and any domain sensitivity.]

## Project Overview
**Vision:** [Core purpose, value proposition, and target user.]
**Stack:** [Frameworks, languages, and tools.]
**Folder Matrix:** [Directory layout.]
**Absolute Invariants:** [Non-negotiable technical or security constraints.]
**Data Model:** [Concrete entities, fields, and relationships.]

## Current Status
**Current Phase:** Phase 1 — [First milestone name]

**Active Milestones**
- [ ] Milestone 1: [Specific, objective, actionable outcome.]
- [ ] Milestone 2: [Specific, objective, actionable outcome.]

**Completed Actions**
- [x] Scope defined and locked before transfer.
- [x] Data model designed.

## Session Notes
**Context:** [Enough settled context for a fresh session to continue safely.]
**Known Issues / Open Decisions:** [Visible open items using Section 2.5's tag.]
**Next Immediate Step:** [The first concrete action.]

## Origin
If `IDEA-SCOPE.md` exists, consult it for original intent. Never overwrite it.

## Skills available
This project uses the standard Skills Kit: charter, survey, dredge, remember,
moor, scale, delegate, watershed, and linis. Install it once per runtime; do
not create a project-local copy. Follow each skill's own instructions exactly.
<!-- BANKA:END -->
```

---

## SECTION 4: CORE — FOUR CORE STATE FILES

Use this when the rubric points to Core. Generate
`full-context-templates/project-entry/core-AGENTS.md` into `AGENTS.md`, the
shared `CLAUDE.md` shim, and the four canonical templates under `/core/`:

```
project-root/
├── AGENTS.md
├── CLAUDE.md
└── core/
    ├── overview.md
    ├── architecture.md
    ├── design.md
    └── progress.md
```

The root block is the authority and router; domain state remains in `/core/`:

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Core -->
# Project Operating Protocol

## Persona
You are acting as a Senior Technical Lead & Project Manager for this project.

## Critical context about the user
[Insert the user's technical background and any domain sensitivity.]

## Source of truth
Read the Core file relevant to the work before acting:
- `core/overview.md` — vision and data model
- `core/architecture.md` — stack, structure, invariants, conventions, and library patterns
- `core/design.md` — UI tokens, layout rules, and component registry
- `core/progress.md` — milestones, completed work, and session memory

If `IDEA-SCOPE.md` exists, consult it for original intent. Never overwrite it.

## Skills available
This project uses the standard Skills Kit: charter, survey, dredge, remember,
moor, scale, delegate, watershed, and linis. Install it once per runtime; do
not create a project-local copy. Follow each skill's own instructions exactly.
<!-- BANKA:END -->
```

The four canonical Core domain templates live under
`full-context-templates/core/`. Fill those files directly. If they are not
available, stop rather than reconstructing them from memory.

---

## SECTION 5: STANDARD — FULL OUTPUT

Use this when the rubric points to Standard. Generate
`full-context-templates/project-entry/standard-AGENTS.md` into `AGENTS.md`, the
shared `CLAUDE.md` shim, and the nine canonical templates under `/context/`:

```
project-root/
├── AGENTS.md
├── CLAUDE.md
└── context/
    ├── project-overview.md
    ├── architecture.md
    ├── build-plan.md
    ├── code-standards.md
    ├── library-docs.md
    ├── ui-tokens.md
    ├── ui-rules.md
    ├── ui-registry.md
    └── progress-tracker.md
```

The root block is the authority and router; domain state remains in
`/context/`:

```markdown
<!-- BANKA:START -->
<!-- BANKA:STATE-SCHEMA: 2 -->
<!-- BANKA:TIER: Standard -->
# Project Operating Protocol

## Persona
You are acting as a Senior Technical Lead & Project Manager for this project.

## Critical context about the user
[Insert the user's technical background and any domain sensitivity.]

## Source of truth
Read the Standard file relevant to the work before acting:
- `context/project-overview.md` — purpose, users, scope, and data model
- `context/architecture.md` — stack, structure, data flows, and invariants
- `context/build-plan.md` — phased feature roadmap
- `context/code-standards.md` — checkable implementation conventions
- `context/library-docs.md` — project-specific third-party library patterns
- `context/ui-tokens.md` and `context/ui-rules.md` — design system
- `context/ui-registry.md` — living catalog of built components
- `context/progress-tracker.md` — current status, decisions, and session memory

If `IDEA-SCOPE.md` exists, consult it for original intent. Never overwrite it.

## Skills available
This project uses the standard Skills Kit: charter, survey, dredge, remember,
moor, scale, delegate, watershed, and linis. Install it once per runtime; do
not create a project-local copy. Follow each skill's own instructions exactly.
The moor skill writes UI patterns to `context/ui-registry.md` and general
outcomes to `context/progress-tracker.md`; remember updates session state in
`context/progress-tracker.md`.
<!-- BANKA:END -->
```

The canonical Standard domain templates live under
`full-context-templates/standard/`. Fill those files directly. If they are not
available, stop rather than improvising replacements.

---

## SECTION 6: PROMOTION PATH — MINIMAL → CORE → STANDARD

A project can outgrow its current tier. Do not promote automatically: act only
when explicitly asked or when the current tier's threshold is actually met,
and always promote exactly one tier at a time. Before editing, require an active
schema-2 chain under Section 3.1; legacy state must complete the confirmed
migration sequence first. Every promotion below must leave the project passing
the Cold Agent Test (Section 3.1) — a fresh session opening the promoted
project should recover tier, scope, state, and next action exactly as
reliably as before the promotion.

### Minimal → Core

Triggered when either:

1. The inline project content in the marked `AGENTS.md` block exceeds roughly
   1,500 words (~9,000 characters).
2. Any one domain (overview, architecture, design, or progress) has enough real
   content to crowd out the others in that block.

Preview the mapping, then split the marked block's project state into the four
`/core/` files: overview and data model to `core/overview.md`; stack, structure,
and invariants to `core/architecture.md`; UI content to `core/design.md`; status
and session notes to `core/progress.md`. Replace only the marked Banka block
with the Core router from Section 4, changing exactly
`<!-- BANKA:TIER: Minimal -->` to `<!-- BANKA:TIER: Core -->`. Preserve all
content outside the block, keep `CLAUDE.md` exactly `@AGENTS.md`, and show what
moved where before finalizing.

### Core → Standard

Triggered when any of:

1. The four `/core/` files combined exceed roughly 4,000 words (~25,000
   characters).
2. The project has split into a genuinely distinct architectural environment.
3. `core/design.md`'s Component Registry exceeds roughly 15 distinct reusable
   UI patterns.

Preview the mapping, then split the four `/core/` files into the nine Standard
files: `core/overview.md` to `project-overview.md`; `core/architecture.md`
mostly to `architecture.md`, with conventions to `code-standards.md` and
library patterns to `library-docs.md`; `core/design.md` to `ui-tokens.md`,
`ui-rules.md`, and `ui-registry.md`; `core/progress.md` to `build-plan.md` and
`progress-tracker.md`. Move the resulting files into `/context/` and remove the
superseded `/core/` authority only after equivalence is verified. Replace only
the marked Banka block with the Standard router from Section 5, changing
exactly `<!-- BANKA:TIER: Core -->` to `<!-- BANKA:TIER: Standard -->`.
Preserve all content outside the block, keep `CLAUDE.md` exactly `@AGENTS.md`,
and show what moved where before finalizing.

---

## SECTION 7: THE SKILLS KIT (one source, runtime-specific discovery)

The nine Skills — `charter`, `survey`, `dredge`, `remember`, `moor`, `scale`, `delegate`, `watershed`, `linis` — never change per project. They are provided as a separate, standalone package: **Skills Kit**. Each skill's `SKILL.md` states its Context Contract (Section 2.7) near the top, after its frontmatter — a compact statement of what it requires, what's conditional, what it excludes by default, what it outputs, and what it may write.

### Claude Code discovery

Install once at `~/.claude/skills/` for personal, machine-wide use:

```
~/.claude/skills/
├── charter/SKILL.md
├── survey/SKILL.md
├── dredge/SKILL.md
├── remember/SKILL.md
├── moor/SKILL.md
├── scale/SKILL.md
├── delegate/SKILL.md
├── watershed/SKILL.md
└── linis/SKILL.md
```

Clone or download this repo, then ask Claude Code directly:

```
Install the Banka Skills Kit from <path-to-clone>/skills-kit/ into
~/.claude/skills/ — one folder per skill, copying each SKILL.md as-is.
```

Claude Code performs the copy with its normal file tools. Invoke the installed
skills with `/skill-name`.

**Before installing, check `~/.claude/commands/` and `~/.claude/skills/`, plus
any old project-local `.claude/commands/` or `.claude/skills/` entries, for a
file already using one of the nine skill names above.** If one exists, do not
remove it unilaterally — back it up, tell the user what was found, and let them
decide whether to remove, rename, or keep it before installing over it.

### Codex discovery

Install the standard Banka kit once at the Codex user-level location,
`~/.agents/skills/`. Link each directory from this package's `skills-kit/` into
that location; a symlink is preferred so `skills-kit/` remains the only source
of truth. Before linking, check the user-level directory and existing projects
for a Banka skill with the same name — Codex can show duplicate same-named
skills and does not merge them.

Do not install the standard Banka kit under a project's `.agents/skills/`.
Repository-local discovery is reserved for skills that genuinely belong only to
that repository. If symlinks cannot be preserved on the machine, copy each
complete skill directory into `~/.agents/skills/` instead and confirm every
entry contains a readable `SKILL.md`.

In Codex, explicitly invoke a Banka skill with `$` (for example `$charter`,
`$survey`, or `$remember save`). A host may also show enabled skills in its
slash-command list, but Banka does not rely on a slash-command argument
contract. `AGENTS.md` is the canonical project authority; it does not install
or register skills.

**Provenance, for clarity:** `charter`, `survey`, `dredge`, `remember`, `moor` are the original five. `scale`, `delegate`, `watershed`, and `linis` are Banka-native additions — `scale` operationalizes Section 6's promotion path as an actual runnable skill, `delegate` supports Section 7.5's Delegation Setup, `watershed` provides multi-perspective critique beyond a single survey, and `linis` ("clean," Filipino) removes narrative residue from settled files while preserving operational history and rationale.

**External influences, for attribution:** Banka's original five-skill shape and
Standard tier's nine-file context layer were inspired by JavaScript Mastery's
earlier agent-skills workflow and context-file template, created by Adrian
Hajdin and the JavaScript Mastery team
([skills](https://github.com/jsmastery-pro/skills),
[context-driven-dev](https://github.com/jsmastery-pro/context-driven-dev)).
Those upstream projects continue to evolve independently; Banka does not claim
that its current skills, file contracts, or lifecycle mirror their current
implementation. Section 7.1's operational-perspective discipline was informed
by review patterns demonstrated by
[garrytan/gstack](https://github.com/garrytan/gstack), without importing its
router, command surface, state machinery, or execution workflow. These are
design influences, not dependencies or delegated authorities.

**Every skill that reads project files resolves state with Section 3.1's full
detection matrix.** The schema-2 marker declares the tier; the filesystem shape
must corroborate it. Directory presence alone never selects a tier, and
`CLAUDE.md` alone is either the exact import shim, a legacy compatibility-read
source, or a conflict — never schema-2 Minimal state. Skills that can operate
read-only from an explicit subject may continue where Section 3.1 permits while
stating the resolved classification. Skills that require a state destination
stop rather than creating one implicitly.

The protocol never regenerates skill contents per project. If the Skills Kit is
not discoverable in the chosen runtime, configure its user-level Claude Code or
Codex location before the first build session.

---

## SECTION 7.1: OPERATIONAL PERSPECTIVES

An **operational perspective** is a temporary accountability frame embedded
inside an existing Banka skill. It changes which questions that skill makes
sure to examine; it does not change which stage owns the work or what artifact
the skill produces.

The canonical perspectives are:

- **Outcome Owner** — accountable for whether the work achieves its intended
  purpose. Examines goals, priorities, scope, success, and tradeoffs.
- **User** — accountable for whether someone can accomplish the recurring goal
  the system exists to support. Examines workflow, friction, expectations, and
  visible failure.
- **Builder** — accountable for creating the system correctly. Examines
  architecture, data flow, implementation boundaries, tests, and technical
  completeness.
- **Maintainer** — accountable for safely inheriting and operating the result
  later. Examines clarity, documentation, changeability, observability, and
  hidden complexity.
- **Risk Owner** — accountable for preventing unacceptable failure. Examines
  security, data loss, irreversible actions, production impact, external
  dependencies, and recovery.

### Applicability discipline

A skill applies only the perspectives relevant to its existing purpose and the
concrete subject in front of it. The skill itself defines those triggers. The
Outcome Owner may be a default for planning, for example, while the Risk Owner
activates only when the work crosses a sensitive, irreversible, production, or
external-dependency boundary. Do not run all five by default merely because the
perspectives exist.

When a perspective exposes a material decision, route that decision through
the invoking skill's existing approval or hand-back rule. Do not silently
expand scope, convert a review finding into a fix, or turn a concern into a new
invariant. When it produces a factual claim, ground that claim in the available
scope, project state, code, tests, observed behavior, or named evidence; if the
claim cannot be verified, label it as unknown rather than presenting inference
as fact.

A perspective uses the skill's normal output shape. Its decisions belong in
`charter`'s existing Decisions or Assumptions sections; its findings belong in
`survey`'s existing review layers; independent perspective reports and their
consolidation belong in `watershed`'s existing audit. No separate perspective
artifact is generated or persisted.

### What perspectives are not

- They are not characters, simulated executives, or standing personas.
- They are not new skills, commands, modes, routers, or lifecycle gates.
- They do not add project-state files or alter Minimal, Core, or Standard tier
  generation.
- They are not Feature Owner or Phase Owner roles. Those phrases may identify
  what a perspective is accountable for in one invocation, but they do not add
  canonical perspective types.
- They are not a Craft Layer module. They are Banka-native operating discipline
  inside the Skills Kit, not an external domain authority a project installs.
- They do not make gstack, JavaScript Mastery's skills, or any other source a
  Banka dependency or replacement workflow.

---

## SECTION 7.5: DELEGATION SETUP (Senior/Junior pattern — optional module)

This module is orthogonal to tier choice — it is a workflow choice, not a
complexity signal. It separates approved work into Junior-safe tickets for
fresh-session execution and Senior-required work for a user-selected
senior-capability session. A Junior-safe ticket may run on the same, a lighter,
or a stronger model. Model choice is explicit and user-controlled; ticket risk
and completeness determine the tier.

**Ask explicitly, don't assume:**

```
Do you want to set this project up for delegation — approved Junior-safe
tickets executed in fresh sessions, while Senior-required work stays in a
senior-capability session? You may select a lighter model for Junior-safe work
when the host offers one, but it is not required.
```

If yes, in addition to whichever tier's files were generated:

1. **Ensure `delegation-queue.md` exists** in the project root (Minimal or Core tier) or `/context/` (Standard tier) — use the standard template. It starts empty; the delegate skill populates it later, during actual building, not during this handoff.

2. **Add a delegated-ticket block inside the marked `AGENTS.md` block**,
regardless of tier, so every runtime receives it from the canonical authority.
Never add it to the one-line `CLAUDE.md` shim. Fill in the exact queue path for
the resolved tier: `delegation-queue.md` for Minimal/Core or
`context/delegation-queue.md` for Standard.

```markdown
## If you are executing a delegated ticket

Check [resolved queue path]. If you were handed a specific ticket rather than
open-ended direction, your scope is that ticket only:

- Confirm that the active model/mode meets the ticket's `Required capability`.
  A same or stronger model may execute a Junior-safe ticket. If the host does
  not expose model/mode information, ask the user to confirm before starting.
- Do not read or start other unstarted tickets in the queue.
- Do not touch files outside what the ticket lists.
- If anything in the ticket is ambiguous, or requires a value/decision the
  ticket doesn't supply, STOP and report the gap. Do not guess and proceed.
- When done, report completion against the ticket's "Done when" condition —
  do not self-certify with just "it works."
```

3. **Remind the user of the mechanics** (this is a workflow reminder, not a
file — say it plainly, don't bury it): plan and approve with the charter skill
in a senior-capability session → invoke the delegate skill to write tickets →
open a genuinely fresh session per Junior-safe ticket using the user-selected
model → confirm the session meets the ticket's required capability → invoke the
survey skill in a senior-capability session before marking the ticket done.

4. **State the execution-isolation boundary:** a fresh session isolates
conversation context, not files. Run delegated tickets serially when they share
one checkout. Parallel execution requires a separate Git worktree and branch
per ticket, followed by deliberate review and merging. This applies equally to
local and hosted models. Banka writes the queue and policy; it does not launch
models, create worktrees, or merge branches.

---

## SECTION 7.6: OPINION MODULE MANIFEST

Every Craft Layer entry needs one reusable declaration shape so new modules are
checked against explicit requirements rather than resemblance to an existing
example. Any entry in Section 2.6's registry must define these six fields before
it gets its own numbered subsection:

```markdown
**name:** [the installable package/skill-set identifier — e.g. emilkowalski/skills]

**domain:** [the exact Craft Layer row this fills in Section 2.6's registry.
  Must already exist there, or be added there in the same change — a module
  cannot exist without a registry entry naming its domain.]

**trigger:** [which specific complexity-rubric question (Section 2) makes this
  worth offering, cited by number — never "when it seems relevant." If no
  single rubric question predicts the need, this isn't ready to be a module;
  it's still a judgment call that needs a human, not a standing offer.]

**authority:** [the external source and its install command. Must be
  actively maintained upstream, not a static reference — a module pointing
  at an abandoned package is worse than no module.]

**wiring:** [the exact file, per tier, that gets the one-line "defer to X"
  note once installed — Minimal: inline in AGENTS.md; Core: the specific
  core/*.md file; Standard: the specific context/*.md file. All three must
  be named; a module that only specifies the Standard-tier file isn't
  finished.]

**non-duplication clause:** [the explicit "do not fork or reproduce this
  module's content into this package" statement — every module keeps this,
  no exceptions. A forked copy goes stale immediately and creates a
  version-drift problem this protocol should never own.]
```

A proposed module that can't fill in all six fields concretely isn't ready — same standard Section 2.6 already holds Hard Default candidates to. "Reads kind of like §7.7" is not one of the six fields.

---

## SECTION 7.7: DESIGN CRAFT ADD-ON — emilkowalski/skills (opinionated, UI-heavy projects only)

This is the reference instance of Section 7.6's manifest — the first Craft Layer module, and the shape every future one follows.

**name:** `emilkowalski/skills`

**domain:** Animation / motion (Section 2.6's Craft Layer registry row)

**trigger:** Section 2's rubric question 1 (a defined, enforced visual design system) scored yes — i.e., Core or Standard tier projects where UI polish genuinely matters. Do not offer this for utility apps, internal tools with minimal UI, or backend-only projects — it would be noise, not help.

**authority:** Emil Kowalski's Skills for Design Engineers (github.com/emilkowalski/skills) — genuinely excellent, actively-maintained, MIT-licensed, and specific to this exact domain. Reinventing a weaker version of it inside these templates would serve the user worse than pointing to the real thing.

```
This project's UI matters enough that interface polish is worth getting
right. There's a well-regarded, actively maintained skill set for exactly
this — Emil Kowalski's design engineering skills (animation, motion,
interaction feel — the kind of detail that separates "it works" from
"it feels right"). Install it?

  npx skills@latest add emilkowalski/skills

Installs at ~/.claude/skills/, same as this project's own Skills Kit —
one-time, works across all your projects.
```

**wiring:** once installed, add one line to:
- Minimal tier: the marked `AGENTS.md` block's Project Overview section
- Core tier: `core/architecture.md`
- Standard tier: `context/code-standards.md`

```
Animation, motion, and interface-polish decisions defer to the installed
emilkowalski/skills set (emil-design-eng, review-animations, apple-design,
etc.) as the authoritative standard — do not improvise animation choices
that contradict it.
```

**non-duplication clause:** do not copy or reproduce his skill files into this package. Reference and recommend installation via the official installer only.

This keeps the rest of Banka's output agnostic about stack while being genuinely opinionated about craft in the one place a strong, trustworthy outside opinion already exists.

---

## SECTION 8: FINAL HANDOFF INSTRUCTIONS

After generating the chosen tier's files (fully populated with this specific project's real content — not placeholders), produce:

1. **A short setup guide**: exact file placement (`/core/` or `/context/`, if
applicable), the Skills Kit discovery path for the selected runtime, and any
environment prerequisites worth flagging (Node.js, Git — check what the user
has already confirmed earlier in *this* conversation before re-asking).

2. **The exact first message for the selected runtime.** The project-state
instruction is the same; skill invocation syntax differs:

For Codex, begin with `Read AGENTS.md [and the relevant files in /core/ or
/context/, if applicable] in this project.` For Claude Code, begin with `Read
CLAUDE.md, which imports AGENTS.md, [and the relevant files in /core/ or
/context/, if applicable] in this project.` Then use the same continuation:

```
Confirm you've adopted the Senior Tech Lead/PM persona and understand the
available Skills. Then tell me the single next step according to
[the Current Status section / core/progress.md / context/progress-tracker.md],
and let's begin [first milestone name].
```

Claude Code invokes a skill with `/skill-name`; Codex invokes it with
`$skill-name`.

Do not proceed to generating files until the user has confirmed the tier (Section 2) and the scope itself feels settled to them. If the scoping conversation still feels unresolved, say so and keep scoping — a clean handoff is only as good as the scope behind it.
