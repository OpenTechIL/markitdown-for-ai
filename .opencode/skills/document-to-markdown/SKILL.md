---
name: document-to-markdown
description: Convert documents (docx, pptx, pdf, xlsx, html) to Markdown using Docker
---

# Document to Markdown Conversion

Use this skill when you need to convert various document formats to Markdown.

## Usage

### Basic Conversion

Convert a single document:

```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown input.docx
```

### Supported Formats

| Format | Extension | Example |
|--------|-----------|---------|
| Word | .docx | `document.docx` |
| PowerPoint | .pptx | `presentation.pptx` |
| PDF | .pdf | `document.pdf` |
| Excel | .xlsx | `spreadsheet.xlsx` |
| HTML | .html | `page.html` |

### Examples

**Convert a Word document:**
```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown report.docx
```

**Convert a PDF:**
```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown manual.pdf
```

**Convert a PowerPoint presentation:**
```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown slides.pptx
```

**Convert an Excel spreadsheet:**
```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown data.xlsx
```

**Convert an HTML file:**
```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown page.html
```

### Output

The converted Markdown content is printed to stdout. To save to a file:

```bash
docker run -v $(pwd):/data ghcr.io/{owner}/markitdown input.docx > output.md
```