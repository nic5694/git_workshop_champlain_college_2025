# Shell Customization Profiles

Transform your terminal into a powerful, beautiful, and efficient workspace! This directory contains pre-configured shell profiles for both Bash and Zsh that work across Linux and macOS systems.

## Quick Installation

```bash
# Clone this repository and navigate to shell-profiles
cd shell-profiles

# Run the interactive installer
./install.sh
```

## What's Included

```
shell-profiles/
├── install.sh                 # Interactive installer script
├── profiles/
│   ├── minimal.sh             # Clean, fast profile
│   ├── developer.sh           # Developer-focused setup
│   ├── poweruser.sh           # Feature-rich configuration
│   └── git-focused.sh         # Git workflow optimized
├── themes/
│   ├── starship.toml          # Starship prompt theme
│   ├── oh-my-zsh-custom.zsh   # Oh My Zsh customizations
│   └── bash-colors.sh         # Bash color schemes
├── configs/
│   ├── .gitconfig             # Enhanced Git configuration
│   ├── .vimrc                 # Vim configuration
│   └── .tmux.conf             # Tmux configuration
└── README.md                  # This file
```

## Profile Options

### 1. Minimal Profile (`minimal.sh`)
Perfect for servers and lightweight environments.

**Features:**
- Essential aliases
- Basic Git shortcuts
- Minimal prompt
- Fast startup

**Best for:** Servers, SSH sessions, older hardware

### 2. Developer Profile (`developer.sh`)
Balanced setup for daily development work.

**Features:**
- Git aliases and functions
- Directory navigation shortcuts
- Syntax highlighting
- Auto-completion
- Modern prompt with Git status

**Best for:** Day-to-day development, coding projects

### 3. Power User Profile (`poweruser.sh`)
Feature-rich setup with all the bells and whistles.

**Features:**
- Advanced Git workflows
- Fuzzy finding (fzf)
- Enhanced history search
- Custom functions
- Beautiful prompt
- Auto-suggestions

**Best for:** Power users, terminal enthusiasts

### 4. Git-Focused Profile (`git-focused.sh`)
Specialized for Git-heavy workflows.

**Features:**
- Comprehensive Git aliases
- Branch management functions
- Commit helpers
- Merge conflict tools
- Git-aware prompt

**Best for:** Git power users, DevOps engineers

## Installation Options

### Interactive Installation
```bash
./install.sh
```

The installer will:
1. Detect your shell (Bash/Zsh)
2. Show available profiles
3. Let you choose what to install
4. Backup existing configurations
5. Apply your chosen profile

### Manual Installation

#### For Zsh users:
```bash
# Choose a profile and source it
source profiles/developer.sh

# Add to your .zshrc for permanent installation
echo "source $(pwd)/profiles/developer.sh" >> ~/.zshrc
```

#### For Bash users:
```bash
# Choose a profile and source it
source profiles/developer.sh

# Add to your .bashrc for permanent installation
echo "source $(pwd)/profiles/developer.sh" >> ~/.bashrc
```

## Customization

### Adding Your Own Aliases
Create a `personal.sh` file in the profiles directory:

```bash
# personal.sh
alias myproject="cd ~/projects/my-awesome-project"
alias deploy="git push && ssh server 'cd /app && git pull && restart'"

# Custom Git function
function gcom() {
    git add .
    git commit -m "$1"
    git push
}
```

Then include it in your profile:
```bash
source ~/shell-profiles/profiles/personal.sh
```

### Modifying Themes
Edit the theme files in the `themes/` directory:

- `starship.toml` - Modern cross-shell prompt
- `oh-my-zsh-custom.zsh` - Zsh-specific customizations
- `bash-colors.sh` - Bash color schemes

## Advanced Features

### Git Workflow Functions
```bash
# Quick commit and push
gcp "commit message"

# Create and switch to new branch
gnb feature/new-feature

# Interactive rebase last 3 commits
grb 3

# Show git log with graph
glog
```

### Directory Navigation
```bash
# Quick navigation
..      # cd ..
...     # cd ../..
....    # cd ../../..

# Directory shortcuts
cdp     # cd to projects directory
cdd     # cd to downloads
```

### Search and Find
```bash
# Find files by name
ff filename

# Search in files
gg "search term"

# Interactive file finder (requires fzf)
fzf
```

## Cross-Platform Compatibility

### macOS Considerations
- Uses `brew` for package installation when available
- Configures macOS-specific aliases
- Sets up proper PATH for Homebrew

### Linux Considerations
- Uses appropriate package manager (apt, yum, etc.)
- Configures Linux-specific aliases
- Works with both desktop and server environments

### Automatic Detection
The profiles automatically detect your operating system and adjust accordingly:

```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific settings
    alias ls='ls -G'
    export PATH="/opt/homebrew/bin:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux specific settings
    alias ls='ls --color=auto'
fi
```

## Startup Configuration

### Automatic Loading
The installer can set up automatic loading by adding source commands to your shell's startup file:

- **Zsh**: `~/.zshrc`
- **Bash**: `~/.bashrc` (Linux) or `~/.bash_profile` (macOS)

### Performance Optimization
- Lazy loading for heavy features
- Conditional loading based on environment
- Fast startup times

### Example Startup Sequence
```bash
# 1. Load core profile
source ~/shell-profiles/profiles/developer.sh

# 2. Load local customizations (if exists)
[[ -f ~/shell-profiles/profiles/personal.sh ]] && source ~/shell-profiles/profiles/personal.sh

# 3. Load machine-specific config (if exists)
[[ -f ~/.local-shell-config ]] && source ~/.local-shell-config
```

## Updating Profiles

### Keeping Profiles Updated
```bash
# Update from repository
git pull origin main

# Re-run installer to apply updates
./install.sh --update
```

### Version Management
Profiles include version information and changelog tracking:

```bash
# Check profile version
profile_version

# Show what's new
profile_changelog
```

## Troubleshooting

### Common Issues

#### "Command not found" errors
- Ensure the profile is properly sourced
- Check if required tools are installed
- Verify PATH configuration

#### Slow startup times
- Try the minimal profile
- Disable heavy features
- Check for problematic plugins

#### Git functions not working
- Verify Git is installed and configured
- Check Git aliases configuration
- Ensure you're in a Git repository

### Getting Help
```bash
# Show available functions
profile_help

# List all aliases
alias

# Show Git aliases
git_aliases
```

## License

These shell profiles are licensed under the MIT License. Feel free to modify and distribute!

---

**Make your terminal awesome!**
