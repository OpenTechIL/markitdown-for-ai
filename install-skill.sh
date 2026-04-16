#!/usr/bin/env bash
# install-skill.sh — install the document-to-markdown skill for OpenCode and Claude Code
# Usage:  bash <(curl -fsSL https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/install-skill.sh)
# Or locally: ./install-skill.sh

set -euo pipefail

SKILL_NAME="document-to-markdown"
SKILL_SRC_URL="https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/skills/document-to-markdown/SKILL.md"

# Resolve the local SKILL.md — prefer a sibling path so the script works both
# when run from the repo clone and when piped from curl.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
LOCAL_SKILL="$SCRIPT_DIR/.opencode/skills/$SKILL_NAME/SKILL.md"

echo "──────────────────────────────────────────────"
echo " Installing skill: $SKILL_NAME"
echo "──────────────────────────────────────────────"

# ── Fetch skill content ───────────────────────────
if [[ -f "$LOCAL_SKILL" ]]; then
  SKILL_CONTENT="$(<"$LOCAL_SKILL")"
  echo "→ Using local skill file"
else
  echo "→ Fetching skill from GitHub…"
  SKILL_CONTENT="$(curl -fsSL "$SKILL_SRC_URL")"
fi

# ── Install targets ───────────────────────────────
install_to() {
  local dir="$1"
  mkdir -p "$dir"
  echo "$SKILL_CONTENT" > "$dir/SKILL.md"
  echo "  ✓ Installed to $dir/SKILL.md"
}

INSTALLED=0

# 1. OpenCode project skills (if inside a project)
if [[ -d "$SCRIPT_DIR/.opencode" ]]; then
  install_to "$SCRIPT_DIR/.opencode/skills/$SKILL_NAME"
  INSTALLED=$(( INSTALLED + 1 ))
fi

# 2. OpenCode user-global skills
install_to "$HOME/.config/opencode/skills/$SKILL_NAME"
INSTALLED=$(( INSTALLED + 1 ))

# 3. Claude Code / Codex shared agent skills
install_to "$HOME/.agents/skills/$SKILL_NAME"
INSTALLED=$(( INSTALLED + 1 ))

# 4. Claude Code personal skills (~/.claude/skills)
install_to "$HOME/.claude/skills/$SKILL_NAME"
INSTALLED=$(( INSTALLED + 1 ))

echo ""
echo "──────────────────────────────────────────────"
echo " Skill installed in $INSTALLED location(s)."
echo ""
echo " Usage (in any AI agent):"
echo "   docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai < file.pdf"
echo ""
echo " Pull the Docker image (first time):"
echo "   docker pull ghcr.io/obot-ai/markitdown-for-ai"
echo "──────────────────────────────────────────────"
