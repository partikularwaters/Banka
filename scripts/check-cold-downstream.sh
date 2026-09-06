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
skills=(charter delegate dredge linis moor remember scale survey watershed verify)

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

# --- Build the cold-downstream simulation ---------------------------------
# Skills as they exist once installed standalone (~/.claude/skills/<name>/SKILL.md
# or ~/.agents/skills/<name>/SKILL.md) — nothing else from this repo is
# present. A shared sibling file was tried and reverted (measured to cost
# more per invocation than the duplication it removed); each skill is fully
# self-contained again, and this simulation reflects that.
mkdir -p "$tmp_dir/skills"
for skill in "${skills[@]}"; do
  mkdir -p "$tmp_dir/skills/$skill"
  cp "$repo_root/skills-kit/$skill/SKILL.md" "$tmp_dir/skills/$skill/SKILL.md"
done

# Rendered tier output, as a generated project actually receives it —
# copying the templates' *content* into project-shaped paths, never the
# full-context-templates/ directory itself.
mkdir -p "$tmp_dir/project-minimal" "$tmp_dir/project-core/core" "$tmp_dir/project-standard/context" "$tmp_dir/project-core/scripts" "$tmp_dir/project-standard/scripts"
cp "$repo_root/full-context-templates/project-entry/minimal-AGENTS.md" "$tmp_dir/project-minimal/AGENTS.md"
cp "$repo_root/full-context-templates/core/"*.md "$tmp_dir/project-core/core/"
cp "$repo_root/full-context-templates/standard/"*.md "$tmp_dir/project-standard/context/"
cp "$repo_root/full-context-templates/delegation-queue.md" "$tmp_dir/project-core/delegation-queue.md"
cp "$repo_root/full-context-templates/delegation-queue.md" "$tmp_dir/project-standard/context/delegation-queue.md"
cp "$repo_root/full-context-templates/scripts/check-banka-thresholds.sh" "$tmp_dir/project-core/scripts/check-banka-thresholds.sh"
cp "$repo_root/full-context-templates/scripts/check-banka-thresholds.sh" "$tmp_dir/project-standard/scripts/check-banka-thresholds.sh"
cp "$repo_root/full-context-templates/scripts/verify-claims.sh" "$tmp_dir/project-core/scripts/verify-claims.sh"
cp "$repo_root/full-context-templates/scripts/verify-claims.sh" "$tmp_dir/project-standard/scripts/verify-claims.sh"

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
)
for pattern in "${banned_patterns[@]}"; do
  if grep -rl -- "$pattern" "$tmp_dir/skills" >/dev/null 2>&1; then
    fail "Found unresolvable downstream reference pattern in an installed skill: '$pattern'"
  fi
done

# --- Check 3: no protocol-internal jargon in installed skills --------------
# "Track A"/"Track B" mean nothing without protocol/Banka.md open. A skill
# must describe its own behavior directly, never by naming an undefined
# internal label.
if grep -rl -E "Track A|Track B" "$tmp_dir/skills" >/dev/null 2>&1; then
  fail "Found 'Track A'/'Track B' protocol-internal jargon inside an installed skill file"
fi

# --- Check 3a: every state-resolver skill is fully self-contained in the
# cold install — no ../_shared/ reference to anything that doesn't travel
# with it, and real classification content present, not just a heading.
state_resolver_skills_downstream=(charter delegate linis moor remember scale survey watershed verify)
if grep -rl '_shared' "$tmp_dir/skills" >/dev/null 2>&1; then
  fail "A cold-installed skill still references _shared/ — that directory no longer exists"
fi
for skill in "${state_resolver_skills_downstream[@]}"; do
  skill_file="$tmp_dir/skills/$skill/SKILL.md"
  grep -q '^## Resolve Banka state first$' "$skill_file" || \
    fail "$skill/SKILL.md has no '## Resolve Banka state first' heading in the cold install"
  grep -q '^Before reading or writing project state' "$skill_file" || \
    fail "$skill/SKILL.md's classification block is missing or malformed in the cold install"
done

# --- Check 4: Core/Standard's rendered task-tracking file (progress.md /
# progress-tracker.md) carries only rollup rows for the two files it split
# out, not the overflow mechanics themselves ---------------------------------
for rendered in "$tmp_dir/project-standard/context/progress-tracker.md" "$tmp_dir/project-core/core/progress.md"; do
  grep -q '\](session-notes.md)' "$rendered" || fail "Missing a rollup link to session-notes.md in ${rendered#"$tmp_dir/"}"
  grep -q '\](decisions-index.md)' "$rendered" || fail "Missing a rollup link to decisions-index.md in ${rendered#"$tmp_dir/"}"
  grep -qi "check-banka-thresholds.sh" "$rendered" || fail "Missing a reference to the mechanical threshold script in ${rendered#"$tmp_dir/"}"
  grep -qi "## Threshold Check" "$rendered" || fail "Missing the Threshold Check block in ${rendered#"$tmp_dir/"}"
  grep -qi "completed archive index" "$rendered" || fail "Missing the Completed Archive Index in ${rendered#"$tmp_dir/"}"
  grep -qi "phase.*file.*covers\|covers.*file.*phase" "$rendered" || fail "Completed Archive Index is mentioned but no actual schema (its columns) is shown in ${rendered#"$tmp_dir/"} — a downstream session has nothing to build the table from"
  grep -q '\](overflow/completed/' "$rendered" || fail "Completed Archive Index example row isn't a real link in ${rendered#"$tmp_dir/"}"
  grep -qi "running total\|completed so far" "$rendered" || fail "Missing the running-total line for Completed in ${rendered#"$tmp_dir/"}"
  grep -qi "current phase" "$rendered" || fail "Missing the phase-boundary archive trigger for Completed in ${rendered#"$tmp_dir/"}"
