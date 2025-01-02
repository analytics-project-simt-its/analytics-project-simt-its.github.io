#!/bin/bash

# Check if input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 tikz_file"
    exit 1
fi

TIKZ_FILE=$1
FILENAME=$(basename "$TIKZ_FILE" .tex)
DIR=$(dirname "$TIKZ_FILE")
OUTPUT_DIR="assets/svg"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Compile TikZ to PDF
pdflatex -output-directory="$DIR" "$TIKZ_FILE"

# Convert PDF to SVG
pdf2svg "$DIR/$FILENAME.pdf" "$OUTPUT_DIR/$FILENAME.svg"

# Clean up temporary files
rm -f "$DIR/$FILENAME.aux" "$DIR/$FILENAME.log" "$DIR/$FILENAME.pdf" 