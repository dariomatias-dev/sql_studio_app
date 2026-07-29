#!/usr/bin/env bash
# Automatically drives the app through its main screens in every
# supported locale, saving a screenshot of each into a per-locale
# subfolder of screenshots/, for use in the README (one folder per
# language), Play Store listing, official website, etc.
#
# Usage:
#   scripts/screenshot.sh [device-id]
#
# Run `flutter devices` to list available device ids. Defaults to the
# only connected device if there's just one.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

DEVICE_ARGS=()
if [[ "${1:-}" != "" ]]; then
  DEVICE_ARGS=(-d "$1")
fi

rm -rf screenshots
mkdir -p screenshots

flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/screenshot_test.dart \
  "${DEVICE_ARGS[@]}"

echo "Screenshots saved in screenshots/<locale>/"
