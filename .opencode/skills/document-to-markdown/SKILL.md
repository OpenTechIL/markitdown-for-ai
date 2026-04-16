---
name: document-to-markdown
description: Use when asked to read, extract content from, or convert documents — PDF, DOCX, PPTX, XLSX, or HTML files — into Markdown text so an AI agent can process them.
---

# Document to Markdown Conversion

Convert documents to Markdown using the `markitdown-for-ai` Docker image. No local Python install needed — runs entirely in Docker.

## Quick Commands

**From stdin (pipe):**
```bash
docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai < file.pdf
```

**From a local file (mount current directory):**
```bash
docker run --rm -v "$(pwd):/data" -w /data ghcr.io/obot-ai/markitdown-for-ai file.docx
```

**Save output to a file:**
```bash
docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai < input.pptx > output.md
```

**Pipe from cat:**
```bash
cat file.xlsx | docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai
```

## Supported Formats

| Format | Extension |
|--------|-----------|
| PDF | `.pdf` |
| Word | `.docx` |
| PowerPoint | `.pptx` |
| Excel | `.xlsx` |
| HTML | `.html` |

## Pull the Image (first time)

```bash
docker pull ghcr.io/obot-ai/markitdown-for-ai
```

## Agent Workflow

When a user gives you a document file to read or analyze:

1. Run the conversion command above
2. Capture stdout as the Markdown content
3. Read and reason over the Markdown directly — no temp files needed

**Example — user says "summarize this PDF":**
```bash
# Capture markdown into a shell variable or pipe directly to next step
docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai < report.pdf
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Using `{owner}` placeholder | Use `ghcr.io/obot-ai/markitdown-for-ai` |
| Forgetting `-i` flag for stdin | Always add `-i` when piping |
| Mounting wrong path | Use `$(pwd)` and `-w /data` together |
| Expecting Docker to find relative paths without mount | Mount with `-v "$(pwd):/data"` |
