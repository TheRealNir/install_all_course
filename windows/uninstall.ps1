param(
    [Alias("debug")]
    [switch]$DebugMode
)

$ErrorActionPreference = "Stop"

if ($DebugMode) {
    Set-PSDebug -Trace 1
}

$RepoRawBase = "https://raw.githubusercontent.com/TheRealNir/install_all_course/main"
$TempDir = Join-Path $env:TEMP ("install_all_course_uninstall_" + [Guid]::NewGuid().ToString("N"))
$UninstallerPath = Join-Path $TempDir "uninstaller.ps1"

Write-Host "Starting Install All Course uninstaller for Windows..."

New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

try {
    Invoke-RestMethod "$RepoRawBase/windows/src/uninstaller.ps1" -OutFile $UninstallerPath

    if ($DebugMode) {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $UninstallerPath -DebugMode
    } else {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $UninstallerPath
    }
} finally {
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
