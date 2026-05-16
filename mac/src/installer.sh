#!/usr/bin/env bash
set -e

echo ""
echo "============================================"
echo " install_all_course Installer for macOS"
echo "============================================"
echo ""

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
  if [[ "$SHELL" == *"zsh"* ]]; then
    echo "$HOME/.zshrc"
  else
    echo "$HOME/.bash_profile"
  fi
}

PROFILE_FILE="$(detect_shell_profile)"

echo "🔍 Checking Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "⚠️ If a popup opened, finish the Xcode install, then run this script again."
else
  echo "✅ Xcode Command Line Tools already installed."
fi

echo ""
echo "🔍 Checking Homebrew..."
if ! command_exists brew; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    add_line_if_missing "$PROFILE_FILE" 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    add_line_if_missing "$PROFILE_FILE" 'eval "$(/usr/local/bin/brew shellenv)"'
  fi
else
  echo "✅ Homebrew already installed."
fi

echo ""
echo "📦 Installing Git..."
brew install git || true

echo ""
echo "📦 Installing Cursor..."
brew install --cask cursor || true

echo ""
echo "📦 Installing nvm..."
if [[ ! -d "$HOME/.nvm" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "✅ nvm already installed."
fi

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
fi

echo ""
echo "📦 Installing Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

echo ""
echo "📦 Updating npm..."
npm install -g npm@latest

echo ""
echo "📦 Installing Bun..."
if ! command_exists bun; then
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  add_line_if_missing "$PROFILE_FILE" 'export BUN_INSTALL="$HOME/.bun"'
  add_line_if_missing "$PROFILE_FILE" 'export PATH="$BUN_INSTALL/bin:$PATH"'
else
  echo "✅ Bun already installed."
fi

echo ""
echo "📦 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo ""
echo "📦 Trying to install Claude Code extension in Cursor..."
if command_exists cursor; then
  cursor --install-extension anthropic.claude-code || true
else
  echo "⚠️ Cursor CLI command not found yet. Open Cursor once, then enable the shell command from Cursor if needed."
fi

echo ""
echo "============================================"
echo " ✅ Installation completed"
echo "============================================"
echo ""
echo "Restart your terminal, then check:"
echo "node --version"
echo "npm --version"
echo "bun --version"
echo "git --version"
echo "claude --version"
echo ""
echo "Then run:"
echo "claude"
echo ""
