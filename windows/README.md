# Windows Installer

This folder contains the Windows installer for Install All Course.

## Install

Open PowerShell and run:

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/install.bat" -OutFile install.bat; .\install.bat
```

Debug mode:

```powershell
.\install.bat -debug
```

## What It Does

- Checks that winget is available
- Installs Git if missing
- Installs Cursor if missing
- Installs nvm-windows if missing
- Installs Node.js LTS
- Updates npm
- Installs Bun if missing
- Installs Claude Code globally
- Tries to install the Claude Code extension in Cursor
- Configures Git defaults for course work

## Uninstall

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/uninstall.bat" -OutFile uninstall.bat; .\uninstall.bat
```

The uninstaller does not delete projects or personal files. Node.js and nvm are not removed automatically.
