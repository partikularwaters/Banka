#!/usr/bin/env bash
#
# verify-claims.sh — mechanical, zero-judgment reconciliation for the verify
# skill (Skills Kit). Never interprets whether something "looks right" —
# only reports what the filesystem and git actually show, or what an
# existing test/run command actually returned.
#
# Runs independent of any AI session: invoke it directly from a terminal.
# The verify skill invokes it and writes verified-index.md entries only
# from its exact output, the same relationship remember/moor/delegate/linis
# already have with check-banka-thresholds.sh.
#
# Never fixes anything, never writes verified-index.md itself — reports
# MET / MISSING / BLOCKED per check and stops.
#
# Reported invocations are re-quoted with `printf '%q'` for exact copy-paste
# reproducibility. In a non-UTF-8 locale (e.g. LANG unset, "C" locale), %q
# can mangle non-ASCII bytes in a path or command into unreadable escape
# sequences. This is a known limitation, not corruption of the check itself
# — the underlying check still ran correctly; only the reported invocation
# for a non-ASCII argument may not be reliably copy-pasteable. If this
# happens, verify should note it plainly rather than treat the mangled text
# as the real invocation.

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

usage() {
  cat <<'EOF'
Usage:
  verify-claims.sh --revision <commit> --check-file <path>
  verify-claims.sh --revision <commit> --check-diff <path>
  verify-claims.sh --check-file <path> [--check-file <path> ...]
  verify-claims.sh --check-diff <path> [--check-diff <path> ...]
  verify-claims.sh --run-test "<command>" [--run-test "<command>" ...]

Flags may be combined and repeated. Each check is reported on its own line,
mechanically — no check here ever judges correctness, only presence.
--revision must come first; file/diff checks use that committed tree.
Live checks and test runs are observations, not historical replay evidence.
EOF
}

if [ "$#" -eq 0 ]; then
  usage
  exit 1
fi

revision=""
prefix=""
if [ "$1" = "--revision" ]; then
  if [ "$#" -lt 3 ]; then usage >&2; exit 1; fi
  requested_revision="$2"
  if ! revision=$(git rev-parse --verify --end-of-options "$requested_revision^{commit}" 2>/dev/null); then
    echo "BLOCKED — revision unavailable: $requested_revision" >&2
    exit 1
  fi
  prefix="--revision $revision "
  shift 2
fi

# Validate all arguments before running any test command.
args=("$@")
while [ "$#" -gt 0 ]; do
  case "$1" in
    --check-file|--check-diff|--run-test)
      if [ "$#" -lt 2 ]; then usage >&2; exit 1; fi
      if [ "$1" = "--run-test" ] && [ -n "$revision" ]; then
        echo "--revision supports file/diff checks only; run tests separately as live observations." >&2
        exit 1
      fi
      shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown flag: $1" >&2; exit 1 ;;
  esac
done
set -- "${args[@]}"

# Uncommitted changes, else the most recent commit — same "actual diff, not
# memory" resolution moor's own git-grounding already uses.
diff_touches() {
  local path="$1"
  if [ -n "$revision" ]; then
    if ! git rev-parse --verify -q "$revision^" >/dev/null 2>&1; then
      echo "BLOCKED — parent unavailable (first commit or shallow history)"
    elif git diff --quiet "$revision^" "$revision" -- ":(literal)$path"; then
      echo "MISSING — commit $revision does not touch $path"
    else
      local diff_status=$?
      if [ "$diff_status" -eq 1 ]; then
        echo "MET — commit $revision touches $path"
      else
        echo "BLOCKED — cannot read commit diff"
      fi
    fi
    return
  fi
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "BLOCKED — not a git repository"
    return
  fi
  if [ -n "$(git status --porcelain -- "$path" 2>/dev/null)" ]; then
    echo "MET — uncommitted change touches $path"
    return
  fi
  if ! git rev-parse --verify -q HEAD~1 >/dev/null 2>&1; then
    echo "BLOCKED — no HEAD~1 to compare against (first commit, or a shallow checkout missing its parent)"
    return
  fi
  if git diff --name-only HEAD~1 -- "$path" 2>/dev/null | grep -q .; then
    local sha
    sha=$(git rev-parse --short HEAD)
    echo "MET — commit $sha touches $path"
    return
  fi
  echo "MISSING — no uncommitted change or recent commit touches $path"
}

results=()

while [ "$#" -gt 0 ]; do
  case "$1" in
    --check-file)
      path="$2"
      quoted_path=$(printf '%q' "$path")
      if [ -n "$revision" ]; then
        if [ "$(git cat-file -t "$revision:$path" 2>/dev/null || true)" = "blob" ]; then
          results+=("| \`${prefix}--check-file $quoted_path\` | MET | file exists at $revision |")
        else
          results+=("| \`${prefix}--check-file $quoted_path\` | MISSING | file not found at $revision |")
        fi
      elif [ -f "$path" ]; then
        results+=("| \`--check-file $quoted_path\` | MET | live observation: file exists |")
      else
        results+=("| \`--check-file $quoted_path\` | MISSING | live observation: file not found |")
      fi
      shift 2
      ;;
    --check-diff)
      path="$2"
      quoted_path=$(printf '%q' "$path")
      verdict=$(diff_touches "$path")
      detail="${verdict#*— }"
      if [ -z "$revision" ]; then detail="live observation: $detail"; fi
      results+=("| \`${prefix}--check-diff $quoted_path\` | ${verdict%% —*} | $detail |")
      shift 2
      ;;
    --run-test)
      command_str="$2"
      quoted_command=$(printf '%q' "$command_str")
      if output=$(eval "$command_str" 2>&1); then
        results+=("| \`--run-test $quoted_command\` | MET | exited 0 |")
      else
        exit_code=$?
        if [ "$exit_code" -eq 127 ]; then
          results+=("| \`--run-test $quoted_command\` | BLOCKED | command not found |")
        else
          results+=("| \`--run-test $quoted_command\` | MISSING | exited $exit_code |")
        fi
      fi
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown flag: $1" >&2
      usage
      exit 1
      ;;
  esac
done

echo "## Claim Check"
echo "_Last run: $(date +%Y-%m-%d). Run \`bash scripts/verify-claims.sh\` with the same flags to refresh._"
if [ -z "$revision" ]; then
  echo "_Live observation only: working files, history, dependencies, and external state are not preserved._"
fi
echo
echo "| Check | Result | Detail |"
echo "| --- | --- | --- |"
for line in "${results[@]}"; do
  echo "$line"
done
