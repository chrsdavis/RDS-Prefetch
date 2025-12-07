#!/usr/bin/env bash
#
# Script to clean up build artifacts in the olden directory
# Removes: .bc, .ll, .exe, .log
#

set -e

# Define the target directory (relative to where the script is run)
TARGET_DIR="olden"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

echo "Cleaning up artifacts in '$TARGET_DIR'..."

find "$TARGET_DIR" -type f \( \
    -name "*.bc" -o \
    -name "*.ll" -o \
    -name "*.exe" -o \
    -name "*.log" \
\) -print -delete

echo "Cleanup complete."