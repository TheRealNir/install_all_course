param(
    [Alias("debug")]
    [switch]$DebugMode
)

$ErrorActionPreference = "Stop"

if ($DebugMode) {
    Set-PSDebug -Trace 1
}

$RepoRawBase = "https://raw.githubusercontent.com/TheRealNir/install_all_course/main"
$TempDir = Join-Path $env:TEMP ("install_all_course_" + [Guid]::NewGuid().ToString("N"))
$InstallerPath = Join-Path $TempDir "installer.ps1"

Write-Host "Starting Install All Course installer for Windows..."

New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

try {
    Invoke-RestMethod "$RepoRawBase/windows/src/installer.ps1" -OutFile $InstallerPath

    if ($DebugMode) {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $InstallerPath -DebugMode
    } else {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $InstallerPath
    }
} finally {
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
