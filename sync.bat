@echo off
cd /d "%~dp0"
echo Staging changes...
git add .
echo Committing changes...
git commit -m "Portfolio update: %date% %time%"
echo Pushing to GitHub...
git push origin main
echo.
echo Sync completed successfully!
timeout /t 3