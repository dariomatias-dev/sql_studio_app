#!/usr/bin/env bash
# Local quality gate mirroring CI, step for step: regenerate l10n and
# fail if it changed anything, check_l10n.sh, format, analyze, test with
# coverage, check_coverage.sh, for the root app and, the same four
# checks, for packages/app_ui.
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

# Kept in sync by hand with ci.yaml's `quality` and `app_ui` jobs; nothing
# enforces the two match, so a change to either floor needs both updated.
COVERAGE_MINIMUM=91
APP_UI_COVERAGE_MINIMUM=79
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

# Runs format, analyze, and (unless --skip-tests) test with the coverage
# gate inside one package directory.
#
#   $1  directory to run in, relative to the repo root
#   $2  minimum line coverage percentage
#   $3  human-readable name, for the step headings
verify_package() {
  local dir="$1" minimum="$2" name="$3"

  step "$name: flutter pub get"
  (cd "$dir" && "${FLUTTER[@]}" pub get)

  step "$name: dart format --set-exit-if-changed"
  (cd "$dir" && "${DART[@]}" format --set-exit-if-changed lib/ test/)

  step "$name: flutter analyze"
  (cd "$dir" && "${FLUTTER[@]}" analyze)

  if [[ "$SKIP_TESTS" == true ]]; then
    step "$name: tests skipped (--skip-tests)"
    return
  fi

  step "$name: flutter test --coverage"
  (cd "$dir" && "${FLUTTER[@]}" test --coverage)

  step "$name: check_coverage.sh"
  scripts/check_coverage.sh "$dir/coverage/lcov.info" "$minimum"
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

verify_package packages/app_ui "$APP_UI_COVERAGE_MINIMUM" "packages/app_ui"

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
