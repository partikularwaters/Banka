#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
skills=(charter delegate dredge linis moor remember scale survey watershed)

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

for skill in "${skills[@]}"; do
  source_dir="$repo_root/skills-kit/$skill"
  repo_local_skill="$repo_root/.agents/skills/$skill"

  test -f "$source_dir/SKILL.md" || fail "Missing skills-kit/$skill/SKILL.md"
  if test -e "$repo_local_skill" || test -L "$repo_local_skill"; then
    fail ".agents/skills/$skill duplicates a user-level Banka skill"
  fi

  declared_name=$(sed -n 's/^name: //p' "$source_dir/SKILL.md" | head -n 1)
  test "$declared_name" = "$skill" || fail "skills-kit/$skill declares name: $declared_name"
done

skill_file_count=$(find "$repo_root/skills-kit" -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
test "$skill_file_count" -eq "${#skills[@]}" || fail "Expected ${#skills[@]} skills-kit/*/SKILL.md files, found $skill_file_count"

start_count=$(grep -c '<!-- BANKA:START -->' "$repo_root/protocol/Banka.md")
end_count=$(grep -c '<!-- BANKA:END -->' "$repo_root/protocol/Banka.md")
test "$start_count" -eq 3 || fail "Expected 3 BANKA:START markers in protocol/Banka.md, found $start_count"
test "$end_count" -eq 3 || fail "Expected 3 BANKA:END markers in protocol/Banka.md, found $end_count"

section_7_1_count=$(grep -c '^## SECTION 7\.1: OPERATIONAL PERSPECTIVES$' "$repo_root/protocol/Banka.md")
test "$section_7_1_count" -eq 1 || fail "Expected exactly one SECTION 7.1 operational perspectives heading in protocol/Banka.md, found $section_7_1_count"

if grep -Eiw 'persona|personas' "$repo_root/skills-kit/watershed/SKILL.md" >/dev/null; then
  fail "Found obsolete persona terminology in skills-kit/watershed/SKILL.md"
fi

for label in 'Outcome Owner' 'User' 'Builder' 'Maintainer' 'Risk Owner'; do
  grep -Fq "$label" "$repo_root/skills-kit/watershed/SKILL.md" || fail "Missing $label in skills-kit/watershed/SKILL.md"
done

if rg -n 'SINGLE-FILE OUTPUT|neither exists\s+→ Minimal|`memory\.md`' \
  "$repo_root/README.md" "$repo_root/system-map.md" "$repo_root/protocol" \
  "$repo_root/skills-kit" "$repo_root/full-context-templates" >/dev/null; then
  fail "Found an obsolete tier or memory-path phrase"
fi

echo "Banka repository integrity check passed."
