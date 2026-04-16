# MarkItDown Docker - Work Plan

## TL;DR

> **Quick Summary**: Create a Docker image for Microsoft MarkItDown that converts documents (docx, pptx, pdf, xlsx, html) to Markdown without OCR or LLM dependencies. Includes GitHub Actions for GHCR publishing, OpenCode skill, and README.

> **Deliverables**:
> - `Dockerfile` - Multi-stage build with Python 3.10-slim
> - `.dockerignore` - Exclude unnecessary files
> - `.github/workflows/docker.yml` - CI/CD to build and push to GHCR
> - `.opencode/skills/document-to-markdown/SKILL.md` - OpenCode skill
> - `README.md` - English documentation

> **Estimated Effort**: Short
> **Parallel Execution**: YES - 2 waves
> **Critical Path**: Dockerfile → GitHub Actions → README

---

## Context

### Original Request
User wants to create a Docker image for Microsoft MarkItDown library to enable:
```bash
docker run --rm -i markitdown:latest < ~/your-file.pdf > output.md
```

Requirements:
- Support: docx, pptx, pdf, xlsx, html
- NO OCR (disabled)
- NO LLM connection
- GitHub Actions to build and push to GHCR
- OpenCode skill for document-to-markdown
- README.md in English

### Research Findings
- MarkItDown requires Python 3.10+
- Use specific extras: `markitdown[pdf,docx,pptx,xlsx]` (NOT `[all]` which includes OCR)
- CLI supports stdin: `cat file.pdf | markitdown`
- Base image: `python:3.10-slim` for minimal size

---

## Work Objectives

### Core Objective
Build a production-ready Docker image for MarkItDown that converts documents to Markdown via CLI, with automated CI/CD and documentation.

### Concrete Deliverables
1. `Dockerfile` - Working Docker image definition
2. `.github/workflows/docker.yml` - GitHub Actions workflow
3. `.opencode/skills/document-to-markdown/SKILL.md` - OpenCode skill
4. `README.md` - Installation and usage documentation

### Definition of Done
- [ ] `docker build -t markitdown:latest .` succeeds
- [ ] `docker run --rm -i markitdown:latest < test.pdf > test.md` works
- [ ] GitHub Actions runs on push to main
- [ ] Image pushes to ghcr.io/{owner}/markitdown:latest
- [ ] OpenCode skill is discoverable and loads
- [ ] README shows all usage examples

### Must Have
- Docker image with markitdown CLI
- Non-root user for security
- Multi-platform support (amd64, arm64)
- GitHub Actions workflow for automatic builds

### Must NOT Have
- OCR dependencies (no `[all]` extra)
- LLM dependencies
- Unnecessary bloat in image

---

## Verification Strategy

### Test Decision
- **Infrastructure**: No existing test infrastructure
- **Automated tests**: None (Docker build is the verification)
- **QA**: Agent-executed via Docker commands

### QA Policy
Every task includes agent-executed verification. No human intervention required.

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Foundation - can run in parallel):
├── T1: Create Dockerfile with Python slim base
├── T2: Create .dockerignore
└── T3: Create entrypoint script

Wave 2 (Integration + Docs):
├── T4: Create GitHub Actions workflow
├── T5: Create OpenCode skill (SKILL.md)
└── T6: Create README.md

Wave 3 (Final - verification):
└── T7: Local Docker build test
```

### Dependency Matrix
- T1: - - T7
- T2: T1 - T7
- T3: T1 - T7
- T4: T1, T2, T3 - -
- T5: T1 - -
- T6: T1, T4 - -
- T7: T1, T2, T3 - -

---

## TODOs

- [x] 1. Create Dockerfile

  **What to do**:
  - Use `python:3.10-slim` as base image
  - Install only required dependencies: `markitdown[pdf,docx,pptx,xlsx]`
  - Do NOT install `[all]` - that includes OCR
  - Create non-root user for security
  - Set working directory and entrypoint

  **Must NOT do**:
  - Install OCR dependencies
  - Install LLM dependencies
  - Use root user

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []
  - Reason: Simple single-file task

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 1)
  - **Parallel Group**: Wave 1 (with T2, T3)

  **References**:
  - `https://hub.docker.com/_/python` - Python slim images
  - Research: MarkItDown pip install with specific extras

  **Acceptance Criteria**:
  - [ ] Dockerfile created
  - [ ] Uses python:3.10-slim
  - [ ] Installs markitdown[pdf,docx,pptx,xlsx]
  - [ ] Non-root user configured

  **QA Scenarios**:
  - None needed - T7 verifies full build

  **Commit**: YES
  - Message: `feat(docker): add Dockerfile for markitdown`
  - Files: `Dockerfile`

---

- [x] 2. Create .dockerignore

  **What to do**:
  - Exclude .git directory
  - Exclude .github (we'll reference workflow separately)
  - Exclude README.md and initial.md
  - Exclude any local test files

  **Must NOT do**:
  - Exclude files needed for Docker build

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 1)
  - **Parallel Group**: Wave 1 (with T1, T3)

  **References**:
  - Standard .dockerignore patterns

  **Acceptance Criteria**:
  - [ ] .dockerignore exists

  **Commit**: YES (group with T1)
  - Files: `.dockerignore`

