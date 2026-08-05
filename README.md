# Banka

A protocol and skills kit for scoping, generating, and building Claude Code projects at the right tier of complexity — agnostic about your stack, opinionated about quality.

Banka gives a project two things most AI-assisted builds skip: a scoping step that decides how much structure a project actually needs *before* any files get generated, and a permanent, reusable set of Skills that carry a project through its whole build loop afterward — planning, delegation, review, recovery, and session handoff.

Read [system-map.md](system-map.md) first for the full picture — one diagram, one paragraph per stage, showing how every piece below connects end to end.

## How it fits together

1. **Scope the idea.** Hand Claude Code an existing scope document (or nothing at all — Banka runs its own lightweight scoping pass if you don't have one) and let [protocol/Banka.md](protocol/Banka.md) resolve a tier: **Minimal**, **Core**, or **Standard**.
2. **Generate the project.** Banka writes the right file shape for that tier — a single `CLAUDE.md` for Minimal, a `/core/` folder for Core, a `/context/` folder for Standard — using the templates in [full-context-templates/](full-context-templates/).
3. **Build.** The nine Skills in [skills-kit/](skills-kit/) — `charter`, `survey`, `dredge`, `remember`, `moor`, `scale`, `delegate`, `watershed`, `linis` — install once per machine and work the same way across every Banka project from then on, regardless of tier.

## Installing the Skills Kit

No CLI, no package to publish — the install step is one instruction to Claude Code itself:

```
Install the Banka Skills Kit from <path-to-clone>/skills-kit/ into
~/.claude/skills/ — one folder per skill, copying each SKILL.md as-is.
```

1. Clone this repo: `git clone https://github.com/partikularwaters/Banka.git`
2. Open a Claude Code session anywhere and paste the instruction above (with the real path to your clone).
3. Done — every project on the machine now has access to all nine skills.

**Upgrading from an older, pre-rename install:** check `~/.claude/commands/` (the old single-file command location) and `~/.claude/skills/` for stale files under the old names (`architect`, `review`, `recover`, `imprint`, or an old `remember`/`scale` predating this package) and remove those first — a same-named old command shadowing a new skill is worse than a missing one.

Full install details and rationale: [protocol/Banka.md](protocol/Banka.md), Section 7.

## Repo structure

```
Banka/
├── protocol/Banka.md              # the core handoff protocol
├── system-map.md                  # one-doc orientation, start here
├── skills-kit/                    # the nine Skills — install once, use everywhere
│   └── {charter,survey,dredge,remember,moor,scale,delegate,watershed,linis}/SKILL.md
└── full-context-templates/
    ├── core/                      # the four Core-tier files
    ├── standard/                  # the nine Standard-tier files
    └── delegation-queue.md        # tier-agnostic, used by /delegate
```

## Optional: Craft Layer modules

Banka stays agnostic about stack and framework, but defers to genuinely strong outside authorities for specific craft domains once a project opts in — e.g. [emilkowalski/skills](https://github.com/emilkowalski/skills) for animation and interaction feel. See Section 7.6 (module standard) and Section 7.7 (reference instance) in the protocol doc.

## License

MIT — see [LICENSE](LICENSE).
