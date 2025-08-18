#!/bin/bash
# Developer Profile - Balanced setup for daily development
# Compatible with Bash and Zsh on Linux and macOS

# Profile info
export SHELL_PROFILE_NAME="developer"
export SHELL_PROFILE_VERSION="1.0.0"

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

# Development aliases
alias c='clear'
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Enhanced directory navigation
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# File and directory operations
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# Search and find
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Process management
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Network
alias myip='curl -s http://whatismyip.akamai.com/'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'

# Enhanced Git aliases
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gcam='git commit -a -m'
alias gca='git commit --amend'
alias gcl='git clone'
alias gcp='git cherry-pick'
alias gf='git fetch'
alias gm='git merge'
alias gr='git remote'
alias grv='git remote -v'
alias gs='git stash'
alias gsp='git stash pop'
alias gt='git tag'
alias gw='git show'
alias gy='git history'
# Remove any alias for gclean to avoid conflict with function
unalias gclean 2>/dev/null

# Git flow aliases
alias gfl='git flow'
alias gfli='git flow init'
alias gflf='git flow feature'
alias gflfs='git flow feature start'
alias gflff='git flow feature finish'

# OS-specific enhancements
if [[ "$CURRENT_OS" == "macos" ]]; then
    # macOS specific
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias o='open'
    alias oo='open .'
    
    # Homebrew
    if command -v brew >/dev/null 2>&1; then
        alias brewup='brew update && brew upgrade && brew cleanup'
    fi
else
    # Linux specific
    alias open='xdg-open'
    alias o='xdg-open'
    alias oo='xdg-open .'
    
    # Package management
    if command -v apt-get >/dev/null 2>&1; then
        alias aptup='sudo apt-get update && sudo apt-get upgrade'
        alias aptshow='apt-cache show'
        alias aptsearch='apt-cache search'
    fi
fi

# Enhanced functions
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }
mkzip() { zip -r "${1%%/}.zip" "$1" ; }

# Git workflow functions
gnb() {
    git checkout -b "$1"
}

# Removed function gbd to avoid conflict with alias

grename() {
    git branch -m "$1" "$2"
}

gundo() {
    git reset --soft HEAD~1
}

gclean() {
    git branch --merged | grep -v "\*\|master\|main\|develop" | xargs -n 1 git branch -d
}

# Project navigation
cdp() {
    cd ~/projects 2>/dev/null || cd ~/Projects 2>/dev/null || cd ~
}

cdd() {
    cd ~/Downloads 2>/dev/null || cd ~/downloads 2>/dev/null || cd ~
}

# Enhanced prompt with Git status (compatible Bash/Zsh)
if [ -n "$ZSH_VERSION" ]; then
    autoload -Uz vcs_info
    precmd() { vcs_info }
    zstyle ':vcs_info:git:*' formats '(%b)'
    setopt PROMPT_SUBST
    PS1='%n@%m:%~${vcs_info_msg_0_}$ '
else
    git_branch() {
        git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
    PS1='\u@\h:\w$(git_branch)$ '
fi

# History settings
if [[ -n "$ZSH_VERSION" ]]; then
    HISTSIZE=10000
    SAVEHIST=10000
    setopt HIST_VERIFY
    setopt SHARE_HISTORY
    setopt APPEND_HISTORY
    setopt INC_APPEND_HISTORY
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_REDUCE_BLANKS
    setopt HIST_IGNORE_SPACE
else
    HISTSIZE=10000
    HISTFILESIZE=20000
    shopt -s histappend
    shopt -s checkwinsize
fi

# Enable completion
if [[ -n "$ZSH_VERSION" ]]; then
    autoload -U compinit && compinit
    zstyle ':completion:*' menu select
else
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
fi

# Override help function
profile_help() {
    echo "Developer Profile Commands:"
    echo "  Enhanced Navigation: home, cd.., ....., cdp, cdd"
    echo "  File Operations: mkdir, mv, cp, rm, extract, mktar, mkzip"
    echo "  Git Enhanced: gb, gba, gbd, gcam, gca, gnb, gundo, gclean"
    echo "  System: ps, psgrep, psmem, pscpu, myip, ping"
    echo "  Utilities: c, h, path, now, nowdate, o, oo"
    echo "  Functions: extract, mktar, mkzip, gnb, gbd, grename, gundo, gclean"
}

echo "Developer shell profile loaded (v$SHELL_PROFILE_VERSION) with Git integration"
