#!/usr/bin/env bash
# install-skill.sh — install the document-to-markdown skill for OpenCode and Claude Code
# Usage:
#   ./install-skill.sh              # Install to all default locations
#   ./install-skill.sh --local      # Install to local project only (.opencode/skills/)
#   ./install-skill.sh --global     # Install to user global only (~/.config/opencode/skills/)
#   bash <(curl -fsSL .../install-skill.sh) --local   # Remote execution with local flag
#
# AI platform flags:
#   --ai opencode    Install to ~/.config/opencode/skills/
#   --ai claude     Install to ~/.claude/skills/

set -euo pipefail

SKILL_NAME="document-to-markdown"
SKILL_SRC_URL="https://raw.githubusercontent.com/OpenTechIL/markitdown-for-ai/main/skills/document-to-markdown/SKILL.md"

# ── Parse arguments ─────────────────────────────────
INSTALL_LOCAL=false
INSTALL_GLOBAL=false
AI_PLATFORM=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --local)
      INSTALL_LOCAL=true
      shift
      ;;
    --global)
      INSTALL_GLOBAL=true
      shift
      ;;
    --ai)
      AI_PLATFORM="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --local           Install to local project (.opencode/skills/)"
      echo "  --global          Install to user global (~/.config/opencode/skills/)"
      echo "  --ai PLATFORM     Install to AI platform: opencode, claude"
      echo "  -h, --help        Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0                      # Install to all default locations"
      echo "  $0 --local              # Install to local project only"
      echo "  $0 --global             # Install to user global only"
      echo "  $0 --ai claude          # Install for Claude Code"
      echo "  $0 --local --ai opencode # Install to local project for OpenCode"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# If no flags provided, install to all locations
if [[ "$INSTALL_LOCAL" == "false" && "$INSTALL_GLOBAL" == "false" && -z "$AI_PLATFORM" ]]; then
  INSTALL_LOCAL=true
  INSTALL_GLOBAL=true
fi

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
  local label="$2"
  mkdir -p "$dir"
  echo "$SKILL_CONTENT" > "$dir/SKILL.md"
  echo "  ✓ Installed to $dir/SKILL.md"
}

INSTALLED=0

# 1. OpenCode project skills (--local)
if [[ "$INSTALL_LOCAL" == "true" ]]; then
  if [[ -d "$SCRIPT_DIR/.opencode" ]] || [[ -d "$SCRIPT_DIR" ]]; then
    install_to "$SCRIPT_DIR/.opencode/skills/$SKILL_NAME" "local"
    INSTALLED=$(( INSTALLED + 1 ))
  fi
fi

# 2. OpenCode user-global skills (--global or --ai opencode)
if [[ "$INSTALL_GLOBAL" == "true" ]] || [[ "$AI_PLATFORM" == "opencode" ]]; then
  install_to "$HOME/.config/opencode/skills/$SKILL_NAME" "global"
  INSTALLED=$(( INSTALLED + 1 ))
fi

# 3. Claude Code skills (--ai claude)
if [[ "$AI_PLATFORM" == "claude" ]]; then
  install_to "$HOME/.claude/skills/$SKILL_NAME" "claude"
  INSTALLED=$(( INSTALLED + 1 ))
fi

echo ""
echo "──────────────────────────────────────────────"
echo " Skill installed in $INSTALLED location(s)."
echo ""
echo " Usage (in any AI agent):"
echo "   skill(name='document-to-markdown')"
echo ""
echo " Or use Docker directly:"
echo "   docker run --rm -i ghcr.io/obot-ai/markitdown-for-ai < file.pdf"
echo "──────────────────────────────────────────────"
