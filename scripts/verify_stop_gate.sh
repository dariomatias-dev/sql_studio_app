#!/usr/bin/env bash
# Stop hook: refuses to end a turn while lib/, test/ or the project
# config differ from the last successful scripts/verify.sh run.
#
# Reads the stamp verify.sh writes on a full pass (.claude/verify-stamp)
# and compares it against the current workspace hash. Exits 0 to allow
# the turn to end, or 2 with a message on stderr to block it, which is
# how Claude Code hooks report a blocking failure.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

STAMP_FILE=".claude/verify-stamp"

current_hash=$(scripts/workspace_hash.sh)

if [[ -f "$STAMP_FILE" ]] && [[ "$(cat "$STAMP_FILE")" == "$current_hash" ]]; then
  exit 0
fi

echo "scripts/verify.sh has not passed against the current changes. Run it (or scripts/verify.sh --skip-tests for a faster partial check, then a full run before finishing) before ending this turn." >&2
exit 2
