#!/bin/bash

set -e

COMMIT_MSG="$1"

if [ -z "$COMMIT_MSG" ]; then
    echo "Usage: ./convert_push.sh \"commit text\""
    exit 1
fi

NOTEBOOK_DIR="notebooks"
MARKDOWN_DIR="markdown"

mkdir -p "$MARKDOWN_DIR"

find "$NOTEBOOK_DIR" -name "*.ipynb" -not -path "*/.ipynb_checkpoints/*" | while read -r notebook; do
    path="${notebook#$NOTEBOOK_DIR/}"
    md_path="$MARKDOWN_DIR/${path%.ipynb}.md"

    md_dir="$(dirname "$md_path")"
    md_file="$(basename "$md_path" .md)"

    mkdir -p "$md_dir"

    if [ ! -f "$md_path" ] || [ "$notebook" -nt "$md_path" ]; then
        echo "Converting $notebook -> $md_path"

        jupyter nbconvert "$notebook" \
            --to markdown \
            --output-dir "$md_dir" \
            --output "$md_file"

        echo "Created/Updated $md_path"
    else
        echo "Already converted: $notebook"
    fi
done

git add .
git commit -m "$COMMIT_MSG"
git push -u origin main