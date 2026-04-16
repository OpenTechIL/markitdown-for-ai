# MarkItDown Docker Image

[![Docker Pulls](https://img.shields.io/docker/pulls/ghcr.io/OpenTechIL/markitdown-for-ai?style=flat-square)](https://github.com/OpenTechIL/markitdown-for-ai/pkgs/container/markitdown-for-ai)
[![Docker Size](https://img.shields.io/docker/image-size/ghcr.io/OpenTechIL/markitdown-for-ai/latest?style=flat-square)](https://github.com/OpenTechIL/markitdown-for-ai/pkgs/container/markitdown-for-ai)
[![GitHub Release](https://img.shields.io/github/v/release/OpenTechIL/markitdown-for-ai?style=flat-square)](https://github.com/OpenTechIL/markitdown-for-ai/releases)
[![CI/CD](https://img.shields.io/github/actions/workflow/status/OpenTechIL/markitdown-for-ai/docker.yml?label=CI%2FCD&style=flat-square)](https://github.com/OpenTechIL/markitdown-for-ai/actions/workflows/docker.yml)

MarkItDown is a Python tool that converts various document formats to Markdown. This Docker image provides a portable, easy-to-use containerized version that works out of the box.

## What is MarkItDown?

MarkItDown converts documents from popular formats into clean Markdown text. It preserves document structure including tables, lists, headings, and basic formatting, making it ideal for content extraction, documentation processing, and workflow automation.

## Supported Formats

- **PDF**  - Portable Document Format
- **DOCX** - Microsoft Word documents
- **PPTX** - Microsoft PowerPoint presentations
- **XLSX** - Microsoft Excel spreadsheets
- **HTML** - Web pages and HTML documents

## Installation

Pull the latest image from GitHub Container Registry:

```bash
docker pull ghcr.io/OpenTechIL/markitdown-for-ai
```

## Usage

### Convert a file

```bash
docker run --rm -i ghcr.io/OpenTechIL/markitdown-for-ai < input.pdf
```

### Convert via pipe

```bash
cat file.docx | docker run --rm -i ghcr.io/OpenTechIL/markitdown-for-ai
```

### Specify output file

```bash
docker run --rm ghcr.io/OpenTechIL/markitdown-for-ai input.pdf -o output.md
```

### Interactive mode

```bash
docker run --rm -it ghcr.io/OpenTechIL/markitdown-for-ai
```

Then enter file content via stdin and press Ctrl+D when done.

## GitHub Actions Integration

This Docker image is automatically built and published using GitHub Actions. The workflow:

1.  Builds the Docker image on every push to main
2.  Runs tests to verify the image works correctly
3.  Publishes the image to GitHub Container Registry (ghcr.io)
4.  Creates version tags for releases

The CI/CD pipeline ensures the image is always up to date with the latest MarkItDown dependencies and security patches.

## Multi-Platform Support

The Docker image supports multiple architectures:

| Architecture | Description |
|--------------|-------------|
| `amd64`      | x86_64 (standard desktop and server) |
| `arm64`      | ARM 64-bit (Apple Silicon, ARM servers) |

This means the image runs natively on:

-   Linux servers (x86 and ARM)
-   macOS (Intel and Apple Silicon via Rosetta 2)
-   Windows with Docker Desktop

## Development

To build the image locally:

```bash
docker build -t markitdown-for-ai .
```

To test locally:

```bash
docker run --rm -i markitdown-for-ai < test.pdf
```

## AI Agent Skill

Install the `document-to-markdown` skill so AI agents (OpenCode, Claude Code, Codex, Cursor, Windsurf, and [40+ more](https://skills.sh)) automatically know how to use this image when asked to read or convert documents.

### Install via skills CLI (recommended)

```bash
npx skills add OpenTechIL/markitdown-for-ai
```

This works with all supported agents and installs to the correct location automatically.

### One-command bash install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh)
```

This copies the skill into:
- `~/.config/opencode/skills/document-to-markdown/` (OpenCode global)
- `~/.agents/skills/document-to-markdown/` (Codex / shared agents)
- `~/.claude/skills/document-to-markdown/` (Claude Code personal)

After installing, any agent session will automatically know the correct commands to convert documents to Markdown.

### Install via agent prompt

Alternatively, copy and paste this prompt directly into any LLM agent (Claude Code, AmpCode, Cursor, Windsurf, etc.):

```
Run this command in my terminal:
npx skills add OpenTechIL/markitdown-for-ai
```

The agent will execute the installer and confirm the skill is ready.

## License

This project is licensed under the terms included in the [LICENSE](LICENSE) file.