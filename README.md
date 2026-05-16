# install_all_course

A simple installer for students that sets up a beginner-friendly AI development environment.

It installs:

- Cursor
- Git
- Node.js LTS
- npm
- Bun
- Claude Code
- Claude Code extension for Cursor, when supported by the local Cursor CLI

> Important: students should only run scripts from a GitHub repo they trust.

---

## macOS install

Run this in Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash
```

---

## Windows install

Open PowerShell as regular user and run:

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/install.ps1" | iex
```

---

## What the installer does

### macOS

- Installs Xcode Command Line Tools, if missing
- Installs Homebrew, if missing
- Installs Git
- Installs Cursor
- Installs nvm
- Installs Node.js LTS
- Updates npm
- Installs Bun
- Installs Claude Code
- Tries to install the Claude Code extension in Cursor

### Windows

- Installs Git using winget
- Installs Cursor using winget
- Installs nvm-windows using winget
- Installs Node.js LTS through nvm
- Updates npm
- Installs Bun
- Installs Claude Code
- Tries to install the Claude Code extension in Cursor

---

## After installation

Students should restart their terminal and run:

```bash
node --version
npm --version
bun --version
git --version
claude --version
```

Then open Cursor and run:

```bash
claude
```

---

## Safety note

This repo is intentionally simple and readable. Before sharing it with students, review the scripts yourself.
