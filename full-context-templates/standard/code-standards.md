<!-- Code standards: rules the agent must follow when writing code for this project -->

# Code Standards

Implementation rules for the entire project. Followed in every session without exception — this is what prevents pattern drift across sessions and execution models when Delegation Setup (Section 7.5) is in use.

**Every rule in this file must pass the checkability test** (Fill-In Discipline, Section 2.5, rule 2): could a session check real code against this and get a clear yes/no? A rule that only *sounds* like guidance gets rewritten concrete or removed — it does not stay in as filler.

---

## Engineering Mindset

- Think before implementing — understand what's being built and why before writing a line. This is what the charter skill exists to force before code starts.
- Scope is sacred — build only what the current plan/ticket requires. Do not add adjacent improvements uninvited.
- Clean over clever — simple, readable code is preferred even when a denser version is possible.
- One thing at a time — finish a feature fully, including a survey, before starting the next.

---

## Language & Type System

**Register: Agnostic (identity layer).** No single answer applies to every project. Pick the pattern matching this project's actual language, state it, delete the others — same discipline as `ui-tokens.md`'s pattern selection.

**Pattern A — TypeScript, strict mode:**
- `strict: true` in `tsconfig.json`, no exceptions
- Never use `any` — use `unknown` and narrow the type
- All function parameters and return types explicitly typed
- `const` by default; `let` only when reassignment is genuinely needed

**Pattern B — Python, typed:**
- Type hints on every function signature (parameters and return)
- Run a static checker (e.g. `mypy`) as part of the standard workflow — state which
- Avoid bare `except:` — catch specific exception types

**Pattern C — Dynamically typed, no static type system (e.g. plain JavaScript):**
- Runtime validation at every external boundary (user input, file reads, IPC messages) using a real validation approach — state which library or hand-written guard pattern this project uses
- JSDoc type annotations on exported functions, even without a type checker enforcing them

**Invariant, regardless of pattern:** a value crossing a trust boundary (user input, a file read from disk, an IPC message, an API response) is validated before use — never assumed correct because "it should be."

---

## File and Folder Naming

**Register: Soft Suggestion.** Convention, not correctness (Section 2.6) — reasonable teams land differently. The values below are this protocol's default; if the project (or an existing codebase being onboarded) already has a real, consistent convention that differs, keep the existing one rather than forcing a switch.

- Folders: kebab-case
- Component/class files: PascalCase
- Utility/helper files: camelCase
- One component or one cohesive unit per file — no grab-bag files

---

## Component / Module Structure

**Register: mixed — the import/export order below is Soft Suggestion (Section 2.6's File/folder-naming row: convention, not correctness); the two rules under it are Hard Default (Section 2.6's registry) — state as settled, not as a proposal to react to.**

State the actual import → logic → export order this project follows, e.g.:

```
[imports] → [types/interfaces] → [component or function body] → [exports]
```

- **Hard Default:** No inline styles — all styling goes through `ui-tokens.md`/`ui-rules.md`, never a one-off style attribute with hardcoded values. (Generalizes the same Hard Default as "never hardcode a hex color — reference a named constant.")
- **Hard Default:** No business logic inside UI components — UI components render and dispatch; logic lives in the layer this project's `architecture.md` designates for it. (Section 2.6 registry: UI/logic separation.)

---

## Backend / Data-Handling Conventions

**Register: Agnostic (identity layer).** Pick the pattern matching this project's actual shape:

**Pattern A — Web API routes (Next.js, Express, etc.):**
```
Every route validates the request before processing.
Always return a consistent shape: { success: boolean, data?, error? }.
Never expose a raw internal error message to the client — map it to a human-readable one.
```

**Pattern B — Electron IPC (main process ↔ renderer):**
```
Every IPC handler validates its payload before acting on it.
Handlers return a consistent shape: { success: boolean, data?, error? } —
same discipline as a web API route, just over IPC instead of HTTP.
Never let the renderer process directly touch the file system or an
encryption key — that access lives in the main process only, called via IPC.
```

**Pattern C — CLI commands:**
```
Every command validates its arguments before acting.
Errors print a human-readable message to stderr and exit with a non-zero code —
never a raw stack trace as the user-facing output.
```

