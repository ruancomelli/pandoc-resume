#!/bin/bash

# Exit on error
set -e

echo "Building Docker image..."
docker build -t pandoc-resume-docker .

echo -e "\nTesting with basic usage..."
docker run -v "$(pwd)/test":/resume pandoc-resume-docker resume.md

echo -e "\nTesting with custom output path..."
docker run -v "$(pwd)/test":/resume pandoc-resume-docker resume.md -o output/custom.pdf

echo -e "\nChecking generated files..."
ls -l test/*.pdf test/*.html test/output/*.pdf test/output/*.html

echo -e "\nTest completed successfully!"
