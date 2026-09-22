@echo off
cd /d "%~dp0"
echo ===================================================
echo               MATH PORTFOLIO SYNC
echo ===================================================
echo.
echo [1/4] Ensuring empty folders are tracked...
powershell -NoProfile -Command "Get-ChildItem -Directory -Recurse | Where-Object { $_.FullName -notmatch '\\.git' -and (Get-ChildItem -LiteralPath $_.FullName -Force).Count -eq 0 } | ForEach-Object { New-Item -ItemType File -Path (Join-Path $_.FullName '.gitkeep') -Force | Out-Null }"

echo [2/4] Staging changes...
git add .

echo [3/4] Committing changes...
git commit -m "Portfolio update: %date% %time%"

echo [4/4] Pushing to GitHub (large files take time, do not close window)...
git push --progress origin main

echo.
echo ===================================================
echo           Sync completed successfully!
echo ===================================================
echo Window will close automatically in 5 seconds...
ping 127.0.0.1 -n 6 >nul