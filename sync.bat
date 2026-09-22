@echo off
setlocal EnableExtensions
cd /d "%~dp0"

:: Auto-detect and add Git to PATH if missing
where git >nul 2>&1
if errorlevel 1 (
    if exist "C:\Program Files\Git\cmd" set "PATH=%PATH%;C:\Program Files\Git\cmd"
    if exist "%LOCALAPPDATA%\Programs\Git\cmd" set "PATH=%PATH%;%LOCALAPPDATA%\Programs\Git\cmd"
    if exist "C:\Program Files (x86)\Git\cmd" set "PATH=%PATH%;C:\Program Files (x86)\Git\cmd"
)

:: Verify Git is callable before continuing
where git >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git was not found in standard installation paths.
    echo Please install Git or add it to your Windows Environment Variables.
    echo.
    pause
    exit /b 1
)

echo ===================================================
echo                MATH PORTFOLIO SYNC
echo ===================================================
echo.

echo [1/4] Ensuring empty folders are tracked...
powershell -NoProfile -Command "Get-ChildItem -Directory -Recurse | Where-Object { $_.FullName -notmatch '\\.git' -and (Get-ChildItem -LiteralPath $_.FullName -Force).Count -eq 0 } | ForEach-Object { New-Item -ItemType File -Path (Join-Path $_.FullName '.gitkeep') -Force | Out-Null }"

echo.
echo [2/4] Detecting and staging new or modified files...
git add -A
git status --short

echo.
git diff --cached --quiet
if errorlevel 1 (
    echo [3/4] Committing changes...
    git commit -m "Portfolio update: %date% %time%"
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