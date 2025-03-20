# Pandoc Resume

<!-- [![CI](https://github.com/ruancomelli/brag-ai/actions/workflows/ci.yaml/badge.svg)](https://github.com/ruancomelli/brag-ai/actions/workflows/ci.yaml) -->

[![Codecov](https://codecov.io/gh/ruancomelli/brag-ai/branch/main/graph/badge.svg)](https://codecov.io/gh/ruancomelli/brag-ai)
[![Sourcery](https://img.shields.io/badge/Sourcery-enabled-orange?logo=hackthebox&logoColor=orange)](https://sourcery.ai)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![SemVer](https://img.shields.io/badge/semver-2.0.0-green)](https://semver.org/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Author: ruancomelli](https://img.shields.io/badge/ruancomelli-blue?style=flat&label=author)](https://github.com/ruancomelli)

This repository provides a Docker-based solution for generating beautiful resumes using the [pandoc_resume](https://github.com/mszep/pandoc_resume) project.

## Prerequisite

- [Docker](https://docs.docker.com/get-started/get-docker/) (yes, just Docker)

## Usage

1. Create your resume in Markdown format:

#### **`my-resume.md`**

```markdown
# Ruan Comelli

Hello, I'm Ruan.

## Experience

Did this and that.

## Education

Yes, I am educated.
```

2. Convert your resume to PDF:

```bash
# Basic usage (generates my-resume.pdf in the same directory)
docker run ghcr.io/ruancomelli/pandoc-resume my-resume.md

# Specify input and output files
docker run ghcr.io/ruancomelli/pandoc-resume my-resume.md -o path/to/output/cv.pdf
```

The command will generate:

- A PDF file (default: same name as input with .pdf extension)
- An HTML file (default: same name as input with .html extension)

3. Star [this repo](https://github.com/ruancomelli/pandoc-resume)! ⭐

## Customization

🚧 Customization features coming soon! Stay tuned for more ways to make your resume stand out! ✨

<!--
You can customize your resume by:

1. Editing your Markdown file
2. Modifying the styles in the `pandoc_resume/styles` directory
-->

## Support

- 📖 [Documentation](https://github.com/ruancomelli/pandoc-resume)
- 🐛 [Issue Tracker](https://github.com/ruancomelli/pandoc-resume/issues)
- 💬 [Discussions](https://github.com/ruancomelli/pandoc-resume/discussions)
- 💻 [Repository](https://github.com/ruancomelli/pandoc-resume)

## License

This project is licensed under the [GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/) - see the [LICENSE](LICENSE) file for details.

---

Built with ❤️ and ☕ by [Ruan Comelli](https://github.com/ruancomelli)
