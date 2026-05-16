# macOS Installer

This folder contains the macOS installer for Install All Course.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash
```

Debug mode:

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash -s -- --debug
```

## What It Does

- Installs Xcode Command Line Tools if missing
- Installs Homebrew if missing
- Installs Git if missing
- Installs Cursor if missing
- Installs nvm if missing
- Installs Node.js LTS
- Updates npm
- Installs Bun if missing
- Installs Claude Code globally
- Tries to install the Claude Code extension in Cursor
- Configures Git defaults for course work

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/uninstall.sh | bash
```

The uninstaller does not remove Xcode Command Line Tools and does not delete projects or personal files.
