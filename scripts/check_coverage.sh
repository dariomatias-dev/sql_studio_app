#!/usr/bin/env bash
# Parses an lcov coverage report, excludes lib/l10n/** (all of it
# generated except the ARB files themselves), and fails when line
# coverage falls below the given minimum.
#
# Usage:
#   scripts/check_coverage.sh <lcov-file> <minimum-percent>
#
# Example:
#   scripts/check_coverage.sh coverage/lcov.info 69

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <lcov-file> <minimum-percent>" >&2
  exit 2
fi

LCOV_FILE="$1"
MINIMUM="$2"

if [[ ! -f "$LCOV_FILE" ]]; then
  echo "Coverage file not found: $LCOV_FILE" >&2
  exit 1
fi

python3 - "$LCOV_FILE" "$MINIMUM" <<'PY'
import sys

lcov_path, minimum = sys.argv[1], float(sys.argv[2])

EXCLUDED_PREFIXES = ("lib/l10n/",)

total_lines = 0
total_hit = 0
current_file = None
skip_current = False

with open(lcov_path) as f:
    for line in f:
        line = line.rstrip("\n")

        if line.startswith("SF:"):
            current_file = line[3:]
            skip_current = current_file.startswith(EXCLUDED_PREFIXES)
        elif line.startswith("LF:") and not skip_current:
            total_lines += int(line[3:])
        elif line.startswith("LH:") and not skip_current:
            total_hit += int(line[3:])
        elif line == "end_of_record":
            current_file = None
            skip_current = False

if total_lines == 0:
    print("check_coverage: no lines found after exclusions.", file=sys.stderr)
    sys.exit(1)

percent = (total_hit / total_lines) * 100

print(
    f"check_coverage: {total_hit}/{total_lines} lines "
    f"({percent:.1f}%), minimum {minimum:.1f}%."
)

if percent < minimum:
    print(
        f"check_coverage: {percent:.1f}% is below the {minimum:.1f}% minimum.",
        file=sys.stderr,
    )
    sys.exit(1)
PY
