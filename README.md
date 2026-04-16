# MarkItDown Docker Image

MarkItDown is a Python tool that converts various document formats to Markdown. This Docker image provides a portable, easy-to-use containerized version that works out of the box.

## What is MarkItDown?

MarkItDown converts documents from popular formats into clean Markdown text. It preserves document structure including tables, lists, headings, and basic formatting, making it ideal for content extraction, documentation processing, and workflow automation.

## Supported Formats

- **PDF** - Portable Document Format
- **DOCX** - Microsoft Word documents
- **PPTX** - Microsoft PowerPoint presentations
- **XLSX** - Microsoft Excel spreadsheets
- **HTML** - Web pages and HTML documents

## Installation

Pull the latest image from GitHub Container Registry:

```bash
docker pull ghcr.io/{owner}/markitdown-for-ai
```

## Usage

### Convert a file

```bash
docker run --rm -i ghcr.io/{owner}/markitdown-for-ai < input.pdf
```

### Convert via pipe

```bash
cat file.docx | docker run --rm -i ghcr.io/{owner}/markitdown-for-ai
```

### Specify output file

```bash
docker run --rm ghcr.io/{owner}/markitdown-for-ai input.pdf -o output.md
```

### Interactive mode

```bash
docker run --rm -it ghcr.io/{owner}/markitdown-for-ai
```

Then enter file content via stdin and press Ctrl+D when done.

## GitHub Actions Integration

This Docker image is automatically built and published using GitHub Actions. The workflow:

1. Builds the Docker image on every push to main
2. Runs tests to verify the image works correctly
3. Publishes the image to GitHub Container Registry (ghcr.io)
4. Creates version tags for releases

The CI/CD pipeline ensures the image is always up to date with the latest MarkItDown dependencies and security patches.

## Multi-Platform Support

The Docker image supports multiple architectures:
- **amd64** - x86_64 (standard desktop and server)
- **arm64** - ARM 64-bit (Apple Silicon, ARM servers)

This means the image runs natively on:
- Linux servers (x86 and ARM)
- macOS (Intel and Apple Silicon via Rosetta 2)
- Windows with Docker Desktop

## Development

To build the image locally:

```bash
docker build -t markitdown-for-ai .
```

To test locally:

```bash
docker run --rm -i markitdown-for-ai < test.pdf
```

## License

This project is licensed under the terms included in the LICENSE file.