#!/bin/bash

TARGET_DIR=$1
EXCLUDES=".git|node_modules|__pycache__|env|.venv|myenv|_build"

echo "📁 Scanning directory: $TARGET_DIR"
echo

# --- Count totals ---
TOTAL_FILES=$(find "$TARGET_DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$TARGET_DIR" -type d | wc -l)

echo "🗂️  Total files:      $TOTAL_FILES"
echo "📂 Total folders:     $TOTAL_DIRS"
echo

# --- File breakdown ---
HTML_COUNT=$(find "$TARGET_DIR" -type f -iname "*.html" | wc -l)
MD_COUNT=$(find "$TARGET_DIR" -type f -iname "*.md" | wc -l)
PY_COUNT=$(find "$TARGET_DIR" -type f -iname "*.py" | wc -l)
JS_COUNT=$(find "$TARGET_DIR" -type f -iname "*.js" | wc -l)
CSS_COUNT=$(find "$TARGET_DIR" -type f -iname "*.css" | wc -l)
IMG_COUNT=$(find "$TARGET_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.svg" -o -iname "*.gif" \) | wc -l)
CFF_COUNT=$(find "$TARGET_DIR" -type f -iname "*.cff" | wc -l)

echo "🧾 File breakdown:"
printf "  📄 HTML files       : %5d\n" $HTML_COUNT
printf "  📓 Markdown files   : %5d\n" $MD_COUNT
printf "  🐍 Python files      : %5d\n" $PY_COUNT
printf "  📜 JavaScript files  : %5d\n" $JS_COUNT
printf "  🎨 CSS files         : %5d\n" $CSS_COUNT
printf "  🖼️  Image files       : %5d\n" $IMG_COUNT
printf "  🧾 Citation (.cff)   : %5d\n" $CFF_COUNT
echo

# --- Folder structure (including .md and .cff files) ---
echo "📚 Folder structure (first 3 levels):"
echo "$TARGET_DIR"
find "$TARGET_DIR" -mindepth 1 -maxdepth 3 \( -type d -o -iname "*.md" -o -iname "*.cff" \) \
    | grep -Ev "$EXCLUDES" \
    | sed "s|$TARGET_DIR/||" \
    | awk -F/ '{
        indent = ""
        for(i=1; i<NF; i++) indent = indent "│   "
        symbol = ($NF ~ /\.md$/) ? "📓 " : ($NF ~ /\.cff$/) ? "🧾 " : ""
        print indent "├── " symbol $NF
    }'

echo
echo "✅ Done scanning."
