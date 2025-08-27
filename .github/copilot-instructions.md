# Git CLI Workshop - Champlain College 2025

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Repository Type
This is an educational Git CLI workshop repository containing:
- Exercise tutorials and validation scripts
- Shell customization profiles  
- Dev container configuration
- No traditional build system - validates via shell scripts

### Essential Dependencies and Setup
- Git (always pre-installed)
- Bash shell (always available)
- Optional: VS Code Dev Container for full environment

### Core Operations
- **Validate exercises**: `bash exercises/<exercise-name>/validate.sh` -- takes 0.01-0.04 seconds. NEVER CANCEL.
- **Check progress**: `bash exercises/check-progress.sh` -- takes 0.02-0.04 seconds. NEVER CANCEL.
- **Test shell profiles**: `source shell-profiles/profiles/<profile-name>.sh` -- instantaneous. NEVER CANCEL.
- **Test icon support**: `bash shell-profiles/test-icons.sh` -- takes 0.07 seconds. NEVER CANCEL.

### Install Shell Profiles (INTERACTIVE - Use with caution)
- **WARNING**: `bash shell-profiles/install.sh` contains interactive prompts that will hang if run non-interactively
- **Safe test**: Use `bash shell-profiles/install.sh --help` to verify functionality (0.002 seconds)
- **Alternative**: Source profiles directly: `source shell-profiles/profiles/minimal.sh`

## Validation

### Always Test These Scenarios After Changes
1. **Exercise validation workflow**:
   ```bash
   # Configure Git for testing
   git config --global user.name "Test User"
   git config --global user.email "test@example.com"
   git config --global init.defaultBranch main
   git config --global core.editor "code --wait"
   git config --global color.ui auto
   git config --global alias.st status
   
   # Validate Exercise 1 (should pass all 6 checks)
   bash exercises/01-basic-setup/validate.sh
   
   # Check progress tracking
   bash exercises/check-progress.sh check 01-basic-setup
   bash exercises/check-progress.sh
   ```

2. **Shell profile functionality**:
   ```bash
   # Test minimal profile
   source shell-profiles/profiles/minimal.sh
   profile_help  # Should show available commands
   
   # Test git-focused profile  
   source shell-profiles/profiles/git-focused.sh
   profile_help  # Should show minimal commands
   git_help     # Should show comprehensive git commands
   ```

3. **Complete Git workflow validation**:
   ```bash
   # Create temporary test repository
   cd /tmp && mkdir test-workshop && cd test-workshop
   git init
   echo "# Test" > README.md
   git add README.md && git commit -m "Initial commit"
   
   # Test aliases work
   gst   # Should show stash status
   gs    # Should show git status (clean working tree)
   gl    # Should show commit log
   ```

4. **Icon and font verification**:
   ```bash
   bash shell-profiles/test-icons.sh
   # Should display various symbols and report font status
   ```

### Success Criteria for Validation
- Exercise validation scripts run successfully and show pass/fail status
- Progress tracking accurately updates completion status  
- Shell profiles load without errors and provide help commands
- Git aliases work in test repositories (gst, gs, gl, etc.)
- Icon test displays symbols correctly (some font warnings are normal)

### Manual Testing Requirements
**CRITICAL**: Always perform end-to-end testing of workshop functionality:
1. Exercise completion workflow (setup Git → validate → mark progress)
2. Shell profile functionality (load → test commands → verify Git aliases)
3. Repository operations (init → commit → status via aliases)

## Repository Navigation

### Working Directory
Always use absolute path: `/home/runner/work/git_workshop_champlain_college_2025/git_workshop_champlain_college_2025/`

### Critical Files for Workshop Functionality
- `exercises/01-basic-setup/validate.sh` - Primary validation script
- `exercises/check-progress.sh` - Progress tracking core
- `shell-profiles/profiles/git-focused.sh` - Main shell profile
- `.devcontainer/setup.sh` - Environment setup script
- `.devcontainer/devcontainer.json` - Container configuration

## Common Tasks

### Repo Structure
```
/home/runner/work/git_workshop_champlain_college_2025/git_workshop_champlain_college_2025/
├── .devcontainer/          # Dev container setup
├── .github/               # GitHub configurations
├── exercises/             # Workshop exercises and validation
├── shell-profiles/        # Shell customization profiles
├── workshop/             # Additional workshop materials
├── README.md             # Main documentation
└── LICENSE               # MIT license
```

### Key Exercise Files
- `exercises/01-basic-setup/validate.sh` - Git configuration validation
- `exercises/check-progress.sh` - Progress tracking system
- Each exercise directory contains README.md with instructions

### Shell Profile Files
- `shell-profiles/profiles/minimal.sh` - Lightweight profile ✓ WORKING
- `shell-profiles/profiles/developer.sh` - Developer-focused setup ⚠ HAS SYNTAX ERRORS
- `shell-profiles/profiles/poweruser.sh` - Feature-rich configuration ⚠ WORKS BUT SOURCES BROKEN DEVELOPER.SH
- `shell-profiles/profiles/git-focused.sh` - Git workflow optimized ✓ WORKING
- `shell-profiles/install.sh` - Interactive installer (has prompts)
- `shell-profiles/test-icons.sh` - Font/icon verification ✓ WORKING

