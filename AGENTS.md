# AGENTS.md

This document provides guidance for AI agents working on this project.

## Project Overview

MarkItDown Docker image - A containerized version of Microsoft's markitdown library for converting documents (PDF, DOCX, PPTX, XLSX, HTML) to Markdown.

## Conventional Commits

This project uses [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Code style (formatting, no logic change) |
| `refactor` | Code refactoring |
| `test` | Adding/updating tests |
| `chore` | Maintenance, deps, build changes |

### Examples

```bash
git commit -m "feat: add support for stdin input"
git commit -m "fix: resolve permission issue with non-root user"
git commit -m "docs: update README with new CLI examples"
```

## Release Process

When committing changes, always:

1. **Update CHANGELOG.md** - Add entry under `[Unreleased]` section:
   - Use appropriate type: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`
   - Be descriptive but concise

2. **Update version in CHANGELOG.md** - When releasing:
   - Move `[Unreleased]` changes to new `[X.Y.Z]` section with date
   - Update version links at bottom

3. **Update README.md** - If changes affect:
   - New features or commands
   - New environment variables
   - Build instructions
   - Usage examples

4. **Tag release** - For new versions:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push --tags
   ```

## Docker Image Publishing

The GitHub Actions workflow (`.github/workflows/docker.yml`) automatically:
- Builds and pushes to GHCR on push to main
- Creates multi-platform images (amd64, arm64)

No manual Docker push needed - CI/CD handles it.

## Quick Reference

| Command | Description |
|---------|-------------|
| `docker build -t markitdown-for-ai .` | Build locally |
| `docker run --rm -i markitdown-for-ai < file.pdf` | Convert file via stdin |
| `cat file.docx \| docker run --rm -i markitdown-for-ai` | Pipe content |