done

# --- Check 4a: Core/Standard's rendered session-notes.md carries the full
# overflow mechanics for the thread-tagged narrative -------------------------
for rendered in "$tmp_dir/project-standard/context/session-notes.md" "$tmp_dir/project-core/core/session-notes.md"; do
  grep -qi "sequentially\|01-" "$rendered" || fail "Missing the sequential-numbering convention for overflow files in ${rendered#"$tmp_dir/"}"
  grep -qi "contents" "$rendered" || fail "Missing the overflow file's own Contents-header requirement in ${rendered#"$tmp_dir/"}"
  grep -qi "overflow index" "$rendered" || fail "Missing any mention of an Overflow Index in ${rendered#"$tmp_dir/"}"
  grep -qi "file.*type.*covers\|covers.*type.*file" "$rendered" || fail "Overflow Index is mentioned but no actual schema (its columns) is shown in ${rendered#"$tmp_dir/"} — a downstream session has nothing to build the table from"
  grep -q '\](overflow/session-notes/' "$rendered" || fail "Overflow Index example row isn't a real link in ${rendered#"$tmp_dir/"}"
  grep -qi "settled" "$rendered" || fail "Missing the immediate-split-on-settled-boundary rule in ${rendered#"$tmp_dir/"}"
  grep -qi "check-banka-thresholds.sh" "$rendered" || fail "Missing a reference to the mechanical threshold script in ${rendered#"$tmp_dir/"}"
  grep -qi "## Threshold Check" "$rendered" || fail "Missing the Threshold Check block in ${rendered#"$tmp_dir/"}"
done

# --- Check 4d: Core/Standard's rendered decisions-index.md carries the
# Logbook routing mechanics ---------------------------------------------------
for rendered in "$tmp_dir/project-standard/context/decisions-index.md" "$tmp_dir/project-core/core/decisions-index.md"; do
  grep -qi "superseded" "$rendered" || fail "Missing what happens to a swept superseded decision in ${rendered#"$tmp_dir/"}"
  grep -qi "decisions index" "$rendered" || fail "Missing the Decisions Index (Logbook routing table) in ${rendered#"$tmp_dir/"}"
  grep -qi "decisions/" "$rendered" || fail "Missing a reference to the Logbook's decisions/ folder in ${rendered#"$tmp_dir/"}"
  grep -q '\](decisions/' "$rendered" || fail "Decisions Index example row isn't a real link in ${rendered#"$tmp_dir/"}"
  grep -qi "check-banka-thresholds.sh" "$rendered" || fail "Missing a reference to the mechanical threshold script in ${rendered#"$tmp_dir/"}"
  grep -qi "## Threshold Check" "$rendered" || fail "Missing the Threshold Check block in ${rendered#"$tmp_dir/"}"
done

# --- Check 4f: Core/Standard's rendered verified-index.md carries the
# verify record mechanics -----------------------------------------------------
for rendered in "$tmp_dir/project-standard/context/verified-index.md" "$tmp_dir/project-core/core/verified-index.md"; do
  grep -qi "verified index" "$rendered" || fail "Missing the Verified Index table in ${rendered#"$tmp_dir/"}"
  grep -qi "ticket/plan\|ticket.*plan" "$rendered" || fail "Missing the ticket/plan citation column in ${rendered#"$tmp_dir/"}"
  grep -qi "commit" "$rendered" || fail "Missing the commit column in ${rendered#"$tmp_dir/"}"
  grep -qi "verify-claims.sh" "$rendered" || fail "Missing a reference to the mechanical reconciliation script in ${rendered#"$tmp_dir/"}"
  grep -qi "## Threshold Check" "$rendered" || fail "Missing the Threshold Check block in ${rendered#"$tmp_dir/"}"
done

# --- Check 4c: the mechanical threshold script itself renders and looks like
# a real script, not just referenced in prose --------------------------------
for script in "$tmp_dir/project-core/scripts/check-banka-thresholds.sh" "$tmp_dir/project-standard/scripts/check-banka-thresholds.sh"; do
  test -f "$script" || fail "Missing rendered check-banka-thresholds.sh at ${script#"$tmp_dir/"}"
  head -1 "$script" | grep -q '^#!' || fail "check-banka-thresholds.sh has no shebang line at ${script#"$tmp_dir/"}"
  grep -q "Threshold Check" "$script" || fail "check-banka-thresholds.sh doesn't emit the Threshold Check heading at ${script#"$tmp_dir/"}"
done

