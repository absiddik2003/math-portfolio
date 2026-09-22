@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

:: 1. Auto-detect Git and temporarily add it to PATH if missing
where git >nul 2>&1
if errorlevel 1 (
    if exist "C:\Program Files\Git\cmd" set "PATH=%PATH%;C:\Program Files\Git\cmd"
    if exist "%LOCALAPPDATA%\Programs\Git\cmd" set "PATH=%PATH%;%LOCALAPPDATA%\Programs\Git\cmd"
    if exist "C:\Program Files (x86)\Git\cmd" set "PATH=%PATH%;C:\Program Files (x86)\Git\cmd"
)

:: Verify Git is accessible
where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or not found in standard paths.
    echo Please install Git or add it to your Windows Environment Variables.
    echo.
    pause
    exit /b 1
)

echo ===================================================
echo                MATH PORTFOLIO SYNC
echo ===================================================
echo.

:: 2. Bail out early if this isn't run inside a git repo
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: This folder is not a git repository.
    echo Make sure this .bat file lives inside your portfolio repo.
    echo.
    pause
    exit /b 1
)

echo [1/4] Ensuring empty folders are tracked...
powershell -NoProfile -Command "foreach ($d in (Get-ChildItem -Directory -Recurse -Force)) { if ($d.FullName -notmatch '(^|\\)\.git(\\|$)' -and (Get-ChildItem -LiteralPath $d.FullName -Force).Count -eq 0) { New-Item -ItemType File -Path (Join-Path $d.FullName '.gitkeep') -Force | Out-Null } }"

echo.
echo [2/4] Detecting and staging new or modified files...
git add -A
git status --short

echo.
git diff --cached --quiet
if errorlevel 1 (
    for /f "delims=" %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "TIMESTAMP=%%i"
    echo [3/4] Committing changes...
    git commit -m "Portfolio update: !TIMESTAMP!"
) else (
    echo [3/4] No new changes to commit.
)

echo.
echo [4/4] Uploading to GitHub (please do not close window)...
git push --progress origin main

if %errorlevel% equ 0 (
    echo.
    echo ===================================================
    echo            Sync completed successfully!
    echo ===================================================
) else (
    echo.
    echo ===================================================
    echo        Sync failed! Please check the error above.
    echo ===================================================
)

echo.
echo Press any key to close this window...
pause >nul
endlocal