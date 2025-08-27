#!/bin/bash
# Comprehensive test script for Ctrl+T functionality across all profiles

echo "=== Git Workshop Shell Profiles - Ctrl+T Comprehensive Test ==="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test current shell environment
echo -e "${BLUE}=== Environment Test ===${NC}"
echo "Current shell: $SHELL"
echo "Shell version: ${ZSH_VERSION:-${BASH_VERSION:-'Unknown'}}"
echo "Current directory: $(pwd)"
echo

# Test fzf installation
echo -e "${BLUE}=== FZF Installation Test ===${NC}"
if command -v fzf >/dev/null 2>&1; then
    echo -e "${GREEN}✅ fzf found: $(which fzf)${NC}"
    echo -e "${GREEN}✅ fzf version: $(fzf --version)${NC}"
    
    # Check if we have the latest version
    fzf_version=$(fzf --version | cut -d' ' -f1)
    if [[ "$fzf_version" > "0.48" ]] || [[ "$fzf_version" == "0.48" ]]; then
        echo -e "${GREEN}✅ Modern fzf version with advanced features${NC}"
    else
        echo -e "${YELLOW}⚠️  Older fzf version, some features may be limited${NC}"
    fi
else
    echo -e "${RED}❌ fzf not found${NC}"
    echo "Please run the install script to install fzf"
    exit 1
fi

# Test shell integration files
echo -e "\n${BLUE}=== Shell Integration Test ===${NC}"
if [ -n "$ZSH_VERSION" ]; then
    if [ -f ~/.fzf.zsh ]; then
        echo -e "${GREEN}✅ ~/.fzf.zsh exists${NC}"
        if grep -q "fzf --zsh" ~/.fzf.zsh; then
            echo -e "${GREEN}✅ Using modern fzf integration${NC}"
        else
            echo -e "${YELLOW}⚠️  Using fallback integration${NC}"
        fi
    else
        echo -e "${RED}❌ ~/.fzf.zsh not found${NC}"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if [ -f ~/.fzf.bash ]; then
        echo -e "${GREEN}✅ ~/.fzf.bash exists${NC}"
        if grep -q "fzf --bash" ~/.fzf.bash; then
            echo -e "${GREEN}✅ Using modern fzf integration${NC}"
        else
            echo -e "${YELLOW}⚠️  Using fallback integration${NC}"
        fi
    else
        echo -e "${RED}❌ ~/.fzf.bash not found${NC}"
    fi
fi

# Test key bindings
echo -e "\n${BLUE}=== Key Bindings Test ===${NC}"
if [ -n "$ZSH_VERSION" ]; then
    if bindkey | grep -q "fzf-file-widget"; then
        echo -e "${GREEN}✅ Ctrl+T bound to fzf-file-widget${NC}"
        echo "   $(bindkey | grep fzf-file-widget)"
    else
        echo -e "${RED}❌ Ctrl+T not bound to fzf-file-widget${NC}"
    fi
    
    if bindkey | grep -q "fzf-history-widget"; then
        echo -e "${GREEN}✅ Ctrl+R bound to fzf-history-widget${NC}"
    else
        echo -e "${YELLOW}⚠️  Ctrl+R not bound to fzf-history-widget${NC}"
    fi
    
    if bindkey | grep -q "fzf-cd-widget"; then
        echo -e "${GREEN}✅ Alt+C bound to fzf-cd-widget${NC}"
    else
        echo -e "${YELLOW}⚠️  Alt+C not bound to fzf-cd-widget${NC}"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if bind -p 2>/dev/null | grep -q "fzf-file-widget"; then
        echo -e "${GREEN}✅ Ctrl+T bound to fzf-file-widget (bash)${NC}"
    else
        echo -e "${RED}❌ Ctrl+T not bound to fzf-file-widget (bash)${NC}"
    fi
fi

