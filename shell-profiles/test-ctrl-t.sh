#!/bin/bash
# Test script to validate Ctrl+T functionality

echo "=== Ctrl+T Functionality Test ==="
echo

# Check if fzf is installed
if ! command -v fzf >/dev/null 2>&1; then
    echo "❌ fzf is not installed"
    exit 1
fi
echo "✅ fzf is installed: $(which fzf)"

# Check if key bindings are loaded
if [ -n "$ZSH_VERSION" ]; then
    if bindkey | grep -q "fzf-file-widget"; then
        echo "✅ Ctrl+T key binding is active (zsh)"
    else
        echo "❌ Ctrl+T key binding not found (zsh)"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if bind -p | grep -q "fzf-file-widget"; then
        echo "✅ Ctrl+T key binding is active (bash)"
    else
        echo "❌ Ctrl+T key binding not found (bash)"
    fi
fi

# Check if FZF environment variables are set
echo
echo "=== FZF Configuration ==="
echo "FZF_CTRL_T_COMMAND: ${FZF_CTRL_T_COMMAND:-'(not set)'}"
echo "FZF_CTRL_T_OPTS: ${FZF_CTRL_T_OPTS:-'(not set)'}"

# Test the command
echo
echo "=== Testing FZF_CTRL_T_COMMAND ==="
if [ -n "$FZF_CTRL_T_COMMAND" ]; then
    echo "Running: $FZF_CTRL_T_COMMAND"
    file_count=$(eval "$FZF_CTRL_T_COMMAND" 2>/dev/null | wc -l)
    if [ "$file_count" -gt 0 ]; then
        echo "✅ Command returns $file_count files"
        echo "Sample files:"
        eval "$FZF_CTRL_T_COMMAND" 2>/dev/null | head -3 | sed 's/^/  /'
    else
        echo "❌ Command returns no files"
    fi
else
    echo "❌ FZF_CTRL_T_COMMAND not set"
fi

# Test fzf widget function
echo
echo "=== Testing fzf-file-widget function ==="
if command -v fzf-file-widget >/dev/null 2>&1; then
    echo "✅ fzf-file-widget function is available"
else
    echo "❌ fzf-file-widget function not found"
fi

# Check configuration files
echo
echo "=== Configuration Files ==="
if [ -f ~/.fzf.zsh ]; then
    echo "✅ ~/.fzf.zsh exists"
elif [ -f ~/.fzf.bash ]; then
    echo "✅ ~/.fzf.bash exists"
else
    echo "❌ No fzf shell integration file found"
fi

if [ -f ~/.fzf/shell/key-bindings.zsh ] || [ -f ~/.fzf/shell/key-bindings.bash ]; then
    echo "✅ fzf key-bindings file exists"
else
    echo "❌ fzf key-bindings file not found"
fi

echo
echo "=== Manual Test Instructions ==="
echo "To test Ctrl+T manually:"
echo "1. Open a new terminal or reload your shell configuration"
echo "2. Navigate to a directory with files"
echo "3. Press Ctrl+T"
echo "4. You should see a file picker interface"
echo "5. Use arrow keys to navigate, Enter to select, Esc to cancel"
echo
echo "If Ctrl+T doesn't work:"
echo "1. Run: source ~/.fzf.zsh (for zsh) or source ~/.fzf.bash (for bash)"
echo "2. Try reinstalling fzf with: ~/.fzf/install --all"
echo "3. Restart your shell session"
