#!/usr/bin/env bash
set -euo pipefail

DEBUG="false"
for arg in "$@"; do
  case "$arg" in
    --debug|-d)
      DEBUG="true"
      ;;
  esac
done

if [[ "$DEBUG" == "true" ]]; then
  set -x
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { printf "${BLUE}==>${NC} %s\n" "$1"; }
success() { printf "${GREEN}✓${NC} %s\n" " $1"; }
warn() { printf "${YELLOW}!${NC} %s\n" " $1"; }

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo ""
echo "============================================"
echo " Install All Course Uninstaller for macOS"
echo "============================================"
echo ""

info "Removing Claude Code global npm package"
if command_exists npm; then
  npm uninstall -g @anthropic-ai/claude-code || warn "Claude Code was not installed globally or could not be removed."
else
  warn "npm not found. Skipping Claude Code removal."
fi

info "Removing Bun"
if [[ -d "$HOME/.bun" ]]; then
  rm -rf "$HOME/.bun"
  success "Removed $HOME/.bun."
else
  warn "Bun folder was not found."
fi

info "Removing Cursor"
if command_exists brew; then
  brew uninstall --cask cursor || warn "Cursor was not installed with Homebrew or could not be removed."
elif [[ -d "/Applications/Cursor.app" ]]; then
  warn "Cursor exists in /Applications, but Homebrew is not available. Remove Cursor.app manually if you want to uninstall it."
else
  warn "Cursor was not found."
fi

echo ""
warn "nvm and Node.js were not removed automatically."
echo "If you are sure you want to remove them later, review these folders first:"
echo "$HOME/.nvm"
echo ""
warn "Xcode Command Line Tools were not removed."
warn "No user projects or personal files were deleted."
echo ""
success "Uninstall completed."
