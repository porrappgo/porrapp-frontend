#!/usr/bin/env bash
set -e

## Project paths (no Melos)
PROJECT_ROOT_PATH="$(pwd)"
PACKAGE_PATH="."
PACKAGE_NAME="$(basename "$PROJECT_ROOT_PATH")"

PACKAGE_LCOV_INFO_PATH="$PROJECT_ROOT_PATH/coverage/lcov_$PACKAGE_NAME.info"
PACKAGE_TEST_REPORT_PATH="$PROJECT_ROOT_PATH/test_reports/${PACKAGE_NAME}_test_report.json"

mkdir -p "$PROJECT_ROOT_PATH/coverage"
mkdir -p "$PROJECT_ROOT_PATH/test_reports"

flutter test \
  --no-pub \
  --machine \
  --coverage \
  --coverage-path "$PACKAGE_LCOV_INFO_PATH" \
  > "$PACKAGE_TEST_REPORT_PATH"

escapedPath="$(echo "$PACKAGE_PATH" | sed 's/\//\\\//g')"

# macOS needs gsed
if [[ "$OSTYPE" =~ ^darwin ]]; then
  gsed -i "s/^SF:lib/SF:$escapedPath\/lib/g" "$PACKAGE_LCOV_INFO_PATH"
else
  sed -i "s/^SF:lib/SF:$escapedPath\/lib/g" "$PACKAGE_LCOV_INFO_PATH"
fi

echo "✅ Coverage generated."
