# Install All Course - One Click Development Setup

One-click installer for my course students. It installs the full development environment needed for the course.

The scripts are intentionally simple, readable, and safe to rerun. They install Cursor, not VS Code.

> Important: students should only run scripts from a GitHub repo they trust.

## Quick Start

### macOS

Open Terminal, paste this command, and press Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash
```

### Windows

Open PowerShell, paste this command, and press Enter:

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/install.bat" -OutFile install.bat; .\install.bat
```

If Windows asks for permission, approve it. If installation fails because of permissions, reopen PowerShell as Administrator and run the command again.

## What Gets Installed

- Cursor
- Git
- Node.js LTS
- npm
- Bun
- Claude Code
- Claude Code Cursor extension if available

## After Installation

Close and reopen Terminal or PowerShell, then run:

```bash
node --version
npm --version
bun --version
git --version
claude --version
```

Then start Claude Code:

```bash
claude
```

## Debug Mode

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash -s -- --debug
```

### Windows

```powershell
.\install.bat -debug
```

## Troubleshooting

- If the Cursor command is not found, open Cursor once and enable or install the shell command manually if needed.
- If Windows blocks script execution, open PowerShell as Administrator and run the install command again.
- If macOS asks for a password during Homebrew install, use your Mac login password.
- If installation fails, rerun the command. The installer is idempotent and skips tools that are already installed.
- Make sure you have a stable internet connection during installation.

## Uninstall

The uninstallers remove course tools where possible and avoid deleting user projects or personal files.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/uninstall.sh | bash
```

### Windows

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/uninstall.bat" -OutFile uninstall.bat; .\uninstall.bat
```

## Platform Details

- [macOS README](mac/README.md)
- [Windows README](windows/README.md)

## Safety Notes

- No telemetry is added.
- No data is sent to this repository.
- The scripts do not delete user projects.
- Node.js and nvm are not removed automatically by uninstallers.
- Xcode Command Line Tools are not removed by the macOS uninstaller.