### Git Configuration Examples
```bash
# Standard workshop Git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"
git config --global color.ui auto

# Essential aliases expected by exercises
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
```

### Dev Container Information
```bash
# Dev container builds using:
# - Ubuntu 22.04 base image
# - Git, GitHub CLI, Zsh with Oh My Zsh
# - Various CLI tools (tree, htop, curl, wget, nano, vim, jq, bat, exa, fzf, ripgrep)
# - Custom setup via .devcontainer/setup.sh

# Setup script installs additional tools and configures Git
# Takes approximately 5+ minutes on first build. NEVER CANCEL.
```

## Known Issues and Workarounds

### Shell Profile Syntax Errors
- `profiles/developer.sh` has syntax errors on line 187 - avoid using
- `profiles/poweruser.sh` sources the broken developer.sh but still functions
- **ALWAYS use `bash -n profilename.sh` to check syntax before sourcing**
- **Recommended working profiles**: `minimal.sh` and `git-focused.sh`

### Interactive Installer Limitations
- `shell-profiles/install.sh` contains unguarded interactive prompts
- Even with `--auto` flag, it prompts for shell change confirmation
- Package installation takes 5+ minutes. NEVER CANCEL.
- **Workaround**: Source profiles directly instead of using installer

### Exercise Coverage
- Only Exercise 1 (01-basic-setup) is currently implemented
- Progress tracking system works but only tracks implemented exercises
- Validation scripts are lightweight and fast (0.01-0.04 seconds)

### Dev Container Compatibility
- Setup takes 5+ minutes on first build. NEVER CANCEL.
- All required tools are pre-installed in dev container environment
- Manual testing requires proper terminal font for icon display

## Validation Commands Reference

### Quick Health Check
```bash
# Test core functionality (all should pass)
bash exercises/01-basic-setup/validate.sh     # Should show 6/6 PASS
bash exercises/check-progress.sh              # Should show progress status  
bash shell-profiles/test-icons.sh             # Should display symbols
source shell-profiles/profiles/minimal.sh && profile_help  # Should show commands
```

### Comprehensive Validation Suite
```bash
# 1. Configure Git for testing
git config --global user.name "Test User"
git config --global user.email "test@example.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"
git config --global color.ui auto
git config --global alias.st status

# 2. Exercise validation (expect 6/6 PASS)
bash exercises/01-basic-setup/validate.sh

# 3. Progress tracking (expect completion marked)
bash exercises/check-progress.sh check 01-basic-setup
bash exercises/check-progress.sh

# 4. Shell profiles (expect no errors)
source shell-profiles/profiles/minimal.sh && profile_help
source shell-profiles/profiles/git-focused.sh && git_help

# 5. Git workflow test (expect working aliases)
cd /tmp && mkdir test-repo && cd test-repo
git init && echo "# Test" > README.md
git add README.md && git commit -m "Test"
gs   # Should show clean status
gst  # Should show stash info  
gl   # Should show commit log
```

## Troubleshooting Common Issues
### Exercise Validation Failures
- **User not configured**: Run git config commands above
- **Missing aliases**: Add at least `git config --global alias.st status`
- **Branch not set**: Run `git config --global init.defaultBranch main`

### Shell Profile Issues  
- **Permission denied**: Scripts may need `chmod +x`
- **Command not found**: Profile functions only available after sourcing
- **Interactive prompts**: installer script requires user input - source profiles directly instead
- **Syntax errors**: `profiles/developer.sh` has syntax errors - use `minimal.sh` or `git-focused.sh` instead
- **Profile failures**: If a profile fails to load, test with `bash -n profiles/profile-name.sh` first

### Icon Display Problems
- **Boxes or question marks**: Install Nerd Fonts, configure terminal font
- **Missing dependencies**: Run `shell-profiles/test-icons.sh` to diagnose

## Working with Exercises

### Exercise Progress Flow
1. Read exercise README.md
2. Complete the tasks
3. Run `bash exercises/<exercise-name>/validate.sh`
4. Use `bash exercises/check-progress.sh check <exercise-name>` to mark complete
5. Check overall progress with `bash exercises/check-progress.sh`

### Exercise Categories
- **Beginner (01-04)**: Basic Git operations, configuration, repositories
- **Intermediate (05-08)**: Branching, merging, conflicts, stash, rebase  
- **Advanced (09-12)**: Workflows, hooks, automation, best practices

### Always Run Before Committing
- `bash exercises/01-basic-setup/validate.sh` to verify Git configuration
- Test any shell profile changes with `source shell-profiles/profiles/<profile>.sh`
- Verify exercise progress tracking with `bash exercises/check-progress.sh`

## Performance Notes
- Exercise validation: 0.01-0.04 seconds each
- Progress checking: 0.02-0.04 seconds  
- Shell profile loading: instantaneous
- Icon testing: 0.07 seconds
- Dev container setup: 5+ minutes (first time only). NEVER CANCEL.
- Shell installer: 5+ minutes + interactive prompts. NEVER CANCEL.