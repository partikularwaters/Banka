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
