---
name: document-to-markdown
description: Use when asked to read, extract content from, or convert documents — PDF, DOCX, PPTX, XLSX, or HTML files — into Markdown text so an AI agent can process them.
---

# Document to Markdown Conversion

Convert documents to Markdown using the `markitdown-for-ai` Docker image. No local Python install needed — runs entirely in Docker.

## Quick Commands

**From stdin (pipe):**
```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < file.pdf
```

**From a local file (mount current directory):**
```bash
docker run --rm -v "$(pwd):/data" -w /data ghcr.io/opentechil/markitdown-for-ai:latest file.docx
```

**Save output to a file:**
```bash
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < input.pptx > output.md
```

**Pipe from cat:**
```bash
cat file.xlsx | docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest
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
docker pull ghcr.io/opentechil/markitdown-for-ai:latest
```

## Agent Workflow

When a user gives you a document file to read or analyze:

1. Run the conversion command above
2. Capture stdout as the Markdown content
3. Read and reason over the Markdown directly — no temp files needed

**Example — user says "summarize this PDF":**
```bash
# Capture markdown into a shell variable or pipe directly to next step
docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < report.pdf
```

## When to Use This Skill

Use this skill whenever you need to extract or process content from documents. Here are common scenarios:

### Document Conversion & Extraction

- **Reading DOCX files**: "Read this Word document", "extract text from docx"
  ```bash
  docker run --rm -v "$(pwd):/data" -w /data ghcr.io/opentechil/markitdown-for-ai:latest document.docx
  ```

- **Reading PDF files**: "Convert PDF to markdown", "extract PDF content"
  ```bash
  docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < report.pdf
  ```

- **Processing PowerPoint**: "Extract slides from pptx", "convert presentation"
  ```bash
  docker run --rm -v "$(pwd):/data" -w /data ghcr.io/opentechil/markitdown-for-ai:latest slides.pptx
  ```

- **Extracting Excel data**: "Read spreadsheet", "convert xlsx to markdown"
  ```bash
  docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < data.xlsx
  ```

- **Scraping HTML**: "Convert web page to markdown", "extract article content"
  ```bash
  docker run --rm -v "$(pwd):/data" -w /data ghcr.io/opentechil/markitdown-for-ai:latest page.html
  ```

### AI & Automation Use Cases

- **Summarizing documents**: "Summarize this PDF/report/document" — first convert to markdown, then use the extracted content for summarization
  ```bash
  content=$(docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < document.pdf)
  # Then feed $content to your summarization prompt
  ```

- **Analyzing contracts/agreements**: "Extract key terms from this PDF", "read the contract"
  ```bash
  docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < contract.pdf
  ```

- **Processing uploaded files**: When users upload documents for analysis — convert first, then reason over the markdown

- **Batch document processing**: Convert multiple files in a loop for indexing or analysis
  ```bash
  for f in *.pdf; do
    docker run --rm -i ghcr.io/opentechil/markitdown-for-ai:latest < "$f" > "${f%.pdf}.md"
  done
  ```

- **RAG/embedding pipelines**: "Prepare documents for vector storage" — convert documents to markdown for chunking and embedding

### Examples

| User Request | Action |
|--------------|--------|
| "Read this PDF for me" | Convert PDF to markdown and display content |
| "What's in this Word doc?" | Convert DOCX to markdown and summarize |
| "Extract the table from this Excel file" | Convert XLSX — tables are preserved in markdown format |
| "Convert this webpage to markdown" | Convert HTML to markdown |
| "Summarize the presentation" | Convert PPTX slides to markdown |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Using `{owner}` placeholder | Use `ghcr.io/opentechil/markitdown-for-ai:latest` |
| Forgetting `-i` flag for stdin | Always add `-i` when piping |
| Mounting wrong path | Use `$(pwd)` and `-w /data` together |
| Expecting Docker to find relative paths without mount | Mount with `-v "$(pwd):/data"` |
