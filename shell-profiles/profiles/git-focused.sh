#!/bin/bash
# filepath: /workspaces/git_workshop_champlain_college_2025/shell-profiles/profiles/git-focused.sh

# Git-focused shell profile
# Loads minimal profile first, then adds Git enhancements

# Load minimal profile as base (robust for Bash and Zsh)
if [ -n "$BASH_VERSION" ]; then
    _PROFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" 2>/dev/null)" && pwd)"
elif [ -n "$ZSH_VERSION" ]; then
    _PROFILE_DIR="$(cd "$(dirname "${(%):-%N}" 2>/dev/null)" && pwd)"
else
    _PROFILE_DIR="$(cd "$(dirname "$0" 2>/dev/null)" && pwd)"
fi
if [ -f "$_PROFILE_DIR/../minimal.sh" ]; then
    . "$_PROFILE_DIR/../minimal.sh"
elif [ -f "$_PROFILE_DIR/minimal.sh" ]; then
    . "$_PROFILE_DIR/minimal.sh"
fi

# Load color themes
if [ -f "$_PROFILE_DIR/../themes/bash-colors.sh" ]; then
    . "$_PROFILE_DIR/../themes/bash-colors.sh"
fi

# Enhanced Git aliases
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -am'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git remote'
alias grv='git remote -v'
alias gf='git fetch'
alias gt='git tag'
alias gst='git stash'
alias gsp='git stash pop'
alias gss='git stash save'
alias gsl='git stash list'

# Advanced Git aliases
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gloga='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --all'
alias gcount='git shortlog -sn'
alias guncommit='git reset --soft HEAD~1'
alias gdiscard='git checkout -- .'
alias gclean='git clean -fd'

# Git workflow aliases
alias gmain='git checkout main'
alias gmaster='git checkout master'
alias gdevelop='git checkout develop'

# Remove any alias for gwip to avoid conflict with function
unalias gwip 2>/dev/null
gwip() {
    git add -A
    git commit -m "WIP: work in progress"
}

# Remove any alias for gunwip to avoid conflict with function
unalias gunwip 2>/dev/null
gunwip() {
    git log -n 1 --pretty=format:%s | grep -q "WIP: work in progress" && git reset HEAD~1
}

# Git branch management
gnew() {
    if [ $# -eq 0 ]; then
        echo "Usage: gnew <branch-name>"
        return 1
    fi
    git checkout -b "$1"
}

gdel() {
    if [ $# -eq 0 ]; then
        echo "Usage: gdel <branch-name>"
        return 1
    fi
    git branch -d "$1"
}

# Git status with enhanced output
gstat() {
    echo -e "${BLUE}Repository Status:${NC}"
    git status --short --branch
    
    echo -e "\n${BLUE}Recent commits:${NC}"
    git log --oneline -5
    
    echo -e "\n${BLUE}Local branches:${NC}"
    git branch
}

# Quick commit with timestamp
gquick() {
    local message="$*"
    if [ -z "$message" ]; then
        message="Quick commit $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    git add -A && git commit -m "$message"
}

# Git push with upstream tracking
gpush() {
    local current_branch=$(git branch --show-current)
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    
    if [ -z "$upstream" ]; then
        echo "Setting upstream for branch '$current_branch'"
        git push -u origin "$current_branch"
    else
        git push
    fi
}

# Enhanced git clone with immediate cd
gclone() {
    if [ $# -eq 0 ]; then
        echo "Usage: gclone <repository-url> [directory]"
        return 1
    fi
    
    git clone "$1" "$2"
    if [ $# -eq 2 ]; then
        cd "$2"
    else
        # Extract repo name from URL
        local repo_name=$(basename "$1" .git)
        cd "$repo_name"
    fi
}

# Git help function
git_help() {
    echo -e "${BLUE}Git Workshop - Available Commands:${NC}"
    echo
    echo -e "${GREEN}Basic Git:${NC}"
    echo "  gs, gstat     - Git status (enhanced)"
    echo "  ga, gaa       - Git add / add all"
    echo "  gc, gcm, gca  - Git commit variations"
    echo "  gp, gpl       - Git push/pull"
    echo "  gl, glog      - Git log (oneline/graph)"
    echo "  gd, gdc       - Git diff (working/cached)"
    echo
    echo -e "${GREEN}Branching:${NC}"
    echo "  gb            - List branches"
    echo "  gco, gcb      - Checkout / create branch"
    echo "  gnew <name>   - Create and switch to new branch"
    echo "  gdel <name>   - Delete branch"
    echo "  gmain/gmaster - Switch to main/master"
    echo
    echo -e "${GREEN}Workflow:${NC}"
    echo "  gwip          - Work in progress commit"
    echo "  gunwip        - Undo work in progress commit"
    echo "  gquick [msg]  - Quick commit with timestamp"
    echo "  gpush         - Smart push with upstream"
    echo "  gclone <url>  - Clone and cd into repo"
    echo
    echo -e "${GREEN}Utilities:${NC}"
    echo "  gst, gsp, gss - Git stash operations"
    echo "  guncommit     - Undo last commit (keep changes)"
    echo "  gdiscard      - Discard all changes"
    echo "  gclean        - Clean untracked files"
    echo
}



echo "Git-focused profile loaded! Type 'git_help' for available commands."