# Test FZF environment variables
echo -e "\n${BLUE}=== FZF Configuration Test ===${NC}"
echo "FZF_CTRL_T_COMMAND: ${FZF_CTRL_T_COMMAND:-'(default)'}"
if [ -n "$FZF_CTRL_T_OPTS" ]; then
    echo -e "${GREEN}✅ FZF_CTRL_T_OPTS configured${NC}"
    echo "   Length: ${#FZF_CTRL_T_OPTS} characters"
    if echo "$FZF_CTRL_T_OPTS" | grep -q "preview"; then
        echo -e "${GREEN}✅ Preview enabled${NC}"
    fi
    if echo "$FZF_CTRL_T_OPTS" | grep -q "border"; then
        echo -e "${GREEN}✅ Border styling enabled${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  FZF_CTRL_T_OPTS not set${NC}"
fi

# Test command execution
echo -e "\n${BLUE}=== Command Execution Test ===${NC}"
if [ -n "$FZF_CTRL_T_COMMAND" ]; then
    echo "Testing command: $FZF_CTRL_T_COMMAND"
    file_count=$(eval "$FZF_CTRL_T_COMMAND" 2>/dev/null | wc -l)
    if [ "$file_count" -gt 0 ]; then
        echo -e "${GREEN}✅ Command returns $file_count files${NC}"
        echo "Sample files:"
        eval "$FZF_CTRL_T_COMMAND" 2>/dev/null | head -3 | sed 's/^/   /'
    else
        echo -e "${RED}❌ Command returns no files${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Using default fzf command${NC}"
    default_cmd="find . -type f 2>/dev/null"
    file_count=$(eval "$default_cmd" | head -100 | wc -l)
    echo -e "${GREEN}✅ Default command returns $file_count+ files${NC}"
fi

# Test widget functions
echo -e "\n${BLUE}=== Widget Functions Test ===${NC}"
if [ -n "$ZSH_VERSION" ]; then
    if typeset -f fzf-file-widget >/dev/null 2>&1; then
        echo -e "${GREEN}✅ fzf-file-widget function available${NC}"
    else
        echo -e "${RED}❌ fzf-file-widget function not found${NC}"
    fi
    
    if typeset -f __fzf_select >/dev/null 2>&1; then
        echo -e "${GREEN}✅ __fzf_select helper function available${NC}"
    else
        echo -e "${YELLOW}⚠️  __fzf_select helper function not found${NC}"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if declare -f fzf-file-widget >/dev/null 2>&1; then
        echo -e "${GREEN}✅ fzf-file-widget function available (bash)${NC}"
    else
        echo -e "${RED}❌ fzf-file-widget function not found (bash)${NC}"
    fi
fi

# Test profile-specific features
echo -e "\n${BLUE}=== Profile-Specific Test ===${NC}"
if command -v git_help >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Git-focused profile loaded${NC}"
    if echo "$FZF_CTRL_T_COMMAND" | grep -q "git ls-files"; then
        echo -e "${GREEN}✅ Git-aware file search configured${NC}"
    fi
elif command -v profile_help >/dev/null 2>&1; then
    profile_type=$(type profile_help 2>/dev/null | grep -o 'profiles/[^.]*' | cut -d'/' -f2)
    echo -e "${GREEN}✅ Profile loaded: $profile_type${NC}"
fi

# Final recommendations
echo -e "\n${BLUE}=== Usage Instructions ===${NC}"
echo "🎯 To test Ctrl+T functionality:"
echo "   1. Press Ctrl+T in your terminal"
echo "   2. You should see a file picker interface"
echo "   3. Use arrow keys to navigate"
echo "   4. Press Enter to select a file"
echo "   5. Press Esc to cancel"
echo
echo "🔧 Other fzf shortcuts:"
echo "   • Ctrl+R - Search command history"
echo "   • Alt+C  - Change directory with fuzzy search"
echo
echo "⚠️  If Ctrl+T doesn't work:"
echo "   1. Restart your shell: exec \$SHELL"
echo "   2. Check terminal settings (some terminals capture Ctrl+T)"
echo "   3. Try in a different terminal application"
echo "   4. Re-run the install script with fzf option"

echo -e "\n${GREEN}=== Test Complete ===${NC}"
