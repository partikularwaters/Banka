<!-- Library docs: key usage patterns for the libraries in this project -->

# Library Docs

Project-specific usage patterns for every third party library in this project. This file only covers how we use each library in this specific project — rules, patterns, and constraints specific to this codebase.

Read the relevant section before implementing any feature that touches these libraries.

---

## Before Using Any Library

First identify the exact installed version from the project's dependency files
or lockfile. Then use the right authority for the question being answered:

- **API facts:** official documentation for the installed version establishes
  which functions, options, and behaviors the library supports. An MCP server
  may retrieve that documentation, but the connector itself is not the
  authority.
- **Project policy:** `architecture.md`, `code-standards.md`, and this file
  establish how this project permits the library to be used, including wrappers,
  security boundaries, approved features, and version pins.
- **Workflow guidance:** a relevant skill may explain a repeatable procedure,
  but it cannot override project invariants or claim support the installed
  version does not have.
- **Fallback knowledge:** general model knowledge is used only when the sources
  above do not answer the question, and any version-sensitive claim must be
  verified before implementation.

These are separate authorities, not one universal ranking:

```
What does the installed library support?
  → Official documentation for the installed version

How may this project use it?
  → Project architecture, code standards, and this file

What repeatable process should the agent follow?
  → Relevant skill, within the two boundaries above

No reliable source answers the question?
  → General model knowledge, clearly marked and verified before use
```

When sources conflict, do not silently choose one. For example, current
documentation for a newer major version does not override the version installed
here, and a library capability does not override a project rule that prohibits
its use. Report any genuine incompatibility and propose an explicit dependency
upgrade, project-rule revision, or supported alternative.

---

## [Library 1 — e.g. Database Client]

[One line on what it does in this project.]

### [Usage Pattern 1 — e.g. Client vs Server]

```typescript
// [Context — e.g. browser context only]
[code example]
```

```typescript
// [Context — e.g. server context only]
[code example]
```

**Rules:**

- [e.g. Never use browser client in server context]
- [e.g. Always scope queries to the current user — never query without a user filter]

---

### [Usage Pattern 2 — e.g. Queries]

```typescript
// [Read example]
[code example]

// [Write example]
[code example]
```

**Rules:**

- [e.g. Always handle the error return — never assume success]
- [e.g. Use .single() when expecting exactly one row]

---

### [Usage Pattern 3 — e.g. Storage / File Upload]

```typescript
[code example]
```

**Rules:**

- [e.g. Always use upsert: true for file overwrites]
- [e.g. Never write files to disk — always upload buffer directly]

---

## [Library 2 — e.g. AI Model]

[One line on what it does in this project.]

### [Usage Pattern 1 — e.g. Structured JSON Response]

```typescript
[code example]
```

**Rules:**

- [e.g. Model is always 'gpt-4o' — never switch models]
- [e.g. Always use response_format: json_object for structured data]
- [e.g. Always parse response content as string — wrap in try/catch]

---

### [Usage Pattern 2 — e.g. Temperature Settings]

| Use case                    | Temperature |
| ----------------------------- | ------------ |
| [e.g. Scoring / extraction] | [e.g. 0.3]  |
| [e.g. Creative generation]  | [e.g. 0.7]  |

---

## [Library 3 — e.g. Analytics]

[One line on what it does in this project.]

### [Usage Pattern 1 — e.g. Client Setup]

```typescript
[code example]
```

### [Usage Pattern 2 — e.g. Server Setup]

```typescript
[code example]
```

**Rules:**

- [e.g. Always call shutdown() in server-side functions — events are lost without it]
- [e.g. Event names must match exactly the list in code-standards.md]

---

## [Library 4]

[One line on what it does in this project.]

```typescript
[code example]
```

**Rules:**

- [rule]
- [rule]
