<!-- Architecture: stack, folder structure, invariants, conventions, and third-party library patterns -->

# Architecture

## Stack

| Layer | Tool | Purpose |
| ----- | ---- | ------- |
| `[e.g. Framework/Runtime]` | `[e.g. Next.js / Electron+React / Python+FastAPI]` | `[what it does in this project]` |
| `[e.g. Data storage]` | `[e.g. PostgreSQL / local encrypted files / SQLite]` | `[primary data store]` |
| `[e.g. Access control]` | `[e.g. Clerk / NextAuth / local password+PIN]` | `[how users/sessions are authenticated]` |

Stack choice varies by project. This table records what was chosen for *this*
project; it is not a recommendation the framework is making.

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

Naming, formatting, and syntax. Identity-layer choices such as styling and state
management must match this project's actual stack rather than being defaulted.
Stack-independent, checkable quality rules such as never swallowing an error may
be stated as settled requirements.

- `[e.g. Never hardcode a hex color — reference a named constant.]`
- `[e.g. No TODO comment without a linked ticket reference.]`

---

## Third-Party Library Patterns

Usage patterns for libraries/APIs this project depends on, so every session uses them the same way. Delete this section if nothing yet warrants it.

```typescript
// [Description of when/how this pattern is used in this project]
[real code snippet, once the integration exists]
```
