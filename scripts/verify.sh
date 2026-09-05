#!/usr/bin/env bash
# Local quality gate mirroring CI, step for step: regenerate l10n and
# fail if it changed anything, check_l10n.sh, format, analyze, test with
# coverage, check_coverage.sh.
#
# Uses `fvm flutter`/`fvm dart` when FVM is set up for this project, and
# the bare `flutter`/`dart` otherwise, so contributors without FVM see
# the same steps CI runs.
#
# Usage:
#   scripts/verify.sh [--skip-tests]
#
#   --skip-tests  Skips the test run and coverage check. Useful for a
#                 fast local pass while iterating; never the final gate
#                 before a commit or a push.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

COVERAGE_MINIMUM=86
SKIP_TESTS=false

for arg in "$@"; do
  case "$arg" in
    --skip-tests) SKIP_TESTS=true ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Usage: $0 [--skip-tests]" >&2
      exit 2
      ;;
  esac
done

if command -v fvm >/dev/null 2>&1 && [[ -f .fvmrc ]]; then
  FLUTTER=(fvm flutter)
  DART=(fvm dart)
else
  FLUTTER=(flutter)
  DART=(dart)
fi

step() {
  echo ""
  echo "── $1 ──"
}

step "flutter pub get"
"${FLUTTER[@]}" pub get

step "gen-l10n"
"${FLUTTER[@]}" gen-l10n
if ! git diff --quiet -- lib/l10n; then
  echo "gen-l10n changed generated output. Commit the regenerated files." >&2
  git diff --stat -- lib/l10n >&2
  exit 1
fi

step "check_l10n.sh"
scripts/check_l10n.sh

step "dart format --set-exit-if-changed"
"${DART[@]}" format --set-exit-if-changed lib/ test/

step "flutter analyze"
"${FLUTTER[@]}" analyze

if [[ "$SKIP_TESTS" == true ]]; then
  echo ""
  echo "Skipped tests and coverage (--skip-tests). This is not the final gate."
  rm -f .claude/verify-stamp
  exit 0
fi

step "flutter test --coverage"
"${FLUTTER[@]}" test --coverage

step "check_coverage.sh"
scripts/check_coverage.sh coverage/lcov.info "$COVERAGE_MINIMUM"

mkdir -p .claude
scripts/workspace_hash.sh > .claude/verify-stamp

echo ""
echo "verify.sh: all checks passed."
