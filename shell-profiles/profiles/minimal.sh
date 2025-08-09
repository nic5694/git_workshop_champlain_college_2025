#!/bin/bash
# filepath: /workspaces/git_workshop_champlain_college_2025/shell-profiles/profiles/minimal.sh

# Minimal shell profile for Git Workshop
# Basic improvements without overwhelming new users

# Check if we're running in bash
if [ -z "$BASH_VERSION" ]; then
    echo "Warning: This profile is designed for bash"
    return 1 2>/dev/null || exit 1
fi

# Basic shell options (only if in bash)
if [ -n "$BASH_VERSION" ]; then
    shopt -s checkwinsize
    shopt -s histappend
    shopt -s cdspell
fi

# History configuration
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:ignorespace

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git basics
alias gst='git status'
alias gad='git add'
alias gco='git commit'
alias gps='git push'
alias gpl='git pull'
alias glo='git log --oneline'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utility functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Simple prompt (will be enhanced by color themes if loaded)
if [ -z "$PS1_ORIGINAL" ]; then
    export PS1_ORIGINAL="$PS1"
fi

# Basic colored prompt
PS1='\u@\h:\w$ '

# Profile help
profile_help() {
    echo "Minimal Profile - Basic shell improvements"
    echo "Available aliases:"
    echo "  ll, la, l     - Enhanced ls commands"
    echo "  .., ...       - Quick directory navigation"
    echo "  gst, gad, gco - Basic git shortcuts"
    echo "  mkcd <dir>    - Create and enter directory"
    echo
    echo "Type 'git_help' if git-focused profile is loaded"
}

echo "✨ Minimal profile loaded! Type 'profile_help' for help."