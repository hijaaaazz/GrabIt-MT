#!/bin/bash

echo "📂 Showing all .dart files with full content"
echo "-------------------------------------------"

# Find all Dart files and display their content
find lib -type f -name "*.dart" | while read file; do
  echo ""
  echo "========== $file =========="
  cat "$file"
done
