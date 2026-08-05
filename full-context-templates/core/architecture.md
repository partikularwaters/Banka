<!-- Architecture: stack, folder structure, invariants, conventions, and third-party library patterns -->

# Architecture

## Stack

| Layer | Tool | Purpose |
| ----- | ---- | ------- |
| `[e.g. Framework/Runtime]` | `[e.g. Next.js / Electron+React / Python+FastAPI]` | `[what it does in this project]` |
| `[e.g. Data storage]` | `[e.g. PostgreSQL / local encrypted files / SQLite]` | `[primary data store]` |
| `[e.g. Access control]` | `[e.g. Clerk / NextAuth / local password+PIN]` | `[how users/sessions are authenticated]` |

Per the Layer Principle (Section 2.6 of the Protocol): stack choice itself is always Agnostic — this table records what was chosen for *this* project, it is not a recommendation the framework is making.

---

## Folder Matrix

```
/
├── core/                    # this project's context files
├── [app/src/etc.]
└── [...]
```

## Absolute Invariants

Rules that must never be silently violated, in any session, regardless of which model is running it:

- `[e.g. All queries/reads are scoped to the current user — never fetch without that filter.]`
- `[If this project handles sensitive data: state the encryption/access-isolation invariants explicitly here.]`

**Delegation note:** any change touching an item in this list is Senior-required by definition — see the `delegate` skill. A ticket that would modify one of these lines should never be marked Junior-safe.

---

## Conventions

Naming, formatting, syntax. Subject to Section 2.6's Layer Principle: identity-layer choices (styling approach, state management) get contrasted per Fill-In Discipline rule 5, never defaulted. Quality-layer conventions (error handling, comment policy) may be stated as Hard Default — see the Protocol's Section 2.6 registry before writing one in here as settled.

- `[e.g. Never hardcode a hex color — reference a named constant.]`
- `[e.g. No TODO comment without a linked ticket reference.]`

---

## Third-Party Library Patterns

Usage patterns for libraries/APIs this project depends on, so every session uses them the same way. Delete this section if nothing yet warrants it.

```typescript
// [Description of when/how this pattern is used in this project]
[real code snippet, once the integration exists]
```
