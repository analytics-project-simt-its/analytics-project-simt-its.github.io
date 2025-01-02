#!/bin/bash

# Convert all TikZ files to SVG
for tikz_file in _tikz/*.tex; do
    if [ -f "$tikz_file" ]; then
        echo "Converting $tikz_file to SVG..."
        ./_scripts/tikz2svg.sh "$tikz_file"
    fi
done

# Build Jekyll site
bundle exec jekyll serve 