# --- Check 4g: verify-claims.sh renders and actually executes correctly
# against a real git repo, mechanically — file/diff/run checks, not prose ----
for project_dir in "$tmp_dir/project-core" "$tmp_dir/project-standard"; do
  script="$project_dir/scripts/verify-claims.sh"
  test -f "$script" || fail "Missing rendered verify-claims.sh at ${script#"$tmp_dir/"}"
  head -1 "$script" | grep -q '^#!' || fail "verify-claims.sh has no shebang line at ${script#"$tmp_dir/"}"
  ( cd "$project_dir" && git init -q && git add -A && git commit -qm init )
  echo "changed" >> "$project_dir/verify-claims-probe.md"
  output=$(cd "$project_dir" && bash scripts/verify-claims.sh \
    --check-file verify-claims-probe.md \
    --check-file does-not-exist.md \
    --check-diff verify-claims-probe.md \
    --run-test "true" \
    --run-test "false") || fail "verify-claims.sh failed to execute cleanly in ${project_dir#"$tmp_dir/"}"
  echo "$output" | grep -q '| MET |' || fail "verify-claims.sh never reported a real MET in ${project_dir#"$tmp_dir/"}"
  echo "$output" | grep -q '| MISSING |' || fail "verify-claims.sh never reported a real MISSING in ${project_dir#"$tmp_dir/"}"
  rm -f "$project_dir/verify-claims-probe.md"
done

# --- Check 4e: the threshold script actually executes cleanly against a
# rendered project and mechanically computes the Completed running total —
# not just referenced in prose, actually run ----------------------------------
for project_dir in "$tmp_dir/project-core" "$tmp_dir/project-standard"; do
  output=$(cd "$project_dir" && bash scripts/check-banka-thresholds.sh) || \
    fail "check-banka-thresholds.sh failed to execute cleanly in ${project_dir#"$tmp_dir/"}"
  echo "$output" | grep -qi "completed so far" || \
    fail "check-banka-thresholds.sh's real output has no Completed running-total line in ${project_dir#"$tmp_dir/"}"
  echo "$output" | grep -qE '[0-9]+ (tasks|actions)' || \
    fail "check-banka-thresholds.sh's running-total line has no actual computed number in ${project_dir#"$tmp_dir/"}"
done

# --- Check 4b: rendered delegation-queue.md carries complete overflow
# mechanics too, same standard as Check 4's session-state files ------------
for rendered in "$tmp_dir/project-core/delegation-queue.md" "$tmp_dir/project-standard/context/delegation-queue.md"; do
  grep -qi "sequentially\|01-" "$rendered" || fail "Missing the sequential-numbering convention for overflow files in ${rendered#"$tmp_dir/"}"
  grep -qi "contents" "$rendered" || fail "Missing the overflow file's own Contents-header requirement in ${rendered#"$tmp_dir/"}"
  grep -qi "overflow index" "$rendered" || fail "Missing any mention of an Overflow Index in ${rendered#"$tmp_dir/"}"
  grep -qi "file.*type.*covers\|covers.*type.*file" "$rendered" || fail "Overflow Index is mentioned but no actual schema (its columns) is shown in ${rendered#"$tmp_dir/"} — a downstream session has nothing to build the table from"
  grep -qi "delegation-tickets" "$rendered" || fail "Missing the overflow/delegation-tickets/ destination in ${rendered#"$tmp_dir/"}"
  grep -qi "never archive live work\|unstarted or in-progress ticket" "$rendered" || fail "Missing the rule that unstarted/in-progress tickets are never archived in ${rendered#"$tmp_dir/"}"
  grep -q '\](overflow/delegation-tickets/' "$rendered" || fail "Overflow Index example row isn't a real link in ${rendered#"$tmp_dir/"}"
  grep -qi "check-banka-thresholds.sh" "$rendered" || fail "Missing a reference to the mechanical threshold script in ${rendered#"$tmp_dir/"}"
done

# --- Check 5: Minimal correctly opts out of overflow structure -------------
# Minimal has no state folder by design; it should point at scale's own
# promotion threshold instead of inventing overflow files for a tier that
# structurally can't have them.
minimal_rendered="$tmp_dir/project-minimal/AGENTS.md"
grep -qi "overflow/session-notes\|overflow/decisions" "$minimal_rendered" && fail "Minimal's rendered AGENTS.md instructs writing to an overflow/ path — Minimal has no state folder; it should defer to scale's Minimal→Core threshold instead"
grep -qi "scale" "$minimal_rendered" || fail "Minimal's rendered AGENTS.md doesn't point at scale's promotion threshold as its own overflow alternative"
grep -qi "check-banka-thresholds.sh" "$minimal_rendered" && fail "Minimal's rendered AGENTS.md references the mechanical threshold script — Minimal is explicitly excluded from it"

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

# The queue has a per-file report destination, including cold installs.
grep -q '^## Threshold Check$' "$repo_root/full-context-templates/delegation-queue.md" || fail "Queue lacks its Threshold Check block"

echo "Cold-downstream simulation passed: nothing installed cold references what only exists in this repo, and the rendered session-state files carry complete overflow mechanics."
