# Pandoc Resume

This repository provides a Docker-based solution for generating beautiful resumes using the [pandoc_resume](https://github.com/mszep/pandoc_resume) project.

## Prerequisites

- Docker

## Usage

1. Create your resume in Markdown format:

```bash
# Create and edit your resume.md file
vim resume.md
```

2. Generate your resume:

```bash
# Basic usage (generates resume.pdf and resume.html in the same directory)
docker run -v $(pwd):/resume ghcr.io/ruancomelli/pandoc-resume resume.md

# Specify input and output files
docker run -v $(pwd):/resume ghcr.io/ruancomelli/pandoc-resume path/to/my/cv.md -o path/to/output/cv.pdf
```

The command will generate:

- A PDF file (default: same name as input with .pdf extension)
- An HTML file (default: same name as input with .html extension)

## How it Works

This Docker setup:

1. Uses Ubuntu 22.04 as the base image
2. Installs all required dependencies (pandoc, context, make, git)
3. Clones the pandoc_resume repository
4. Uses your local Markdown file to generate the resume
5. Outputs both PDF and HTML versions

## Customization

You can customize your resume by:

1. Editing your Markdown file
2. Modifying the styles in the `pandoc_resume/styles` directory
3. Adjusting the Makefile options in the `pandoc_resume` directory

## License

This project is licensed under the MIT License - see the LICENSE file for details.
