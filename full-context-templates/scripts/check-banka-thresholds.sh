#!/usr/bin/env bash
#
# check-banka-thresholds.sh — mechanical word-count check for Banka's
# threshold-bearing sections (Protocol Section 2.9).
#
# Runs independent of any AI session: invoke it directly from a terminal,
# or wire it into a git hook. remember, delegate, and linis also call it at
# their own points, but none of them are required for it to work.
#
# Never applies a fix, never archives anything — reports word counts
# against the documented provisional thresholds and stops. What to do
# about an OVER row is a decision for whichever skill reads the report.

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

THRESHOLD=2000
TICKET_THRESHOLD=2000

section_text() {
  # The text between "## $1" and the next "## " heading (or EOF).
  awk -v heading="## $1" '
    $0 == heading { flag=1; next }
    /^## / { if (flag) exit }
    flag { print }
  ' "$2" 2>/dev/null
}

section_words() {
  section_text "$1" "$2" | wc -w | tr -d ' '
}

row() {
  local label="$1" count="$2" threshold="$3" status="OK"
  if [ "${count:-0}" -ge "$threshold" ]; then status="OVER — action needed"; fi
  printf '| %s | %s | ~%s | %s |\n' "$label" "${count:-0}" "$threshold" "$status"
}

# Completed running total: a mechanical count of checked "- [x]" items, never
# a self-estimate — the live section's own checked items plus everything
# already archived to overflow/completed/. Printed as a standalone line, not
# a Threshold Check row, since it's a count of tasks, not words, and isn't a
# threshold gate.
completed_state_file=""
completed_heading=""
if [ -f "context/progress-tracker.md" ]; then
  completed_state_file="context/progress-tracker.md"
  completed_heading="Completed"
elif [ -f "core/progress.md" ]; then
  completed_state_file="core/progress.md"
  completed_heading="Completed Actions"
fi

if [ -n "$completed_state_file" ]; then
  live_count=$(section_text "$completed_heading" "$completed_state_file" | grep -c '^- \[x\]' || true)
  archived_count=0
  archived_files=0
  for overflow_dir in context/overflow/completed core/overflow/completed; do
    [ -d "$overflow_dir" ] || continue
    while IFS= read -r file; do
      [ -n "$file" ] || continue
      c=$(grep -c '^- \[x\]' "$file" || true)
      archived_count=$((archived_count + c))
      archived_files=$((archived_files + 1))
    done < <(find "$overflow_dir" -type f -name "*.md")
  done
  total=$((live_count + archived_count))
  phases=$((archived_files + 1))
  phase_word="phases"
  [ "$phases" -eq 1 ] && phase_word="phase"
  echo "**Completed so far:** $total tasks across $phases $phase_word (mechanical count — see scripts/check-banka-thresholds.sh)"
  echo
fi

echo "## Threshold Check"
echo "_Last run: $(date +%Y-%m-%d). Run \`bash scripts/check-banka-thresholds.sh\` to refresh._"
echo
echo "| File | Words | Threshold | Status |"
echo "| --- | --- | --- | --- |"

# Completed / Completed Actions: never split into its own file (Protocol
# Section 2.9, Track B check 2) — checked as a section within
# progress-tracker.md (Standard) or progress.md (Core), heading name differs
# by tier.
if [ -f "context/progress-tracker.md" ]; then
  w=$(section_words "Completed" "context/progress-tracker.md")
  row "Completed (progress-tracker.md)" "$w" "$THRESHOLD"
elif [ -f "core/progress.md" ]; then
  w=$(section_words "Completed Actions" "core/progress.md")
  row "Completed Actions (progress.md)" "$w" "$THRESHOLD"
fi

# Session Notes and Decisions Index: standalone files under context/ (Standard)
# or core/ (Core) — Protocol Section 4/5's file split. Each is checked as a
# whole file, not a section within progress.md/progress-tracker.md.
for base in context core; do
  [ -d "$base" ] || continue
  for name in session-notes.md decisions-index.md; do
    f="$base/$name"
    [ -f "$f" ] || continue
    w=$(wc -w < "$f" | tr -d ' ')
    row "$name" "$w" "$THRESHOLD"
  done
done

# Delegation queue: Standard's context/delegation-queue.md, or root delegation-queue.md.
queue_file=""
if [ -f "context/delegation-queue.md" ]; then
  queue_file="context/delegation-queue.md"
elif [ -f "delegation-queue.md" ]; then
  queue_file="delegation-queue.md"
fi

if [ -n "$queue_file" ]; then
  w=$(section_words "Full ticket specs" "$queue_file")
  row "Full ticket specs" "$w" "$TICKET_THRESHOLD"
fi

# Any overflow files, wherever they live (context/overflow/, core/overflow/).
for overflow_dir in context/overflow core/overflow; do
  [ -d "$overflow_dir" ] || continue
  while IFS= read -r file; do
    [ -n "$file" ] || continue
    w=$(wc -w < "$file" | tr -d ' ')
    row "${file#"$overflow_dir"/}" "$w" "$THRESHOLD"
  done < <(find "$overflow_dir" -type f -name "*.md")
done
