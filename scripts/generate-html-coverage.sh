#!/usr/bin/env bash
set -e

PROJECT_ROOT_PATH="$(pwd)"

COVERAGE_DIR="$PROJECT_ROOT_PATH/coverage_report"
LCOV_FILE="$COVERAGE_DIR/cleaned_combined_lcov.info"

mkdir -p "$COVERAGE_DIR"

genhtml "$LCOV_FILE" --output-directory "$COVERAGE_DIR"

echo "✅ HTML coverage generated at $COVERAGE_DIR/index.html"