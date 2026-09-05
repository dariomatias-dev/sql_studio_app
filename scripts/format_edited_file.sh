#!/usr/bin/env bash
# PostToolUse hook: formats the file an Edit or Write tool call just
# touched, when it's a Dart file. Reads the tool call's JSON payload
# from stdin.
#
# Uses fvm when set up for the project, the bare dart otherwise.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

file_path=$(python3 -c '
import json, sys
payload = json.load(sys.stdin)
print(payload.get("tool_input", {}).get("file_path", ""))
')

[[ "$file_path" == *.dart ]] || exit 0
[[ -f "$file_path" ]] || exit 0

if command -v fvm >/dev/null 2>&1 && [[ -f .fvmrc ]]; then
  fvm dart format "$file_path" >/dev/null 2>&1 || true
else
  dart format "$file_path" >/dev/null 2>&1 || true
fi

exit 0
