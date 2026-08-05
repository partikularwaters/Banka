<!-- System architecture: how the app is structured and how data flows through it -->

# Architecture

## Stack

| Layer | Tool | Purpose |
| ----- | ---- | ------- |
| `[e.g. Framework/Runtime]` | `[e.g. Next.js / Electron+React / Python+FastAPI]` | `[what it does in this project]` |
| `[e.g. Data storage]` | `[e.g. PostgreSQL / local encrypted files / SQLite]` | `[primary data store]` |
| `[e.g. Access control]` | `[e.g. Clerk / NextAuth / local password+PIN]` | `[how users/sessions are authenticated]` |
| `[e.g. Language]` | `[e.g. TypeScript strict]` | `[throughout, or state where it varies]` |

---

## Folder Structure

No single layout fits every project. Pick the pattern matching this project, state it, delete the others.

**Pattern A — Web app (Next.js-style):**
```
/
├── context/                # this project's context files
├── app/
│   ├── [route]/
│   └── api/
├── components/
│   ├── ui/
│   └── [feature]/
├── lib/
└── types/
```

**Pattern B — Electron desktop app:**
```
/
├── context/                 # this project's context files
├── src/
│   ├── main/                # Electron main process — file system, encryption, IPC handlers
│   ├── renderer/             # React UI code
│   │   ├── components/
│   │   └── screens/
│   └── shared/               # types/theme shared between main and renderer
└── data/                     # (local, gitignored) — where encrypted project data actually lives at runtime
```

**Pattern C — Backend service / CLI tool, no UI layer:**
```
/
├── context/
├── src/
│   ├── commands/ or routes/
│   ├── services/             # business logic, isolated from I/O
│   └── lib/
└── tests/
```

---

## System Boundaries

State this project's actual boundaries — the table below is a shape to fill, not a fixed set of folder names:

| Folder/Layer | Owns |
| ------------- | ----- |
| `[e.g. main process]` | `[e.g. File system access, encryption, IPC handlers. No UI logic.]` |
| `[e.g. renderer/components]` | `[e.g. UI only. No direct file/DB access — everything goes through IPC or a service layer.]` |
| `[e.g. lib/services]` | `[e.g. Business logic and third-party client setup. No UI imports.]` |
| `[e.g. types/shared]` | `[e.g. Types/interfaces shared across layers.]` |

---

## Data Flows

### Flow 1 — [e.g. a user action that changes stored data]

```
[e.g. User submits a form in a UI component]
        ↓
[e.g. IPC call to main process, or a Server Action / API call]
        ↓
[e.g. Validation, then write through the data-access layer]
        ↓
[e.g. UI reflects the update — revalidate, refetch, or re-render from new state]
```

### Flow 2 — [name a second real flow specific to this project]

```
[step]
   ↓
[step]
```

---

## Data Model

Same branching as Folder Structure — pick what fits, and prefer real, concrete field names over a generic placeholder table wherever the project's actual data shape is already known.

**Pattern A — Relational schema (SQL):**

Worked example, for reference — this is a real pattern from a shipped project (a costing/inventory app), not a hypothetical. Note the `snapshot_*` columns: rates are copied onto the row at creation time so a later Settings change never retroactively rewrites an already-logged record — state that kind of invariant explicitly wherever it applies to this project too.

### `Batch`
| Column | Type | Notes |
| ------ | ---- | ----- |
| id | uuid | Primary key |
| print_hours / print_minutes | int | |
| snapshot_meralco_rate | decimal(12,4) | Copied from Settings at creation — never retroactive |
| created_at | timestamptz | |

### `Item`
| Column | Type | Notes |
| ------ | ---- | ----- |
| id | uuid | Primary key |
| batch_id | uuid | FK → Batch |
| quantity / quantity_sold | int | `quantity_sold` is a maintained running total, not derived at read time |
| retail_price | decimal(12,2)? | Nullable — a sale can override via its own `unit_price` |

**Pattern B — Structured local records (no SQL database)**

```
Record (container)
  ├── record_id, status, date_created
  ├── linked_summary_id → Summary (one per record)
  └── entries[]           → append-only child entries, timestamped
```

Each entity is a defined record shape (fields + types), stored as its own encrypted unit (e.g. one encrypted file per record), not as rows in shared tables. Define this project's actual entities and their field lists here, the same concrete way — not as an abstract placeholder. If the project handles identity-sensitive fields (a real name, a PIN, anything a breach would expose), name them explicitly here rather than folding them into a generic `entries[]` list, so the Absolute Invariants below can reference them by name.

**Pattern C — No structured data model (stateless service, or state lives entirely client-side):**

State this explicitly.

---

## Storage

**Pattern A — Cloud storage (buckets):**
| Bucket | Path | Contents |
| ------ | ---- | -------- |
| `[bucket_name]` | `[e.g. files/{user_id}/file.pdf]` | `[description]` |

**Pattern B — Local encrypted storage:**
- Where on disk: `[e.g. app's userData directory, one encrypted file per record]`
- Encryption approach: `[state the real algorithm and key-derivation method — e.g. "AES-256-GCM, key derived via scrypt from the user's master password" — this is an Absolute Invariant, not a detail to leave vague]`
- Export/backup mechanism, if any: `[state it, or "none — explicitly out of scope"]`

---

## Access Control

Generalizes "Authentication" — pick what fits. Web session/OAuth auth and a fully local password+PIN unlock solve the same underlying problem differently; name which this project uses.

**Pattern A — Web session/OAuth:**
- Provider: `[e.g. Clerk / NextAuth / custom]`
- Methods: `[e.g. Google OAuth, email+password]`
- Protected vs public routes: `[list them]`

**Pattern B — Local unlock (no server-side auth):**
- Unlock mechanism: `[e.g. a master password unlocks the app; a per-record PIN unlocks an individual record]`
- Recovery path if credentials are lost: `[state it explicitly — "no recovery, data loss is accepted" is a valid answer, but it must be a stated decision, not a silent gap]`
- What is never accessible without unlocking: `[state explicitly what stays encrypted/hidden pre-unlock]`

---

## [Key Integration] Pattern

One section per major external integration this project actually has (a database client, an AI/LLM API, a payment provider, etc.). Delete this section entirely if the project has none — do not leave a placeholder integration that doesn't exist.

```typescript
// [Description of when/how this pattern is used in this project]
[real code snippet, once the integration exists]
```

---

## Absolute Invariants

Rules that must never be silently violated, in any session, regardless of which model is running it:

- `[e.g. No UI component reads or writes data directly — everything goes through the data-access/IPC layer.]`
- `[e.g. All queries/reads are scoped to the current user — never fetch without that filter.]`
- `[e.g. No hardcoded hex value or raw color class in a component — see ui-tokens.md.]`
- `[If this project handles sensitive data: state the encryption/access-isolation invariants explicitly here, matching what's stated in Database/Storage above — do not let the two drift out of sync.]`

**Delegation note:** any change touching an item in this Absolute Invariants list is Senior-required by definition — see `code-standards.md`'s Delegation Tiering section and the `delegate` skill. A ticket that would modify one of these lines should never be marked Junior-safe.
