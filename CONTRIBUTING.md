# Contributing to Banka

## AI assistance attribution

For transparency, every commit materially shaped by an AI coding assistant must
identify that assistance in the commit-message body.

Use one trailer per contributing assistant:

```text
Assisted-by: <provider or product> (<model, if known>)
```

Examples:

```text
Assisted-by: OpenAI Codex (GPT-5.6)
Assisted-by: Anthropic Claude Code (Claude Opus 4.6)
```

Name the actual product and model when available. If the model is unknown, name
the product only. Repeat the trailer when multiple assistants materially
contributed.

“Materially shaped” means the assistant produced or substantially revised code,
documentation, tests, architecture, or analysis embodied in the commit. Routine
formatters, spell-checkers, and autocomplete do not require attribution.

Keep the human Git author as the author. Do not invent an AI email address or use
`Co-authored-by` unless the repository owner explicitly requests co-authorship
and the assistant has a real, verifiable GitHub-linked identity.
