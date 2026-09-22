@echo off
cd /d "%~dp0"
echo Ensuring empty folders are tracked...
powershell -NoProfile -Command "Get-ChildItem -Directory -Recurse | Where-Object { $_.FullName -notmatch '\\.git' -and (Get-ChildItem -LiteralPath $_.FullName -Force).Count -eq 0 } | ForEach-Object { New-Item -ItemType File -Path (Join-Path $_.FullName '.gitkeep') -Force | Out-Null }"

echo Staging changes...
git add .
echo Committing changes...
git commit -m "Portfolio update: %date% %time%"
echo Pushing to GitHub...
git push origin main
echo.
echo Sync completed successfully!
ping 127.0.0.1 -n 4 >nul