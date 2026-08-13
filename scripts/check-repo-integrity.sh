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
  discovery_link="$repo_root/.agents/skills/$skill"

  test -f "$source_dir/SKILL.md" || fail "Missing skills-kit/$skill/SKILL.md"
  test -L "$discovery_link" || fail ".agents/skills/$skill is missing or is not a symlink"
  test -f "$discovery_link/SKILL.md" || fail ".agents/skills/$skill does not resolve to a SKILL.md"

  declared_name=$(sed -n 's/^name: //p' "$source_dir/SKILL.md" | head -n 1)
  test "$declared_name" = "$skill" || fail "skills-kit/$skill declares name: $declared_name"

  resolved_source=$(cd "$source_dir" && pwd -P)
  resolved_link=$(cd "$discovery_link" && pwd -P)
  test "$resolved_link" = "$resolved_source" || fail ".agents/skills/$skill does not point to skills-kit/$skill"
done

start_count=$(grep -c '<!-- BANKA:START -->' "$repo_root/protocol/Banka.md")
end_count=$(grep -c '<!-- BANKA:END -->' "$repo_root/protocol/Banka.md")
test "$start_count" -eq 3 || fail "Expected 3 BANKA:START markers in protocol/Banka.md, found $start_count"
test "$end_count" -eq 3 || fail "Expected 3 BANKA:END markers in protocol/Banka.md, found $end_count"

if rg -n 'SINGLE-FILE OUTPUT|neither exists\s+→ Minimal|`memory\.md`' \
  "$repo_root/README.md" "$repo_root/system-map.md" "$repo_root/protocol" \
  "$repo_root/skills-kit" "$repo_root/full-context-templates" >/dev/null; then
  fail "Found an obsolete tier or memory-path phrase"
fi

echo "Banka repository integrity check passed."
