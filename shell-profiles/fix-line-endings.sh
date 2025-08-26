#!/bin/bash
# Fix Windows line endings for all shell scripts in the repository
# Run this if you get "bad interpreter" errors with ^M characters

echo "Fixing Windows line endings..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Method 1: Try dos2unix if available
if command -v dos2unix >/dev/null 2>&1; then
    echo "Using dos2unix to fix line endings..."
    find "$SCRIPT_DIR" -name "*.sh" -exec dos2unix {} \; 2>/dev/null
    echo "✓ Line endings fixed with dos2unix"
    exit 0
fi

# Method 2: Try sed
if command -v sed >/dev/null 2>&1; then
    echo "Using sed to fix line endings..."
    find "$SCRIPT_DIR" -name "*.sh" -exec sed -i 's/\r$//' {} \; 2>/dev/null
    echo "✓ Line endings fixed with sed"
    exit 0
fi

# Method 3: Try tr
if command -v tr >/dev/null 2>&1; then
    echo "Using tr to fix line endings..."
    for file in $(find "$SCRIPT_DIR" -name "*.sh"); do
        tr -d '\r' < "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    done
    echo "✓ Line endings fixed with tr"
    exit 0
fi

echo "❌ Could not fix line endings - no suitable tool found (dos2unix, sed, or tr)"
echo "Please manually convert Windows (CRLF) to Unix (LF) line endings"
exit 1
