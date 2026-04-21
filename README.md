# MarkItDown4AI

![License](https://img.shields.io/github/license/OpenTechIL/markitdown-for-ai?style=flat-square&logo=apache)
![Docker Build](https://img.shields.io/github/actions/workflow/status/OpenTechIL/markitdown-for-ai/docker.yml?label=build&style=flat-square)
![Latest Tag](https://ghcr-badge.egpl.dev/opentechil/markitdown-for-ai/latest_tag?trim=major&label=latest&style=flat-square)
![Release](https://img.shields.io/github/v/release/OpenTechIL/markitdown-for-ai?style=flat-square)
![Image Size](https://ghcr-badge.egpl.dev/opentechil/markitdown-for-ai/size?label=image%20size&style=flat-square)

Convert PDF, DOCX, PPTX, XLSX, and HTML to Markdown — in one command, zero Python required.

Built on [Microsoft's MarkItDown](https://github.com/microsoft/markitdown). Packaged as a Docker/Podman container and distributed as an AI agent skill that works with Claude Code, OpenCode, Codex, Cursor, Windsurf, and [40+ more](https://skills.sh).

```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai < report.pdf
```

---

## Why use this?

Most AI agents can't read binary documents. They need plain text. MarkItDown4AI solves this by giving every agent — and every pipeline — a single, consistent way to extract structured Markdown from any document format.

- **No Python, no installs** — runs entirely in Docker or Podman
- **Preserves structure** — tables, headings, lists, and formatting survive conversion
- **AI-native** — install once as a skill; every supported agent automatically knows how to use it
- **CI/CD ready** — pipe it into any shell script, GitHub Action, or automation workflow
- **Multi-arch** — native `amd64` and `arm64` images (Apple Silicon, AWS Graviton, x86 servers)

---

## Quick Start

### One-liner

```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai < document.pdf
```

Podman works as a drop-in replacement:

```bash
podman run --rm -i ghcr.io/opentechil/markitdown-for-ai < document.pdf
```

---

## AI Agent Skills

Install the `document-to-markdown` skill so your AI agent automatically knows how to convert documents whenever you ask.

### Via npx (recommended — works with all supported agents)

```bash
npx skills add OpenTechIL/markitdown-for-ai
```

Detects your agent automatically and installs to the correct location.

### Claude Code

```bash
# Install globally for Claude Code
bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh) --ai claude
```

Installs to `~/.claude/skills/document-to-markdown/`.

Then in any Claude Code session, just say:

> "Summarize this PDF" — and Claude will automatically convert and read it.

### OpenCode

```bash
# Install globally for OpenCode
bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh) --ai opencode

# Or install to a specific project
bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh) --local
```

Global installs to `~/.config/opencode/skills/document-to-markdown/`.  
Local installs to `.opencode/skills/document-to-markdown/` in the current project.

### All locations at once

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh)
```

Installs to every supported location:
- `~/.config/opencode/skills/` (OpenCode global)
- `~/.claude/skills/` (Claude Code)
- `~/.agents/skills/` (Codex / shared agents)

---

## Supported Formats

| Format      | Extension       |
|-------------|-----------------|
| PDF         | `.pdf`          |
| Word        | `.docx`         |
| PowerPoint  | `.pptx`         |
| Excel       | `.xlsx`         |
| HTML        | `.html`         |

---

## Usage Examples

### Pipe a file

```bash
cat report.docx | docker run --rm -i ghcr.io/opentechil/markitdown-for-ai
```

### Mount and convert by filename

```bash
docker run --rm -v "$(pwd):/data" -w /data ghcr.io/opentechil/markitdown-for-ai slides.pptx
```

### Save output to a file

```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai < input.xlsx > output.md
```

### Batch convert a directory

```bash
for f in *.pdf; do
  docker run --rm -i ghcr.io/opentechil/markitdown-for-ai < "$f" > "${f%.pdf}.md"
done
```

### Scrape an HTML page

```bash
curl -s "https://example.com" | docker run --rm -i ghcr.io/opentechil/markitdown-for-ai
```

### RAG / embedding pipeline

```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai < document.pdf | my-embed-cli ingest
```

---

## Multi-Platform Support

| Architecture | Targets |
|--------------|---------|
| `amd64`      | x86_64 servers, most desktops |
| `arm64`      | Apple Silicon, AWS Graviton, ARM servers |

Runs on Linux, macOS (Docker Desktop or Podman), and Windows (Docker Desktop).

---

## Security

- Runs as a non-root user (`appuser`) inside the container
- Multi-stage build — no build tools in the runtime image
- No network access during document conversion
- Self-contained: only the MarkItDown library and its declared extras (`pdf`, `docx`, `pptx`, `xlsx`)

---

## Development

### Build locally

```bash
docker build -t markitdown-for-ai .
```

### Test locally

```bash
docker run --rm -i markitdown-for-ai < test.pdf
```

### CI/CD

GitHub Actions builds and publishes multi-arch images to GHCR on every push to `main`. Releases are tagged automatically.

---

## Contributing

Contributions are welcome. Please follow [Conventional Commits](https://www.conventionalcommits.org/) and update `CHANGELOG.md` under `[Unreleased]` with every change. See [AGENTS.md](AGENTS.md) for full contributor guidance.

---

## License

Apache License 2.0 — see [LICENSE](LICENSE) for details.
