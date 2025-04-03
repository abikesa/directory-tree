#!/bin/bash

# Usage: ./summarize.sh <folder>
TARGET="$1"

if [ -z "$TARGET" ]; then
  echo "❌ Please specify a folder to scan. Example: ./summarize.sh ukubona-llc.github.io"
  exit 1
fi

if [ ! -d "$TARGET" ]; then
  echo "❌ '$TARGET' is not a valid directory."
  exit 1
fi

echo "📁 Scanning directory: $TARGET"
echo ""

# Count by type
html_count=$(find "$TARGET" -type f -iname "*.html" | wc -l)
md_count=$(find "$TARGET" -type f -iname "*.md" | wc -l)
py_count=$(find "$TARGET" -type f -iname "*.py" | wc -l)
js_count=$(find "$TARGET" -type f -iname "*.js" | wc -l)
css_count=$(find "$TARGET" -type f -iname "*.css" | wc -l)
img_count=$(find "$TARGET" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.svg" \) | wc -l)
dir_count=$(find "$TARGET" -type d | wc -l)
file_count=$(find "$TARGET" -type f | wc -l)

echo "🗂️  Total files: $file_count"
echo "📂 Total folders: $dir_count"
echo ""
echo "🧾 File breakdown:"
echo "  📄 HTML files      : $html_count"
echo "  📓 Markdown files  : $md_count"
echo "  🐍 Python files     : $py_count"
echo "  📜 JavaScript files : $js_count"
echo "  🎨 CSS files        : $css_count"
echo "  🖼️  Image files      : $img_count"
echo ""
echo "✅ Done scanning."

# Optional: visualize folder tree up to 3 levels
echo ""
echo "📚 Folder structure (first 3 levels):"
find "$TARGET" -type d | sed 's|[^/]*/|  |g' | sed 's|  |│   |g' | sed 's|│   \(.*\)|├── \1|'
