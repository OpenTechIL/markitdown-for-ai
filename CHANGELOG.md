# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-04-16

### Added
- Dockerfile with Python 3.10-slim base image
- Support for markitdown[pdf,docx,pptx,xlsx] conversion
- Non-root user for security
- Stdin input support for CLI usage
- GitHub Actions workflow for GHCR multi-platform builds (amd64, arm64)
- OpenCode skill for document-to-markdown conversion
- README.md with English documentation

### Fixed
- Docker build size optimized with multi-stage build

### Security
- Runs as non-root user (appuser:appuser)
- Minimal dependencies (no OCR, no LLM dependencies)

[Unreleased]: https://github.com/OpenTechIL/markitdown-for-ai/compare/v1.0.0...main
[1.0.0]: https://github.com/OpenTechIL/markitdown-for-ai/releases/v1.0.0