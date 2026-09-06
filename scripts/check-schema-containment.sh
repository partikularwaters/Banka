#!/usr/bin/env bash
#
# check-schema-containment.sh — enforces the capability-aliasing invariant
# (the SPLIT-STATE capability, protocol/Banka.md §3.1): the schema *number*
# must not leak
# into skill bodies, template bodies, or the protocol's operating sections.
# Those surfaces branch on the derived SPLIT-STATE capability instead; the
# schema number is legitimate only where a project is *detected* (§3.1) or
# *migrated* (§3.2), plus incidental file-count / promotion facts.
#
# This replaces the manual audit loop that kept finding "schema-2/3 residual
# instances": once wired into CI with --enforce, a forgotten branch fails the
# build instead of surviving to the next external audit.
#
# Strict zones (must contain ZERO schema-selector tokens):
#   - skills-kit/*/SKILL.md
#   - full-context-templates/**/*.md
#   - protocol/Banka.md bodies of SECTION 2.9 and SECTION 2.11 (located by
#     heading, so the check survives line drift)
#
# Census (printed, never fails): every other schema-selector occurrence in
# protocol/Banka.md, for a human to confirm it is a detection / migration /
# file-count / promotion use.
#
# Default: report-only, exit 0 (use during the refactor). With --enforce, a
# strict-zone hit exits 1 (use once the refactor is complete, in CI).
#
# Scans only the surfaces above. README.md, system-map.md, docs/, and scripts/
# legitimately discuss the schema and are never scanned — this script's own
# mention of the tokens therefore never self-trips.

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
cd "$repo_root"

enforce=0
case "${1:-}" in
  --enforce) enforce=1 ;;
  -h|--help)
    echo "Usage: check-schema-containment.sh [--enforce]"
    echo "  (default) report-only, exit 0"
    echo "  --enforce  strict-zone violations exit 1"
    exit 0 ;;
  "") ;;
  *) echo "Unknown flag: $1" >&2; exit 1 ;;
esac

protocol="protocol/Banka.md"
# schema-selector vocabulary the strict zones must not use. Case-insensitive.
pattern='schema-2|schema 2|schema-3|schema 3|pre-migration'

strict=()   # "path:line:text" for every strict-zone hit
census=()   # "path:line:text" for legitimate/other protocol mentions

# Append every whole-file match to the named array. `|| true` keeps a
# no-match grep (exit 1 under pipefail) from tripping set -e.
collect_file() {
  local file="$1" __arr="$2" m
  [ -f "$file" ] || return 0
  while IFS= read -r m; do
    eval "$__arr+=(\"\$file:\$m\")"
  done < <(grep -nEi "$pattern" "$file" || true)
}

# Append matches within [start,end) of a file, preserving real line numbers.
collect_range() {
  local file="$1" start="$2" end="$3" __arr="$4" m
  [ -f "$file" ] || return 0
  while IFS= read -r m; do
    eval "$__arr+=(\"\$file:\$m\")"
  done < <(awk -v s="$start" -v e="$end" 'NR>=s && NR<e {print NR": "$0}' "$file" \
             | grep -Ei "$pattern" || true)
}

heading_line() {
  # First line number whose text contains the given literal heading.
  grep -nF "$1" "$protocol" | head -n1 | cut -d: -f1 || true
}

# --- strict zone: skills, EXCEPT each skill's "Resolve Banka state first"
# preamble, which is the skill's local mirror of §3.1 detection and is the one
# place a skill legitimately names a schema (the derivation point for
# SPLIT-STATE). Mentions there go to the census, everything else is strict —
# exactly how §3.1/§3.2 are treated in the protocol.
for f in skills-kit/*/SKILL.md; do
  [ -f "$f" ] || continue
  rs=$(grep -n "^## Resolve Banka state first" "$f" | head -n1 | cut -d: -f1 || true)
  re=""
  if [ -n "$rs" ]; then
    re=$(awk -v s="$rs" 'NR>s && /^## / {print NR; exit}' "$f")
    [ -z "$re" ] && re=$(( $(wc -l < "$f") + 1 ))
  fi
  while IFS= read -r m; do
    ln=${m%%:*}
    if [ -n "$rs" ] && [ "$ln" -ge "$rs" ] && [ "$ln" -lt "$re" ]; then
      census+=("$f:$m  [resolution preamble]")
    else
      strict+=("$f:$m")
    fi
  done < <(grep -nEi "$pattern" "$f" || true)
done

# --- strict zone: templates ---
while IFS= read -r f; do
  collect_file "$f" strict
done < <(find full-context-templates -name '*.md' | sort)

# --- strict zone: protocol operating sections 2.9 and 2.11 ---
s29="" e29="" s211="" e211=""
if [ -f "$protocol" ]; then
  s29=$(heading_line "## SECTION 2.9:")
  e29=$(heading_line "## SECTION 2.10:")
  s211=$(heading_line "## SECTION 2.11:")
  e211=$(heading_line "## SECTION 3:")
  if [ -z "$s29" ] || [ -z "$e29" ] || [ -z "$s211" ] || [ -z "$e211" ]; then
    echo "ERROR: could not locate SECTION 2.9/2.10/2.11/3 headings in $protocol" >&2
    echo "       — the check cannot bound the operating sections." >&2
    exit 2
  fi
  collect_range "$protocol" "$s29" "$e29" strict
  collect_range "$protocol" "$s211" "$e211" strict
fi

# --- census: protocol mentions outside the two strict ranges ---
if [ -f "$protocol" ]; then
  while IFS= read -r m; do
    ln=${m%%:*}
    if { [ "$ln" -ge "$s29" ] && [ "$ln" -lt "$e29" ]; } || \
       { [ "$ln" -ge "$s211" ] && [ "$ln" -lt "$e211" ]; }; then
      continue   # already captured as a strict-zone hit
    fi
    census+=("$protocol:$m")
  done < <(grep -nEi "$pattern" "$protocol" || true)
fi

echo "== Strict zones (must be empty) =="
if [ "${#strict[@]}" -eq 0 ]; then
  echo "  (none)"
else
  printf '  %s\n' "${strict[@]}"
fi

echo
echo "== Census: legitimate schema mentions (review, never fails) =="
echo "   expected: §3.1 detection, §3.2 migration, file-count/promotion facts,"
echo "   and each skill's 'Resolve Banka state first' preamble"
if [ "${#census[@]}" -eq 0 ]; then
  echo "  (none)"
else
  printf '  %s\n' "${census[@]}"
fi

echo
echo "-----------------------------------------------------------------------"
echo "Strict-zone schema-selector tokens: ${#strict[@]} (target: 0)"
echo "Census (informational):             ${#census[@]}"
if [ "${#strict[@]}" -gt 0 ]; then
  if [ "$enforce" -eq 1 ]; then
    echo >&2
    echo "FAIL: schema selectors present in a strict zone. Branch on SPLIT-STATE" >&2
    echo "      instead (SPLIT-STATE, protocol/Banka.md §3.1), or move the" >&2
    echo "      mention into §3.1 detection / §3.2 migration." >&2
    exit 1
  fi
  echo "(report-only; re-run with --enforce to fail on these)"
fi
exit 0
