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

  context_contract_count=$(grep -Fxc '## Context Contract' "$source_dir/SKILL.md" || true)
  test "$context_contract_count" -eq 1 || fail "Expected exactly one '## Context Contract' heading in skills-kit/$skill/SKILL.md, found $context_contract_count"
done

skill_file_count=$(find "$repo_root/skills-kit" -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
test "$skill_file_count" -eq "${#skills[@]}" || fail "Expected ${#skills[@]} skills-kit/*/SKILL.md files, found $skill_file_count"

start_count=$(grep -c '<!-- BANKA:START -->' "$repo_root/protocol/Banka.md")
end_count=$(grep -c '<!-- BANKA:END -->' "$repo_root/protocol/Banka.md")
test "$start_count" -eq 4 || fail "Expected 4 BANKA:START markers in protocol/Banka.md, found $start_count"
test "$end_count" -eq 4 || fail "Expected 4 BANKA:END markers in protocol/Banka.md, found $end_count"

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

project_entry_dir="$repo_root/full-context-templates/project-entry"
project_entry_templates=(minimal-AGENTS.md core-AGENTS.md standard-AGENTS.md CLAUDE.md)
state_resolver_skills=(charter delegate linis moor remember scale survey watershed)

require_literal() {
  local literal=$1
  local file=$2

  grep -Fq "$literal" "$file" || fail "Missing $literal in ${file#$repo_root/}"
}

exact_line_count() {
  local literal=$1
  local file=$2

  grep -Fxc "$literal" "$file" || true
}

extract_protocol_tier_block() {
  local tier=$1
  local occurrence=$2

  awk -v marker="<!-- BANKA:TIER: $tier -->" -v wanted="$occurrence" '
    $0 == marker {
      seen++
      if (seen == wanted) {
        print previous_two
        print previous_one
        print
        capture = 1
        next
      }
    }
    capture {
      print
      if ($0 == "<!-- BANKA:END -->") exit
      next
    }
    { previous_two = previous_one; previous_one = $0 }
  ' "$repo_root/protocol/Banka.md"
}

extract_handoff_block() {
  awk '
    $0 == "Work in [exact project path]." { capture = 1 }
    capture && $0 == "```" { exit }
    capture { print }
  ' "$1"
}

extract_batch_handoff_block() {
  awk '
    $0 == "Work in [exact project path]." { n++; if (n == 2) { capture = 1; print; next } }
    capture && $0 == "```" { exit }
    capture { print }
  ' "$1"
}

release_version=$(cat "$repo_root/VERSION")
test "$(wc -l < "$repo_root/VERSION" | tr -d ' ')" -eq 1 || \
  fail "VERSION must contain exactly one line"
printf '%s\n' "$release_version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' || \
  fail "VERSION must contain a semantic release version"
test "$(exact_line_count "# Banka $release_version" "$repo_root/protocol/Banka.md")" -eq 1 || \
  fail "protocol/Banka.md must have one exact Banka $release_version title"
require_literal "Banka $release_version" "$repo_root/README.md"
require_literal "## $release_version" "$repo_root/CHANGELOG.md"
require_literal 'project-entry/' "$repo_root/README.md"
require_literal '### Updating an existing Banka-managed project' "$repo_root/protocol/Banka.md"
require_literal '## Updating Banka' "$repo_root/README.md"
require_literal 'protocol/Banka.md#updating-an-existing-banka-managed-project' "$repo_root/README.md"
require_literal 'protocol/Banka.md#updating-an-existing-banka-managed-project' "$repo_root/BANKA-ADOPTION-GUIDE.md"
require_literal 'Existing-project release update' "$repo_root/system-map.md"

stable_tag_instruction_count=$(grep -Fc 'newest annotated stable' "$repo_root/README.md" || true)
test "$stable_tag_instruction_count" -eq 4 || \
  fail "Expected stable-release selection in all four README prompts, found $stable_tag_instruction_count"
semver_order_count=$(grep -Fc 'semantic-version order' "$repo_root/README.md" || true)
test "$semver_order_count" -eq 4 || \
  fail "Expected semantic-version ordering in all four README prompts, found $semver_order_count"
unreleased_branch_warning_count=$(grep -Fic 'unreleased commits' "$repo_root/README.md" || true)
test "$unreleased_branch_warning_count" -eq 4 || \
  fail "Expected the unreleased-branch warning in all four README prompts, found $unreleased_branch_warning_count"
missing_tag_stop_count=$(grep -Fic 'If no valid stable tag exists' "$repo_root/README.md" || true)
test "$missing_tag_stop_count" -eq 4 || \
  fail "Expected the missing-tag stop condition in all four README prompts, found $missing_tag_stop_count"

if rg -n -U 'temporary directory,\nthen install its Skills Kit for the current user: link' "$repo_root/README.md" >/dev/null; then
  fail "Codex installation must never symlink Banka skills from a temporary checkout"
fi
require_literal 'never link to a temporary directory' "$repo_root/README.md"

integrity_tmp_dir=$(mktemp -d)
trap 'rm -rf "$integrity_tmp_dir"' EXIT

for template in "${project_entry_templates[@]}"; do
  test -f "$project_entry_dir/$template" || fail "Missing canonical project-entry template: $template"
done

project_entry_file_count=$(find "$project_entry_dir" -mindepth 1 -maxdepth 1 -type f | wc -l | tr -d ' ')
test "$project_entry_file_count" -eq "${#project_entry_templates[@]}" || \
  fail "Expected ${#project_entry_templates[@]} canonical project-entry templates, found $project_entry_file_count"

for tier in Minimal Core Standard; do
  case "$tier" in
    Minimal)
      template="$project_entry_dir/minimal-AGENTS.md"
      protocol_occurrence=2
      ;;
    Core)
      template="$project_entry_dir/core-AGENTS.md"
      protocol_occurrence=1
      ;;
    Standard)
      template="$project_entry_dir/standard-AGENTS.md"
      protocol_occurrence=1
      ;;
  esac

  test "$(exact_line_count '<!-- BANKA:START -->' "$template")" -eq 1 || \
    fail "Expected one exact BANKA:START marker in ${template#$repo_root/}"
  test "$(exact_line_count '<!-- BANKA:STATE-SCHEMA: 2 -->' "$template")" -eq 1 || \
    fail "Expected one exact schema-2 marker in ${template#$repo_root/}"
  test "$(exact_line_count "<!-- BANKA:TIER: $tier -->" "$template")" -eq 1 || \
    fail "Expected one exact $tier tier declaration in ${template#$repo_root/}"
  test "$(exact_line_count '<!-- BANKA:END -->' "$template")" -eq 1 || \
    fail "Expected one exact BANKA:END marker in ${template#$repo_root/}"
  protocol_block_file="$integrity_tmp_dir/protocol-$tier.md"
  extract_protocol_tier_block "$tier" "$protocol_occurrence" > "$protocol_block_file"
  cmp -s "$protocol_block_file" "$template" || \
    fail "Protocol $tier block differs from ${template#$repo_root/}"
