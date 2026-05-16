param(
    [Alias("debug")]
    [switch]$DebugMode
)

$ErrorActionPreference = "Stop"

if ($DebugMode) {
    Set-PSDebug -Trace 1
}

function Write-Info {
    param([string]$Message)
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-WarningMessage {
    param([string]$Message)
    Write-Host "! $Message" -ForegroundColor Yellow
}

function Write-ErrorMessage {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Command-Exists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Install-WithWinget {
    param(
        [string]$Id,
        [string]$Name
    )

    Write-Info "Installing $Name"
    winget install -e --id $Id --accept-package-agreements --accept-source-agreements
    Refresh-Path
}

function Test-WingetPackageInstalled {
    param([string]$Id)

    winget list -e --id $Id | Out-Null
    return $LASTEXITCODE -eq 0
}

function Install-NpmPackageGlobal {
    param(
        [string]$PackageName
    )

    npm install -g $PackageName
    Refresh-Path
}

Write-Host ""
Write-Host "============================================"
Write-Host " Install All Course Installer for Windows"
Write-Host "============================================"
Write-Host ""

try {
    if (-not (Test-IsAdmin)) {
        Write-WarningMessage "PowerShell is not running as Administrator. winget may ask for permission or fail for machine-wide installs."
    }

    if (-not (Command-Exists winget)) {
        Write-ErrorMessage "winget is not available on this PC."
        Write-Host "Install App Installer from Microsoft Store, then run this script again."
        exit 1
    }

    Write-Info "Checking Git"
    if (Command-Exists git) {
        Write-Success "Git already installed."
    } else {
        Install-WithWinget -Id "Git.Git" -Name "Git"
        Write-Success "Git installed."
    }

    Write-Info "Checking Cursor"
    if ((Command-Exists cursor) -or (Test-WingetPackageInstalled -Id "Anysphere.Cursor")) {
        Write-Success "Cursor already installed."
    } else {
        Install-WithWinget -Id "Anysphere.Cursor" -Name "Cursor"
        Write-Success "Cursor installed."
    }

    Write-Info "Checking nvm-windows"
    if (Command-Exists nvm) {
        Write-Success "nvm-windows already installed."
    } else {
        Install-WithWinget -Id "CoreyButler.NVMforWindows" -Name "nvm-windows"
        Write-Success "nvm-windows installed."
    }

    Refresh-Path

    if (-not (Command-Exists nvm)) {
        Write-ErrorMessage "nvm was installed but is not available in this PowerShell session."
        Write-Host "Close and reopen PowerShell, then rerun this installer."
        exit 1
    }

    Write-Info "Installing Node.js LTS"
    nvm install lts
    nvm use lts
    Refresh-Path
    Write-Success "Node.js LTS is ready."

    if (-not (Command-Exists npm)) {
        Write-ErrorMessage "npm is not available after installing Node.js."
        Write-Host "Close and reopen PowerShell, then rerun this installer."
        exit 1
    }

    Write-Info "Updating npm"
    npm install -g npm@latest
    Refresh-Path
    Write-Success "npm is up to date."

    Write-Info "Checking Bun"
    if (Command-Exists bun) {
        Write-Success "Bun already installed."
    } else {
        powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "irm bun.sh/install.ps1 | iex"
        Refresh-Path
        Write-Success "Bun installed."
    }

    Write-Info "Installing Claude Code"
    Install-NpmPackageGlobal -PackageName "@anthropic-ai/claude-code"
    Write-Success "Claude Code installed."

    Write-Info "Configuring Git defaults"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    Write-Success "Git defaults configured."

    Write-Info "Trying to install Claude Code extension in Cursor"
    Refresh-Path
    if (Command-Exists cursor) {
        cursor --install-extension anthropic.claude-code
    } else {
        Write-WarningMessage "Cursor CLI command not found. Open Cursor once and enable the shell command if needed."
    }

    Write-Host ""
    Write-Host "============================================"
    Write-Success "Installation completed"
    Write-Host "============================================"
    Write-Host ""
    Write-Host "Close and reopen PowerShell, then run:"
    Write-Host "node --version"
    Write-Host "npm --version"
    Write-Host "bun --version"
    Write-Host "git --version"
    Write-Host "claude --version"
    Write-Host ""
    Write-Host "Then run:"
    Write-Host "claude"
    Write-Host ""
} catch {
    Write-ErrorMessage "Installation failed."
    Write-Host $_.Exception.Message
    Write-Host "Rerun with -debug for more details."
    exit 1
}
