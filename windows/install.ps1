# Claude Code + Cursor Installer for Windows
# Run with:
# irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/install.ps1" | iex

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================"
Write-Host " install_all_course Installer for Windows"
Write-Host "============================================"
Write-Host ""

function Command-Exists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Install-With-Winget {
    param(
        [string]$Id,
        [string]$Name
    )

    Write-Host "📦 Installing $Name..."
    winget install -e --id $Id --accept-package-agreements --accept-source-agreements
}

if (-not (Command-Exists winget)) {
    Write-Host "❌ winget is not available on this PC."
    Write-Host "Please install App Installer from Microsoft Store, then run this script again."
    exit 1
}

Write-Host "📦 Installing Git..."
if (-not (Command-Exists git)) {
    Install-With-Winget -Id "Git.Git" -Name "Git"
} else {
    Write-Host "✅ Git already installed."
}

Write-Host ""
Write-Host "📦 Installing Cursor..."
Install-With-Winget -Id "Anysphere.Cursor" -Name "Cursor"

Write-Host ""
Write-Host "📦 Installing nvm-windows..."
if (-not (Command-Exists nvm)) {
    Install-With-Winget -Id "CoreyButler.NVMforWindows" -Name "nvm-windows"
    Refresh-Path
} else {
    Write-Host "✅ nvm already installed."
}

Refresh-Path

Write-Host ""
Write-Host "📦 Installing Node.js LTS..."
nvm install lts
nvm use lts
Refresh-Path

Write-Host ""
Write-Host "📦 Updating npm..."
npm install -g npm@latest

Write-Host ""
Write-Host "📦 Installing Bun..."
if (-not (Command-Exists bun)) {
    powershell -c "irm bun.sh/install.ps1 | iex"
    Refresh-Path
} else {
    Write-Host "✅ Bun already installed."
}

Write-Host ""
Write-Host "📦 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

Write-Host ""
Write-Host "📦 Trying to install Claude Code extension in Cursor..."
Refresh-Path

if (Command-Exists cursor) {
    cursor --install-extension anthropic.claude-code
} else {
    Write-Host "⚠️ Cursor CLI command not found yet. Open Cursor once, then try installing extensions manually if needed."
}

Write-Host ""
Write-Host "============================================"
Write-Host " ✅ Installation completed"
Write-Host "============================================"
Write-Host ""
Write-Host "Close and reopen PowerShell, then check:"
Write-Host "node --version"
Write-Host "npm --version"
Write-Host "bun --version"
Write-Host "git --version"
Write-Host "claude --version"
Write-Host ""
Write-Host "Then run:"
Write-Host "claude"
Write-Host ""
