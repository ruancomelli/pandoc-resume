#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

USAGE_TEXT="Usage: docker run -v \$(pwd):/resume ghcr.io/ruancomelli/pandoc-resume-docker <input_file> [-o output_file]"
EXAMPLE_TEXT="Example: docker run -v \$(pwd):/resume ghcr.io/ruancomelli/pandoc-resume-docker path/to/cv.md -o path/to/cv.pdf"

function abort_with_error() {
    echo -e "${RED}Error: $1${NC}"
    echo "$USAGE_TEXT"
    echo "$EXAMPLE_TEXT"
    exit 1
}

# Parse arguments
if [ $# -eq 0 ]; then
    abort_with_error "Input file is required"
fi

# Default value
OUTPUT_FILE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            echo "$USAGE_TEXT"
            echo "$EXAMPLE_TEXT"
            exit 0
            ;;
        -*|--*)
            abort_with_error "Unknown option '$1'"
            ;;
        *)
            INPUT_FILE="$1"
            shift
            ;;
    esac
done

# Check if input file is an option
if [[ "$INPUT_FILE" == -* ]]; then
    abort_with_error "Unknown option '$INPUT_FILE'"
fi

# Check if input file exists in the mounted volume
if [ ! -f "/resume/$INPUT_FILE" ]; then
    abort_with_error "Input file '/resume/$INPUT_FILE' not found"
fi

# If no output file specified, use input file name with .pdf extension
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="${INPUT_FILE%.*}.pdf"
fi

# Create output directory if it doesn't exist
OUTPUT_DIR=$(dirname "/resume/$OUTPUT_FILE")
mkdir -p "$OUTPUT_DIR"

# Copy the user's resume to the correct location
cp "/resume/$INPUT_FILE" /app/pandoc_resume/markdown/resume.md

# Change to the pandoc_resume directory
cd /app

# Run make to generate the resume
make

# TODO: Use this to generate the resume?
# docker run --rm \
# 	--volume "`pwd`:/data" \
# 	pandoc/latex \
# 	--pdf-engine=xelatex \
# 	-f markdown+smart+multiline_tables \
# 	"/data/$input_file" \
# 	-o "/data/$output_file"

# Check if PDF was generated
if [ ! -f "output/resume.pdf" ]; then
    echo "Error: PDF generation failed"
    echo "ConTeXt log file contents:"
    cat output/context_resume.log
    exit 1
fi

# Copy the generated files back to the mounted volume
mv output/resume.pdf "/resume/$OUTPUT_FILE"
mv output/resume.html "/resume/${OUTPUT_FILE%.*}.html"

echo "Resume generated successfully!"
echo "Output files:"
echo "  - $OUTPUT_FILE"
echo "  - ${OUTPUT_FILE%.*}.html"