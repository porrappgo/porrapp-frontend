#!/bin/bash
set -euo pipefail

PROJECT_ROOT_PATH=$1
COVERAGE_DIR="$PROJECT_ROOT_PATH/coverage"
REPORT_DIR="$PROJECT_ROOT_PATH/coverage_report"

mkdir -p "$REPORT_DIR"

# Combina todos los archivos .info de coverage
LCOV_INPUT_FILES=""
for file in "$COVERAGE_DIR"/*.info; do
  # Solo añadir si el archivo existe
  [ -f "$file" ] && LCOV_INPUT_FILES="$LCOV_INPUT_FILES -a \"$file\""
done

# Evalua la línea completa de lcov
eval lcov $LCOV_INPUT_FILES -o "$REPORT_DIR/combined_lcov.info"

# Remueve archivos que no queremos incluir
lcov --remove "$REPORT_DIR/combined_lcov.info" \
  "lib/main*.dart" \
  "*.gr.dart" \
  "*.g.dart" \
  "*.freezed.dart" \
  "*di.config.dart" \
  "*.i69n.dart" \
  "*/generated/*" \
  "*.theme_extension.dart" \
  -o "$REPORT_DIR/cleaned_combined_lcov.info"\
  --ignore-errors unused

echo "✅ Combined and cleaned coverage report generated at $REPORT_DIR/cleaned_combined_lcov.info"
