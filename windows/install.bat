@echo off
setlocal

set "REPO_RAW_BASE=https://raw.githubusercontent.com/TheRealNir/install_all_course/main"
set "TEMP_PS1=%TEMP%\install_all_course_install_%RANDOM%%RANDOM%.ps1"

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Invoke-RestMethod '%REPO_RAW_BASE%/windows/install.ps1' -OutFile '%TEMP_PS1%'"
if errorlevel 1 (
  echo Failed to download Windows installer.
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%TEMP_PS1%" %*
set "INSTALL_EXIT=%ERRORLEVEL%"

del "%TEMP_PS1%" >nul 2>nul

endlocal
exit /b %INSTALL_EXIT%
