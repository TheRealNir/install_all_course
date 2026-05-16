#!/usr/bin/env bash
set -e

REPO_RAW_BASE="https://raw.githubusercontent.com/TheRealNir/install_all_course/main"

echo "🚀 Starting install_all_course installer for macOS..."

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL "$REPO_RAW_BASE/mac/src/installer.sh" -o "$TMP_DIR/installer.sh"
chmod +x "$TMP_DIR/installer.sh"

bash "$TMP_DIR/installer.sh"
