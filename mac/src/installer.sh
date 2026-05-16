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
error() { printf "${RED}✗${NC} %s\n" " $1"; }

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

add_line_if_missing() {
  local file="$1"
  local line="$2"
  touch "$file"
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

detect_shell_profile() {
  if [[ "${SHELL:-}" == *"zsh"* ]]; then
    echo "$HOME/.zshrc"
  else
    echo "$HOME/.bash_profile"
  fi
}

load_homebrew() {
  if command_exists brew; then
    return
  fi

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

PROFILE_FILE="$(detect_shell_profile)"

echo ""
echo "============================================"
echo " Install All Course Installer for macOS"
echo "============================================"
echo ""

trap 'error "Installation failed. Rerun with --debug for more details."; exit 1' ERR

info "Checking Xcode Command Line Tools"
if xcode-select -p >/dev/null 2>&1; then
  success "Xcode Command Line Tools already installed."
else
  info "Opening Xcode Command Line Tools installer"
  xcode-select --install || true
  warn "If a popup opened, finish the Xcode install, then run this script again."
fi

info "Checking Homebrew"
load_homebrew
if command_exists brew; then
  success "Homebrew already installed."
else
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_homebrew

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    add_line_if_missing "$PROFILE_FILE" 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  elif [[ -x "/usr/local/bin/brew" ]]; then
    add_line_if_missing "$PROFILE_FILE" 'eval "$(/usr/local/bin/brew shellenv)"'
  fi
  success "Homebrew installed."
fi

if ! command_exists brew; then
  error "Homebrew is required but was not found after installation."
  exit 1
fi

info "Checking Git"
if command_exists git; then
  success "Git already installed."
else
  brew install git
  success "Git installed."
fi

info "Checking Cursor"
if [[ -d "/Applications/Cursor.app" ]] || command_exists cursor; then
  success "Cursor already installed."
else
  brew install --cask cursor
  success "Cursor installed."
fi

info "Checking nvm"
if [[ -d "$HOME/.nvm" ]]; then
  success "nvm already installed."
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  success "nvm installed."
fi

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  . "$NVM_DIR/nvm.sh"
else
  error "nvm was not found at $NVM_DIR/nvm.sh"
  exit 1
fi

info "Installing Node.js LTS"
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
success "Node.js LTS is ready."

info "Updating npm"
npm install -g npm@latest
success "npm is up to date."

info "Checking Bun"
if command_exists bun; then
  success "Bun already installed."
else
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  add_line_if_missing "$PROFILE_FILE" 'export BUN_INSTALL="$HOME/.bun"'
  add_line_if_missing "$PROFILE_FILE" 'export PATH="$BUN_INSTALL/bin:$PATH"'
  success "Bun installed."
fi

info "Installing Claude Code"
npm install -g @anthropic-ai/claude-code
success "Claude Code installed."

info "Configuring Git defaults"
git config --global init.defaultBranch main
git config --global pull.rebase false
success "Git defaults configured."

info "Trying to install Claude Code extension in Cursor"
if command_exists cursor; then
  cursor --install-extension anthropic.claude-code || warn "Cursor extension install failed. You can install it manually from Cursor."
else
  warn "Cursor CLI command not found. Open Cursor once and enable the shell command if needed."
fi

echo ""
echo "============================================"
success "Installation completed"
echo "============================================"
echo ""
echo "Close and reopen Terminal, then run:"
echo "node --version"
echo "npm --version"
echo "bun --version"
echo "git --version"
echo "claude --version"
echo ""
echo "Then run:"
echo "claude"
echo ""
