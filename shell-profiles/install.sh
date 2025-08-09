#!/bin/bash
# filepath: /workspaces/git_workshop_champlain_college_2025/shell-profiles/install.sh

# Git Workshop Shell Profile Installer
# This script installs shell profiles for the git workshop

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Git Workshop Shell Profile Installer${NC}"
echo "========================================="

# Detect shell
SHELL_TYPE=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_TYPE="zsh"
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_TYPE="bash"
    SHELL_RC="$HOME/.bashrc"
else
    echo -e "${YELLOW}Warning: Could not detect shell type. Assuming bash.${NC}"
    SHELL_TYPE="bash"
    SHELL_RC="$HOME/.bashrc"
fi

echo -e "Detected shell: ${GREEN}$SHELL_TYPE${NC}"
echo -e "Configuration file: ${GREEN}$SHELL_RC${NC}"

# Available profiles
PROFILES=(
    "minimal:Basic shell improvements"
    "developer:Enhanced development environment"
    "poweruser:Advanced features and shortcuts"
    "git-focused:Git-specific enhancements"
)

# Show available profiles
echo -e "\n${BLUE}Available profiles:${NC}"
for i in "${!PROFILES[@]}"; do
    IFS=':' read -r name desc <<< "${PROFILES[$i]}"
    echo -e "  ${GREEN}$((i+1)). $name${NC} - $desc"
done

# Function to install profile
install_profile() {
    local profile_name="$1"
    local profile_file="$SCRIPT_DIR/profiles/${profile_name}.sh"
    
    if [ ! -f "$profile_file" ]; then
        echo -e "${RED}Error: Profile file not found: $profile_file${NC}"
        return 1
    fi
    
    # Create backup of current shell rc
    if [ -f "$SHELL_RC" ]; then
        cp "$SHELL_RC" "$SHELL_RC.workshop-backup-$(date +%Y%m%d-%H%M%S)"
        echo -e "${GREEN}✓ Backup created${NC}"
    fi
    
    # Remove any existing workshop profile lines
    if [ -f "$SHELL_RC" ]; then
        sed -i '/# Git Workshop Profile/d' "$SHELL_RC"
        sed -i '\|source.*git_workshop.*profiles|d' "$SHELL_RC"
    fi
    
    # Add new profile
    echo "" >> "$SHELL_RC"
    echo "# Git Workshop Profile - $profile_name" >> "$SHELL_RC"
    echo "if [ -f \"$profile_file\" ]; then" >> "$SHELL_RC"
    echo "    source \"$profile_file\"" >> "$SHELL_RC"
    echo "fi" >> "$SHELL_RC"
    
    echo -e "${GREEN}✓ Profile '$profile_name' installed${NC}"
    echo -e "${YELLOW}Please restart your shell or run: source $SHELL_RC${NC}"
}

# Interactive mode
if [ $# -eq 0 ]; then
    echo -e "\n${YELLOW}Choose a profile to install (1-${#PROFILES[@]}):${NC}"
    read -r choice
    
    if [[ "$choice" =~ ^[1-9][0-9]*$ ]] && [ "$choice" -le "${#PROFILES[@]}" ]; then
        IFS=':' read -r profile_name _ <<< "${PROFILES[$((choice-1))]}"
        install_profile "$profile_name"
    else
        echo -e "${RED}Invalid choice${NC}"
        exit 1
    fi
else
    # Command line mode
    profile_name="$1"
    install_profile "$profile_name"
fi

echo -e "\n${GREEN}Installation complete!${NC}"
echo -e "Run ${BLUE}source $SHELL_RC${NC} to activate your new profile."