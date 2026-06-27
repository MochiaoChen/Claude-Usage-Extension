#!/bin/bash
set -e

# Build dataclasses
echo "Building dataclasses..."
node scripts/build-dataclasses.js

# Create dist dir
mkdir -p dist

# Chrome build
if [ -f manifest_chrome.json ]; then
    echo "Building Chrome extension..."
    cp manifest_chrome.json manifest.json
    npx -y web-ext build --filename "{name}-{version}-chrome.zip" -o --artifacts-dir dist
    rm -f manifest.json
fi

# Firefox build
if [ -f manifest_firefox.json ]; then
    echo "Building Firefox extension..."
    cp manifest_firefox.json manifest.json
    npx -y web-ext build --filename "{name}-{version}-firefox.zip" -o --artifacts-dir dist
    rm -f manifest.json
fi

# Electron build
if [ -f manifest_electron.json ]; then
    echo "Building Electron extension..."
    cp manifest_electron.json manifest.json
    npx -y web-ext build --filename "{name}-{version}-electron.zip" -o --artifacts-dir dist
    rm -f manifest.json
fi

echo "All builds completed."
