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

function Command-Exists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

Write-Host ""
Write-Host "============================================"
Write-Host " Install All Course Uninstaller for Windows"
Write-Host "============================================"
Write-Host ""

try {
    Refresh-Path

    Write-Info "Removing Claude Code global npm package"
    if (Command-Exists npm) {
        npm uninstall -g @anthropic-ai/claude-code
    } else {
        Write-WarningMessage "npm not found. Skipping Claude Code removal."
    }

    Write-Info "Removing Bun"
    $bunFolder = Join-Path $env:USERPROFILE ".bun"
    if (Test-Path $bunFolder) {
        Remove-Item -Path $bunFolder -Recurse -Force -ErrorAction SilentlyContinue
        Write-Success "Removed $bunFolder."
    } else {
        Write-WarningMessage "Bun folder was not found."
    }

    Write-Info "Removing Cursor"
    if (Command-Exists winget) {
        winget uninstall -e --id Anysphere.Cursor --accept-source-agreements
    } else {
        Write-WarningMessage "winget not found. Remove Cursor manually from Windows Settings if needed."
    }

    Write-Host ""
    Write-WarningMessage "nvm and Node.js were not removed automatically."
    Write-Host "If you are sure you want to remove them later, review your nvm installation first."
    Write-WarningMessage "No user projects or personal files were deleted."
    Write-Host ""
    Write-Success "Uninstall completed."
} catch {
    Write-Host "Uninstall finished with a warning:"
    Write-Host $_.Exception.Message
    exit 1
}
