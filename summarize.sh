#!/bin/bash

TARGET_DIR="$1"
EXCLUDES="(myenv|.venv|env|__pycache__|\.git|node_modules)"

if [ -z "$TARGET_DIR" ]; then
  echo "❗ Usage: $0 <directory>"
  exit 1
fi

echo "📁 Scanning directory: $TARGET_DIR"
echo

# Total files and folders (excluding env-like stuff)
total_files=$(find "$TARGET_DIR" -type f -not -path "*/$EXCLUDES/*" | wc -l)
total_dirs=$(find "$TARGET_DIR" -type d -not -path "*/$EXCLUDES/*" | wc -l)

echo "🗂️  Total files:    $(printf '%6d' "$total_files")"
echo "📂 Total folders:  $(printf '%6d' "$total_dirs")"
echo

# File breakdown
echo "🧾 File breakdown:"
printf "  📄 HTML files      : %6d\n" $(find "$TARGET_DIR" -type f -name "*.html" -not -path "*/$EXCLUDES/*" | wc -l)
printf "  📓 Markdown files  : %6d\n" $(find "$TARGET_DIR" -type f -name "*.md" -not -path "*/$EXCLUDES/*" | wc -l)
printf "  🐍 Python files     : %6d\n" $(find "$TARGET_DIR" -type f -name "*.py" -not -path "*/$EXCLUDES/*" | wc -l)
printf "  📜 JavaScript files : %6d\n" $(find "$TARGET_DIR" -type f -name "*.js" -not -path "*/$EXCLUDES/*" | wc -l)
printf "  🎨 CSS files        : %6d\n" $(find "$TARGET_DIR" -type f -name "*.css" -not -path "*/$EXCLUDES/*" | wc -l)
printf "  🖼️  Image files      : %6d\n" $(find "$TARGET_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) -not -path "*/$EXCLUDES/*" | wc -l)

echo
echo "✅ Done scanning."
echo

# Warn if virtual envs exist
venvs_found=$(find "$TARGET_DIR" -type d -regextype posix-extended -regex ".*/($EXCLUDES)$" 2>/dev/null)
if [[ ! -z "$venvs_found" ]]; then
  echo "⚠️  Virtual environments or large ignored folders found:"
  echo "$venvs_found" | sed 's/^/   🚫 /'
  echo
fi

# Folder structure (3 levels max)
echo "📚 Folder structure (first 3 levels):"
echo "$TARGET_DIR"
find "$TARGET_DIR" -mindepth 1 -maxdepth 3 -type d -not -path "*/$EXCLUDES/*" | sed 's|[^/]*/|│   |g' | sed 's|│   \([^│]*\)$|├── \1|'
