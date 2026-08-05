<!-- Library docs: key usage patterns for the libraries in this project -->

# Library Docs

Project-specific usage patterns for every third party library in this project. This file only covers how we use each library in this specific project — rules, patterns, and constraints specific to this codebase.

Read the relevant section before implementing any feature that touches these libraries.

---

## Before Using Any Library

Before implementing any feature that uses a third party library:

1. **Check CLAUDE.md** at the project root — it lists every skill installed for this project. Skills contain up-to-date API documentation and usage patterns specific to this codebase.
2. **Check if an MCP server is configured** for that library. If one is available — use it before falling back to general knowledge.
3. **Read this file** for project-specific patterns that override general library knowledge.

The order of authority is:

```
MCP server (real-time docs) → Skills → This file (project rules) → General training knowledge
```

Never rely on general training knowledge alone for library APIs — they change frequently and training data may be outdated.

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