**Pattern D — No backend layer (fully local, no external calls):**
```
State explicitly that this project has no network-facing backend layer.
"Backend conventions" in this project means the data-access layer only —
see Database / Data Access below.
```

---

## Database / Data Access

**Register: Agnostic (identity layer)** for which pattern applies — **Hard Default** for the bullet rules once a pattern is picked (querying only through a data-access layer, scoping every query, atomic writes — these hold regardless of which pattern below is in play). Same branching as above — pick what matches:

**Pattern A — Relational database (Postgres, MySQL, etc.):**
- Never query the DB directly from a UI component — always through a service/data-access layer
- Every query scoped to the current user/tenant — never fetch without that filter
- Transactions for any operation touching more than one table

**Pattern B — Local encrypted file storage (no server database):**
- Never read or write a data file directly from a UI component — always through the project's data-access layer, which handles encryption/decryption
- Every write is atomic where the underlying storage allows it — never leave a partially-written file on failure
- State this project's actual encryption approach here explicitly (e.g. "AES-256-GCM, key derived via scrypt from the master password") — this is exactly the kind of Absolute Invariant that belongs in `architecture.md` too, not just here; keep both in sync

**Pattern C — No persistent data layer (stateless / in-memory only):**
- State this explicitly rather than leaving the section blank

---

## Error Handling

**Register: Hard Default** (Section 2.6 registry). State these as settled, not as a proposal to react to — the only thing to confirm with the user is whether this project needs anything *added* to the list, never whether to keep what's here.

- Never an empty catch block — always log or handle
- User-facing errors are human-readable — never a raw exception message or stack trace shown to the end user
- Log errors with a context prefix identifying where they came from (e.g. `[module/function]`)

---

## Delegation Tiering (see the `delegate` skill for the full mechanism)

**Register: Hard Default** for the underlying rule (Section 2.6 registry — delegation readiness); the specific items in each list below are this project's own instantiation of it, not universal. `Junior-safe` and `Senior-required` describe the minimum execution capability and judgment the work needs, not a particular model product. A same or stronger model may execute Junior-safe work; Senior-required work never runs in a Junior-only mode.

**Junior-safe by default in this project:**
- Adding a new field to an existing form that already has a matching pattern
- A new component matching an entry already in `ui-registry.md`
- A new CRUD-style handler following an already-established one in this file's Backend/Data-Handling pattern above

**Senior-required, always — never delegate these regardless of how routine they seem:**
- Anything touching the encryption/security layer stated above
- Anything establishing a new pattern for the first time (nothing yet exists to match)
- Anything touching an Absolute Invariant listed in `architecture.md`

`[Add project-specific items to either list as the codebase grows — this section should reflect this project's actual sensitive areas, not just the generic examples above.]`

---

## Comments

**Register: Hard Default** (Section 2.6 registry — comment policy). State as settled.

- No comments restating what the code does — code should read clearly enough not to need that
- Comments only for *why* — a non-obvious decision, a workaround, a constraint that isn't visible from the code alone

---

## Environment Variables / Secrets

| Variable | Used in | Notes |
| -------- | ------- | ----- |
| `[VAR_NAME]` | `[file/module]` | `[never logged, never committed]` |

**Invariant:** no secret, key, or credential-shaped value is ever written into
the Banka-owned block in `AGENTS.md`, `core/progress.md`,
`context/progress-tracker.md`, any other context file, or version control. The
remember skill enforces the same boundary when it updates session state.

---

## Dependencies

Approved dependencies for this project — do not install anything outside this list without updating it first:

- `[package]` — `[purpose]`

If the Design Craft Add-on (Section 7.7) is installed, its `pick-ui-library` skill governs which UI/component libraries are trustworthy to add — defer to it rather than picking one ad hoc.

---

## Area overrides

Use `context/area-overrides/<area-slug>.md` with a unique slug per area.
Record the repository-relative area path, overridden convention, replacement,
and reason. Link it below relative to this file. Existing linked files keep
their paths; never use nested `AGENTS.md` files for overrides.

_Empty until `charter` finds a real, repeated divergence from this file's
defaults and the developer confirms capturing it (Protocol Section 2.10).
Never an Absolute Invariant — those stay project-wide._

| Area | Override file | Captured |
| ---- | -------------- | -------- |
| `[e.g. src/payments/]` | `[path]` | `[date]` |