done

schema_marker_count=$(grep -Fh 'BANKA:STATE-SCHEMA' "$project_entry_dir"/*-AGENTS.md | wc -l | tr -d ' ')
test "$schema_marker_count" -eq 3 || fail "Expected exactly 3 schema markers across canonical AGENTS templates, found $schema_marker_count"
tier_declaration_count=$(grep -Fh 'BANKA:TIER:' "$project_entry_dir"/*-AGENTS.md | wc -l | tr -d ' ')
test "$tier_declaration_count" -eq 3 || fail "Expected exactly 3 tier declarations across canonical AGENTS templates, found $tier_declaration_count"

expected_claude_shim='@AGENTS.md'
actual_claude_shim=$(cat "$project_entry_dir/CLAUDE.md")
test "$actual_claude_shim" = "$expected_claude_shim" || \
  fail "project-entry/CLAUDE.md must contain exactly @AGENTS.md"
test "$(wc -l < "$project_entry_dir/CLAUDE.md" | tr -d ' ')" -eq 1 || \
  fail "project-entry/CLAUDE.md must be a one-line Claude compatibility shim"

require_literal '## Source of truth' "$project_entry_dir/core-AGENTS.md"
require_literal '## Source of truth' "$project_entry_dir/standard-AGENTS.md"
require_literal 'Banka-owned schema-2 block in `AGENTS.md`' "$repo_root/full-context-templates/standard/code-standards.md"

if rg -n -i '@CLAUDE\.md|AGENTS\.md[^\n]*(points? to|imports?)[^\n]*CLAUDE\.md|CLAUDE\.md[^\n]*(canonical|current|primary)[^\n]*(authority|source of truth|state)' \
  "$repo_root/README.md" "$repo_root/BANKA-ADOPTION-GUIDE.md" "$repo_root/system-map.md" \
  "$repo_root/protocol" "$repo_root/skills-kit" "$repo_root/full-context-templates" "$repo_root/scripts" >/dev/null; then
  fail "Found obsolete CLAUDE-authority claim; CLAUDE.md may only be a compatibility shim or legacy read-only state"
fi

shared_state_file="$repo_root/skills-kit/_shared/banka-state-resolution.md"
test -f "$shared_state_file" || fail "Missing skills-kit/_shared/banka-state-resolution.md"

require_literal '<!-- BANKA:START -->' "$shared_state_file"
require_literal '<!-- BANKA:STATE-SCHEMA: 2 -->' "$shared_state_file"
require_literal '<!-- BANKA:TIER: Minimal -->' "$shared_state_file"
require_literal '<!-- BANKA:TIER: Core -->' "$shared_state_file"
require_literal '<!-- BANKA:TIER: Standard -->' "$shared_state_file"
require_literal '<!-- BANKA:END -->' "$shared_state_file"
require_literal 'exactly once' "$shared_state_file"
require_literal '@AGENTS.md' "$shared_state_file"
require_literal 'compatibility-read-only' "$shared_state_file"
require_literal '/core/' "$shared_state_file"
require_literal '/context/' "$shared_state_file"
require_literal 'unstructured/non-Banka' "$shared_state_file"
for required_tier_file in overview.md architecture.md design.md progress.md \
  session-notes.md decisions-index.md \
  project-overview.md build-plan.md code-standards.md library-docs.md \
  ui-tokens.md ui-rules.md ui-registry.md progress-tracker.md; do
  require_literal "$required_tier_file" "$shared_state_file"
done

# Every state-resolver skill must carry an identical, byte-for-byte pointer
# to the shared file — checked the same way Section 2.8 already checks the
# tier blocks against project-entry/*-AGENTS.md (extract, then cmp -s).
extract_pointer_block() {
  awk '
    /^## Resolve Banka state first$/ { print; n=5; next }
    n>0 { print; n--; next }
  ' "$1"
}

pointer_reference_file="$integrity_tmp_dir/pointer-reference.md"
extract_pointer_block "$repo_root/skills-kit/charter/SKILL.md" > "$pointer_reference_file"
grep -q '^Read `\.\./_shared/banka-state-resolution\.md`' "$pointer_reference_file" || \
  fail "charter/SKILL.md's pointer block doesn't start as expected — extraction may be broken"

for skill in "${state_resolver_skills[@]}"; do
  skill_file="$repo_root/skills-kit/$skill/SKILL.md"
  require_literal '## Resolve Banka state first' "$skill_file"
  pointer_block_file="$integrity_tmp_dir/pointer-$skill.md"
  extract_pointer_block "$skill_file" > "$pointer_block_file"
  cmp -s "$pointer_reference_file" "$pointer_block_file" || \
    fail "skills-kit/$skill/SKILL.md's pointer to _shared/banka-state-resolution.md isn't byte-identical to the others"
done

# dredge doesn't get its own heading — it points to the shared file only
# conditionally, from its Context Contract's Conditional line.
require_literal '../_shared/banka-state-resolution.md' "$repo_root/skills-kit/dredge/SKILL.md"

for handoff_file in "$repo_root/skills-kit/delegate/SKILL.md" "$repo_root/full-context-templates/delegation-queue.md"; do
  grep -Fiq 'ready-to-paste' "$handoff_file" || fail "Missing ready-to-paste handoff requirement in ${handoff_file#$repo_root/}"
  require_literal 'Work in [exact project path].' "$handoff_file"
  require_literal 'You are executing Ticket [N]' "$handoff_file"
  require_literal '[exact queue path]' "$handoff_file"
  require_literal 'required capability' "$handoff_file"
  require_literal 'Dependency state:' "$handoff_file"
  require_literal 'Files to touch:' "$handoff_file"
  require_literal 'Files not to touch:' "$handoff_file"
  require_literal 'Do not:' "$handoff_file"
  require_literal 'accepted dirty baseline' "$handoff_file"
  require_literal 'coordinator session hands ownership' "$handoff_file"
  require_literal 'Dirty files, one worktree, absence of .git/index.lock, and' "$handoff_file"
  require_literal 'Stop only for unexplained' "$handoff_file"
  require_literal 'dependency order' "$handoff_file"
  require_literal 'For one ready ticket' "$handoff_file"
  require_literal 'For zero' "$handoff_file"
  require_literal 'batch of tickets from the delegation queue' "$handoff_file"
  require_literal 'Tickets in this batch, in order' "$handoff_file"
  require_literal 'Self-check it against its own Done when condition' "$handoff_file"
  require_literal 'STOP the batch at this ticket' "$handoff_file"
  require_literal 'not a failure of the process' "$handoff_file"
done

delegate_handoff_file="$integrity_tmp_dir/delegate-handoff.txt"
template_handoff_file="$integrity_tmp_dir/template-handoff.txt"
extract_handoff_block "$repo_root/skills-kit/delegate/SKILL.md" > "$delegate_handoff_file"
extract_handoff_block "$repo_root/full-context-templates/delegation-queue.md" > "$template_handoff_file"
cmp -s "$delegate_handoff_file" "$template_handoff_file" || \
  fail "Delegate and delegation-queue ready-to-paste handoff blocks differ"

delegate_batch_handoff_file="$integrity_tmp_dir/delegate-batch-handoff.txt"
template_batch_handoff_file="$integrity_tmp_dir/template-batch-handoff.txt"
extract_batch_handoff_block "$repo_root/skills-kit/delegate/SKILL.md" > "$delegate_batch_handoff_file"
extract_batch_handoff_block "$repo_root/full-context-templates/delegation-queue.md" > "$template_batch_handoff_file"
cmp -s "$delegate_batch_handoff_file" "$template_batch_handoff_file" || \
  fail "Delegate and delegation-queue batch handoff blocks differ"

user_skills_dir="$HOME/.agents/skills"
if test -d "$user_skills_dir"; then
  for skill in "${skills[@]}" "_shared"; do
    installed_skill="$user_skills_dir/$skill"
    if test -e "$installed_skill" || test -L "$installed_skill"; then
      canonical_target=$(cd "$repo_root/skills-kit/$skill" && pwd -P)
      if test -L "$installed_skill"; then
        installed_target=$(cd "$installed_skill" && pwd -P) || fail "$installed_skill does not resolve"
        test "$installed_target" = "$canonical_target" || \
          fail "$installed_skill resolves outside skills-kit/$skill"
        echo "Verified installed Banka skill link: $installed_skill"
      else
        test -d "$installed_skill" || fail "$installed_skill is neither a skill directory nor a symlink"
        diff -qr "$canonical_target" "$installed_skill" >/dev/null || \
          fail "$installed_skill is not an exact copy of skills-kit/$skill"
        echo "Verified installed Banka skill copy: $installed_skill"
      fi
    else
      echo "Installed Banka skill link not present (repository package remains valid): $installed_skill"
    fi
  done
fi

echo "Banka repository integrity check passed."
