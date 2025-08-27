#!/usr/bin/env zsh
# Demonstration script for Ctrl+T functionality

echo "=== Ctrl+T Fix Verification ==="
echo

# Load the shell configuration
source ~/.zshrc >/dev/null 2>&1

echo "Current shell: $SHELL"
echo "ZSH version: $ZSH_VERSION"
echo

# Check fzf installation
echo "=== FZF Installation Check ==="
echo "fzf location: $(which fzf)"
echo "fzf version: $(fzf --version | head -1)"
echo

# Check key bindings
echo "=== Key Bindings ==="
echo "Ctrl+T binding: $(bindkey | grep '"\^T"' || echo 'Not found')"
echo "fzf-file-widget function: $(typeset -f fzf-file-widget >/dev/null 2>&1 && echo 'Available' || echo 'Not found')"
echo

# Check environment variables
echo "=== FZF Configuration ==="
echo "FZF_CTRL_T_COMMAND: ${FZF_CTRL_T_COMMAND:-'(default will be used)'}"
echo "FZF_CTRL_T_OPTS preview: $(echo "$FZF_CTRL_T_OPTS" | grep -o 'preview.*' | head -1 | cut -c1-50)..."
echo

# Test the command execution
echo "=== Command Test ==="
cmd="${FZF_CTRL_T_COMMAND:-find . -type f 2>/dev/null}"
echo "Testing command: $cmd"
file_count=$(eval "$cmd" 2>/dev/null | head -10 | wc -l)
echo "Sample file count (first 10): $file_count"

if [ "$file_count" -gt 0 ]; then
    echo "✅ FZF command working"
    echo "Sample files:"
    eval "$cmd" 2>/dev/null | head -3 | sed 's/^/  /'
else
    echo "❌ FZF command not returning files"
fi

echo
echo "=== Manual Test Instructions ==="
echo "🔧 The Ctrl+T functionality should now be working!"
echo
echo "To test:"
echo "1. Open a new terminal or run: exec zsh"
echo "2. Navigate to any directory with files"
echo "3. Type some text, then press Ctrl+T"
echo "4. You should see a fuzzy file finder"
echo "5. Use arrow keys to navigate, Enter to select"
echo
echo "🎯 Expected behavior:"
echo "- Ctrl+T opens file finder"
echo "- Ctrl+R opens command history"
echo "- Alt+C opens directory finder"
echo
echo "If it still doesn't work, the issue might be:"
echo "- Terminal not forwarding Ctrl+T properly"
echo "- Another key binding conflict"
echo "- Need to restart the terminal completely"
