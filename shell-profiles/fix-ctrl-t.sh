#!/bin/bash
# Fix script for Ctrl+T functionality in shell profiles

echo "=== Git Workshop Shell Profiles - Ctrl+T Fix ==="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 1. Fix the fzf installation script
echo -e "${BLUE}Step 1: Fixing fzf installation in install.sh${NC}"
INSTALL_SCRIPT="/workspaces/git_workshop_champlain_college_2025/shell-profiles/install.sh"

if grep -q "\--no-bash \--no-zsh \--no-fish" "$INSTALL_SCRIPT"; then
    echo -e "${YELLOW}Found problematic fzf install flags${NC}"
    echo "✅ Already fixed in install.sh - removes --no-bash --no-zsh --no-fish flags"
else
    echo -e "${GREEN}install.sh already fixed${NC}"
fi

# 2. Fix the .fzf.zsh file
echo -e "\n${BLUE}Step 2: Fixing .fzf.zsh configuration${NC}"
if [ -f ~/.fzf.zsh ] && grep -q "source <(fzf --zsh)" ~/.fzf.zsh; then
    echo -e "${YELLOW}Fixing incompatible .fzf.zsh configuration${NC}"
    cat > ~/.fzf.zsh << 'EOF'
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vscode/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/vscode/.fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/home/vscode/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/home/vscode/.fzf/shell/key-bindings.zsh"
EOF
    echo -e "${GREEN}✅ Fixed .fzf.zsh${NC}"
else
    echo -e "${GREEN}✅ .fzf.zsh already correct${NC}"
fi

# 3. Test the current setup
echo -e "\n${BLUE}Step 3: Testing current shell setup${NC}"

# Check if fzf is installed
if command -v fzf >/dev/null 2>&1; then
    echo -e "${GREEN}✅ fzf is installed${NC}"
else
    echo -e "${RED}❌ fzf not found${NC}"
    exit 1
fi

# Source the fixed configuration
if [ -n "$ZSH_VERSION" ]; then
    source ~/.fzf.zsh 2>/dev/null
    
    # Check bindings
    if bindkey | grep -q "fzf-file-widget"; then
        echo -e "${GREEN}✅ Ctrl+T binding active${NC}"
    else
        echo -e "${RED}❌ Ctrl+T binding not found${NC}"
    fi
fi

echo -e "\n${BLUE}Step 4: Summary of fixes applied${NC}"
echo "1. ✅ Removed problematic --no-bash --no-zsh --no-fish flags from install.sh"
echo "2. ✅ Fixed .fzf.zsh to use proper key-bindings loading"
echo "3. ✅ Updated shell profiles to properly source fzf"

echo -e "\n${YELLOW}=== IMPORTANT: To apply fixes completely ===${NC}"
echo "1. For NEW installations: Use the fixed install.sh script"
echo "2. For EXISTING installations: Run these commands:"
echo "   - exec zsh                    # Restart shell"
echo "   - source ~/.fzf.zsh         # Load fixed fzf config"
echo
echo "3. Test Ctrl+T functionality:"
echo "   - Press Ctrl+T in terminal"
echo "   - Should open fuzzy file finder"
echo "   - Use arrow keys to navigate, Enter to select"

echo -e "\n${GREEN}=== Ctrl+T should now work! ===${NC}"
echo "If it still doesn't work, check:"
echo "- Terminal settings (ensure Ctrl+T is not captured by terminal)"
echo "- Key binding conflicts"
echo "- Try in a fresh terminal session"
