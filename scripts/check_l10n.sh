#!/usr/bin/env bash
# Compares the message keys of every app_*.arb against the template
# (app_en.arb) and fails on a missing or extra key.
#
# `gen-l10n` falls back to the template message silently when a
# translation is missing, so a half-translated change ships as English
# inside a non-English build. Nothing else catches that.
#
# Usage:
#   scripts/check_l10n.sh

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

ARB_DIR="lib/l10n"
TEMPLATE="$ARB_DIR/app_en.arb"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template ARB not found: $TEMPLATE" >&2
  exit 1
fi

arb_keys() {
  # Message keys only: skip the @-prefixed metadata entries and the
  # top-level @@locale key.
  python3 -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
for key in sorted(data):
    if not key.startswith('@'):
        print(key)
" "$1"
}

template_keys=$(arb_keys "$TEMPLATE")
status=0

for arb in "$ARB_DIR"/app_*.arb; do
  [[ "$arb" == "$TEMPLATE" ]] && continue

  locale=$(basename "$arb" .arb)
  keys=$(arb_keys "$arb")

  missing=$(LC_ALL=C comm -23 <(echo "$template_keys") <(echo "$keys"))
  extra=$(LC_ALL=C comm -13 <(echo "$template_keys") <(echo "$keys"))

  if [[ -n "$missing" ]]; then
    echo "$locale: missing $(echo "$missing" | wc -l | tr -d ' ') key(s):" >&2
    echo "$missing" | sed 's/^/  - /' >&2
    status=1
  fi

  if [[ -n "$extra" ]]; then
    echo "$locale: $(echo "$extra" | wc -l | tr -d ' ') extra key(s) not in the template:" >&2
    echo "$extra" | sed 's/^/  - /' >&2
    status=1
  fi
done

if [[ "$status" -eq 0 ]]; then
  echo "check_l10n: every ARB file matches the template key set."
fi

exit "$status"
