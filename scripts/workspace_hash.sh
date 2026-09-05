#!/usr/bin/env bash
# Prints a hash of the current source tree: every tracked file plus
# every untracked, non-ignored file under lib/, test/ and the config
# files verify.sh checks. Used to tell whether the workspace has
# changed since the last successful verify.sh run.
#
# Usage:
#   scripts/workspace_hash.sh

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

{
  git ls-files -z -- lib test pubspec.yaml pubspec.lock l10n.yaml analysis_options.yaml
  git ls-files -z --others --exclude-standard -- lib test
} | LC_ALL=C sort -zu | xargs -0 sha256sum | sha256sum | cut -d' ' -f1
