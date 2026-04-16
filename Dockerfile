# Stage 1: Builder
FROM python:3.10-slim AS builder

WORKDIR /build

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install markitdown with required extras (NOT [all] to avoid OCR dependencies)
RUN pip install --no-cache-dir "markitdown[pdf,docx,pptx,xlsx]"


# Stage 2: Runtime
FROM python:3.10-slim

# Create non-root user for security
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application files
COPY --chown=appuser:appgroup . /app

# Switch to non-root user
USER appuser

# Copy entrypoint script
COPY --chown=appuser:appgroup entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint to run the script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]