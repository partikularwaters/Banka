#!/usr/bin/env bash
#
# Simulates a cold Banka-managed project: only what actually travels
# downstream (installed skills, generated tier output) — never
# protocol/Banka.md, system-map.md, README.md, or full-context-templates/
# itself, none of which are ever installed into a real project or a real
# machine-wide skills directory.
#
# This exists because a downstream-facing rule can look fine sitting next
# to protocol/Banka.md in this repo and still be unresolvable the moment
# it's actually installed cold. Run this whenever a skill or a
# project-entry template changes.

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
skills=(charter delegate dredge linis moor remember scale survey watershed)

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

# --- Build the cold-downstream simulation ---------------------------------
# Skills as they exist once installed standalone (~/.claude/skills/<name>/SKILL.md
# or ~/.agents/skills/<name>/SKILL.md) — nothing else from this repo alongside them.
mkdir -p "$tmp_dir/skills"
for skill in "${skills[@]}"; do
  cp -R "$repo_root/skills-kit/$skill" "$tmp_dir/skills/$skill"
done

# Rendered tier output, as a generated project actually receives it —
# copying the templates' *content* into project-shaped paths, never the
# full-context-templates/ directory itself.
mkdir -p "$tmp_dir/project-minimal" "$tmp_dir/project-core/core" "$tmp_dir/project-standard/context"
cp "$repo_root/full-context-templates/project-entry/minimal-AGENTS.md" "$tmp_dir/project-minimal/AGENTS.md"
cp "$repo_root/full-context-templates/core/"*.md "$tmp_dir/project-core/core/"
cp "$repo_root/full-context-templates/standard/"*.md "$tmp_dir/project-standard/context/"

# --- Check 1: nothing references full-context-templates/ ------------------
# This directory structurally never exists outside this repo.
if grep -rl "full-context-templates" "$tmp_dir" >/dev/null 2>&1; then
  fail "A cold-installed file references full-context-templates/ — that directory never travels downstream"
fi

# --- Check 2: no unresolvable "go consult X" phrasing ----------------------
# A downstream reader has no other Banka file to open. Any instruction that
# assumes one is a dead reference the moment it's installed cold.
banned_patterns=(
  "as defined in Protocol"
  "exactly as defined in Protocol"
  "matching the current template"
  "matching Protocol"
  "see Protocol §"
  "see protocol/Banka.md"
  "Protocol §"
  "Section 7.7"
  "Section 7.5"
  "Section 2.6"
  "Section 2.5"
  "Fill-In Discipline"
  "Context Transfer Protocol"
)
for pattern in "${banned_patterns[@]}"; do
  if grep -rl -- "$pattern" "$tmp_dir" >/dev/null 2>&1; then
    fail "Found unresolvable downstream reference pattern in cold-installed content: '$pattern'"
  fi
done

for template in "$repo_root/full-context-templates/core/progress.md" "$repo_root/full-context-templates/standard/progress-tracker.md"; do
  if grep -Fx '## Overflow Index' "$template" >/dev/null 2>&1; then
    fail "${template#$repo_root/} pre-declares an active Overflow Index before an overflow file exists"
  fi
done

# --- Check 3: no protocol-internal jargon in installed skills --------------
# "Track A"/"Track B" mean nothing without protocol/Banka.md open. A skill
# must describe its own behavior directly, never by naming an undefined
# internal label.
if grep -rl -E "Track A|Track B" "$tmp_dir/skills" >/dev/null 2>&1; then
  fail "Found 'Track A'/'Track B' protocol-internal jargon inside an installed skill file"
fi

# --- Check 4: Core/Standard's rendered session-state files are actually
# complete, not just "when," for the overflow mechanics --------------------
for rendered in "$tmp_dir/project-standard/context/progress-tracker.md" "$tmp_dir/project-core/core/progress.md"; do
  grep -qi "sequentially\|01-" "$rendered" || fail "Missing the sequential-numbering convention for overflow files in ${rendered#"$tmp_dir/"}"
  grep -qi "contents" "$rendered" || fail "Missing the overflow file's own Contents-header requirement in ${rendered#"$tmp_dir/"}"
  grep -qi "overflow index" "$rendered" || fail "Missing any mention of an Overflow Index in ${rendered#"$tmp_dir/"}"
  grep -qi "file.*type.*covers\|covers.*type.*file" "$rendered" || fail "Overflow Index is mentioned but no actual schema (its columns) is shown in ${rendered#"$tmp_dir/"} — a downstream session has nothing to build the table from"
  grep -qi "superseded" "$rendered" || fail "Missing what happens to a swept superseded decision in ${rendered#"$tmp_dir/"}"
done

# --- Check 5: Minimal correctly opts out of overflow structure -------------
# Minimal has no state folder by design; it should point at scale's own
# promotion threshold instead of inventing overflow files for a tier that
# structurally can't have them.
minimal_rendered="$tmp_dir/project-minimal/AGENTS.md"
grep -qi "overflow/session-notes\|overflow/decisions" "$minimal_rendered" && fail "Minimal's rendered AGENTS.md instructs writing to an overflow/ path — Minimal has no state folder; it should defer to scale's Minimal→Core threshold instead"
grep -qi "scale" "$minimal_rendered" || fail "Minimal's rendered AGENTS.md doesn't point at scale's promotion threshold as its own overflow alternative"

# --- Check 6: remember's self-heal instruction is actually resolvable -----
remember_file="$tmp_dir/skills/remember/SKILL.md"
if grep -q "add it once" "$remember_file"; then
  grep -qi "current template" "$remember_file" && fail "remember's self-heal instruction points at 'the current template', which does not exist in a cold install — it must carry the wording itself"
fi

# --- Check 7: moor's write-shape guidance doesn't imply writing outside
# its own declared single write destination ---------------------------------
moor_file="$tmp_dir/skills/moor/SKILL.md"
if grep -A3 -i "write-shape check applies" "$moor_file" | grep -qi "link"; then
  fail "moor's write-shape guidance instructs creating a link to a second file — moor's Context Contract restricts it to one resolved write destination; this needs explicit delegation language (e.g. hand off to remember), not an instruction to create a link to a file moor has no authority to write"
fi

# --- Check 8: copy-first and link-later discovery preserve one complete kit --
mkdir -p "$tmp_dir/runtime-primary" "$tmp_dir/runtime-linked"
for skill in "${skills[@]}"; do
  cp -R "$repo_root/skills-kit/$skill" "$tmp_dir/runtime-primary/$skill"
  diff -qr "$repo_root/skills-kit/$skill" "$tmp_dir/runtime-primary/$skill" >/dev/null || \
    fail "Primary runtime copy differs from skills-kit/$skill"
  ln -s "$tmp_dir/runtime-primary/$skill" "$tmp_dir/runtime-linked/$skill"
  test -f "$tmp_dir/runtime-linked/$skill/SKILL.md" || \
    fail "Linked runtime cannot discover $skill/SKILL.md through the primary copy"
  test ! -L "$tmp_dir/runtime-primary/$skill" || \
    fail "Primary runtime installation for $skill must be a real directory"
done

echo "Cold-downstream simulation passed: nothing installed cold references what only exists in this repo, and the rendered session-state files carry complete overflow mechanics."
