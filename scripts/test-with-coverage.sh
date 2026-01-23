#!/usr/bin/env bash
set -e

PROJECT_ROOT_PATH="$(pwd)"
PACKAGE_PATH="."
PACKAGE_NAME="$(basename "$PROJECT_ROOT_PATH")"

PACKAGE_LCOV_INFO_PATH="$PROJECT_ROOT_PATH/coverage/lcov_$PACKAGE_NAME.info"
PACKAGE_TEST_REPORT_PATH="$PROJECT_ROOT_PATH/test_reports/${PACKAGE_NAME}_test_report.json"

mkdir -p "$PROJECT_ROOT_PATH/coverage" "$PROJECT_ROOT_PATH/test_reports"

echo "▶ Running flutter test..."

flutter test \
  --machine \
  --coverage \
  --coverage-path "$PACKAGE_LCOV_INFO_PATH" \
  > "$PACKAGE_TEST_REPORT_PATH"

if [[ ! -f "$PACKAGE_LCOV_INFO_PATH" ]]; then
  echo "❌ Coverage file not generated"
  exit 1
fi

escapedPath="$(echo "$PACKAGE_PATH" | sed 's/\//\\\//g')"

if [[ "$OSTYPE" =~ ^darwin ]]; then
  gsed -i "s/^SF:lib/SF:$escapedPath\/lib/g" "$PACKAGE_LCOV_INFO_PATH"
else
  sed -i "s/^SF:lib/SF:$escapedPath\/lib/g" "$PACKAGE_LCOV_INFO_PATH"
fi

echo "✅ Coverage generated at $PACKAGE_LCOV_INFO_PATH"