---

- [x] 3. Create entrypoint script

  **What to do**:
  - Create `/usr/local/bin/entrypoint.sh`
  - Make it executable
  - Run `markitdown` command with any arguments
  - Handle stdin input properly

  **Must NOT do**:
  - Add complex logic

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 1)
  - **Parallel Group**: Wave 1 (with T1, T2)

  **References**:
  - Research: markitdown CLI supports stdin

  **Acceptance Criteria**:
  - [ ] Entrypoint script created and executable
  - [ ] Properly calls markitdown

  **Commit**: YES (group with T1)
  - Files: `entrypoint.sh`

---

- [x] 4. Create GitHub Actions workflow

  **What to do**:
  - Create `.github/workflows/docker.yml`
  - Trigger on: push to main, tags (v*), and PRs
  - Use docker/build-push-action
  - Support multi-platform: amd64, arm64
  - Push to ghcr.io
  - Tag as: latest, and version tag

  **Must NOT do**:
  - Break on non-Dockerfile changes

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 2)
  - **Parallel Group**: Wave 2 (with T5, T6)

  **References**:
  - GitHub Actions documentation for Docker builds

  **Acceptance Criteria**:
  - [ ] Workflow file created
  - [ ] Builds on push to main
  - [ ] Builds on version tags
  - [ ] Pushes to GHCR

  **Commit**: YES (group with T1)
  - Files: `.github/workflows/docker.yml`

---

- [x] 5. Create OpenCode skill

  **What to do**:
  - Create `.opencode/skills/document-to-markdown/SKILL.md`
  - Add YAML frontmatter with name, description
  - Explain how to use the Docker image
  - Include usage examples

  **Must NOT do**:
  - Include unnecessary details

  **Recommended Agent Profile**:
  - **Category**: `writing`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 2)
  - **Parallel Group**: Wave 2 (with T4, T6)

  **References**:
  - OpenCode skills documentation from research

  **Acceptance Criteria**:
  - [ ] Skill file created
  - [ ] Has valid frontmatter
  - [ ] Explains Docker usage

  **Commit**: YES
  - Message: `feat(skill): add opencode skill for document-to-markdown`
  - Files: `.opencode/skills/document-to-markdown/SKILL.md`

---

- [x] 6. Create README.md

  **What to do**:
  - Create `README.md` in English
  - Include: What is this, Installation, Usage examples
  - Document all supported formats
  - Show Docker commands
  - Explain GitHub Actions flow

  **Must NOT do**:
  - Write in Hebrew (user requested English)

  **Recommended Agent Profile**:
  - **Category**: `writing`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (Wave 2)
  - **Parallel Group**: Wave 2 (with T4, T5)

  **References**:
  - Standard Docker READMEs

  **Acceptance Criteria**:
  - [ ] README.md created in English
  - [ ] Shows Docker usage
  - [ ] Lists supported formats

  **Commit**: YES
  - Message: `docs: add README.md`
  - Files: `README.md`

---

- [x] 7. Local Docker build test

  **What to do**:
  - Run `docker build -t markitdown:test .`
  - Test CLI: `docker run --rm -i markitdown:test < any-test-file.pdf`
  - Verify output is Markdown

  **Must NOT do**:
  - Modify files after successful test

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: NO (final verification)
  - **Blocked By**: T1, T2, T3

  **References**:
  - Previous task outputs

  **Acceptance Criteria**:
  - [ ] Docker build succeeds
  - [ ] CLI works with test file

  **Commit**: NO
  - Pre-commit: none

---

## Final Verification Wave

- [x] F1. **Plan Compliance Audit** — `oracle`
  Verify all deliverables exist: Dockerfile, .dockerignore, entrypoint.sh, GitHub workflow, OpenCode skill, README.

- [x] F2. **Docker Build Test** — `quick`
  Run docker build and verify it completes without errors.

- [x] F3. **Docker CLI Test** — `quick`
  Test the CLI with a sample document file.

- [x] F4. **Documentation Review** — `quick`
  Verify README is in English and contains all required sections.

---

## Commit Strategy

- **1**: `feat(docker): add Dockerfile and entrypoint` - Dockerfile, .dockerignore, entrypoint.sh, .github/workflows/docker.yml
- **2**: `feat(skill): add OpenCode document-to-markdown skill` - .opencode/skills/document-to-markdown/SKILL.md
- **3**: `docs: add README.md` - README.md

---

## Success Criteria

### Verification Commands
```bash
docker build -t markitdown:latest .
docker run --rm -i markitdown:latest < test.pdf > test.md
```

### Final Checklist
- [ ] Dockerfile exists and builds
- [ ] GitHub Actions workflow created
- [ ] OpenCode skill created with valid frontmatter
- [ ] README.md in English
- [ ] All commits follow conventional commit format