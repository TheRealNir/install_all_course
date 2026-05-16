#!/usr/bin/env bash
set -e

REPO_RAW_BASE="https://raw.githubusercontent.com/TheRealNir/install_all_course/main"
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

echo "🧹 Starting install_all_course uninstaller for macOS..."

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL "$REPO_RAW_BASE/mac/src/uninstaller.sh" -o "$TMP_DIR/uninstaller.sh"
chmod +x "$TMP_DIR/uninstaller.sh"

bash "$TMP_DIR/uninstaller.sh" "$@"
