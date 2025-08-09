#!/bin/bash

# Git Workshop Dev Container Setup Script
echo "Setting up Git CLI Workshop environment..."

# Update system packages
sudo apt-get update && sudo apt-get upgrade -y

# Install additional useful tools
sudo apt-get install -y \
    tree \
    htop \
    curl \
    wget \
    nano \
    vim \
    jq \
    bat \
    exa \
    fzf \
    ripgrep

# Install Git Delta for better diff viewing
wget -O /tmp/git-delta.deb https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
sudo dpkg -i /tmp/git-delta.deb || sudo apt-get install -f -y

# Setup Git global configuration with workshop defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait"
git config --global merge.tool "vscode"
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
git config --global diff.tool "vscode"
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'

# Install Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# Make shell profiles executable
chmod +x /home/vscode/shell-profiles/install.sh
chmod +x /home/vscode/shell-profiles/profiles/*.sh

# Create workshop directories
mkdir -p /home/vscode/workshop-exercises
mkdir -p /home/vscode/git-examples

echo "Dev container setup complete!"
echo "Welcome to the Git CLI Workshop!"
echo "Run 'cd shell-profiles && ./install.sh' to customize your shell"
