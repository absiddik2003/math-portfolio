#!/bin/bash
cd "$(dirname "$0")"

echo "==================================================="
echo "              MATH PORTFOLIO SYNC"
echo "==================================================="
echo ""

echo "[1/3] Detecting and staging all new files..."
git add -A
git status --short

echo ""
if ! git diff --cached --quiet; then
    echo "[2/3] Committing changes..."
    git commit -m "Portfolio update: $(date)"
else
    echo "[2/3] No new file changes detected to commit."
fi

echo ""
echo "[3/3] Uploading to GitHub (please do not close window)..."
git push --progress origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "==================================================="
    echo "          Sync completed successfully!"
    echo "==================================================="
else
    echo ""
    echo "==================================================="
    echo "       Sync failed! Check error message above."
    echo "==================================================="
fi
