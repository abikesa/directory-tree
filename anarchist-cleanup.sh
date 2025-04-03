#!/bin/bash

echo "🧹 Cleaning up anarchist repo..."

# Preserve core files and folders
PRESERVE=(
    "1-chaos" "2-frenzy" "3-emotion" "4-dionysian" "5-algorithm" "6-binary"
    "README.md" "requirements.txt" "environment.yml" "Dockerfile"
)

# Define patterns to delete
TRASH_PATTERNS=(
    "__pycache__"
    ".ipynb_checkpoints"
    ".pytest_cache"
    ".mypy_cache"
    ".tox"
    ".git"
    "_build"
    "_doctrees"
    ".DS_Store"
    "*.egg-info"
    "*.log"
    "*.tmp"
)

# Delete unwanted dirs/files
for pattern in "${TRASH_PATTERNS[@]}"; do
    echo "❌ Removing $pattern..."
    find anarchist -type d -name "$pattern" -exec rm -rf {} + 2>/dev/null
    find anarchist -type f -name "$pattern" -exec rm -f {} + 2>/dev/null
done

# Delete all HTML, CSS, JS, and images except in explicitly useful places
find anarchist -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.jpg" -o -name "*.png" -o -name "*.svg" \) ! -path "*/donorcase/*" -delete

echo "✅ Cleanup done. .ipynb files, key scripts, and top-level folders preserved."
