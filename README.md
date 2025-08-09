# Git CLI Workshop - Champlain College 2025

Welcome to the comprehensive Git Command Line Interface workshop! This repository contains everything you need to master Git CLI, customize your shell environment, and become a command-line power user.

## Quick Start with Dev Container

This workshop includes a fully configured development container with all necessary tools pre-installed.

### Prerequisites

- Visual Studio Code
- Docker Desktop
- Dev Containers extension for VS Code

### Getting Started

1. Open this repository in VS Code
2. When prompted, click "Reopen in Container" or use `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
3. Wait for the container to build (first time only)
4. Start learning!

## Workshop Contents

- [Git CLI Essentials](#git-cli-essentials)
- [Why CLI Matters](#why-command-line-interface-matters)
- [Shell Customization Guide](./shell-profiles/README.md)
- [Practice Exercises](./exercises/README.md)

## Git CLI Essentials

### What is Git CLI?

Git CLI (Command Line Interface) is the original and most powerful way to interact with Git. While graphical interfaces exist, the command line provides:

- **Complete Access**: Every Git feature is available
- **Speed**: Faster than GUI operations
- **Automation**: Scriptable for workflows
- **Universality**: Works on any system
- **Professional Standard**: Industry expectation

### Why Command Line Interface Matters

#### 1. **Universal Availability**

CLI works everywhere - servers, containers, remote systems, and any operating system.

#### 2. **Complete Feature Set**

Every Git operation is available through CLI. GUIs often hide advanced features.

#### 3. **Automation & Scripting**

```bash
# Automate repetitive tasks
git add . && git commit -m "Auto-update: $(date)" && git push
```

#### 4. **Performance**

CLI operations are typically faster than their GUI counterparts.

#### 5. **Professional Development**

Most development workflows, CI/CD pipelines, and DevOps tools use CLI.

#### 6. **Troubleshooting**

When things go wrong, CLI provides detailed error messages and recovery options.

## Essential Git Commands

### Configuration

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Set preferred editor
git config --global core.editor "code --wait"
```

### Repository Basics

```bash
# Initialize a new repository
git init

# Clone an existing repository
git clone <repository-url>

# Check repository status
git status

# View commit history
git log --oneline --graph --decorate
```

### Working with Files

```bash
# Stage files for commit
git add <file>
git add .  # Stage all changes

# Commit changes
git commit -m "Your commit message"

# View changes
git diff           # Unstaged changes
git diff --staged  # Staged changes
```

### Branching and Merging

```bash
# Create and switch to new branch
git checkout -b <branch-name>

# Switch branches
git checkout <branch-name>
git switch <branch-name>  # Modern alternative

# List branches
git branch -a

# Merge branches
git merge <branch-name>

# Delete branch
git branch -d <branch-name>
```

### Remote Operations

```bash
# Add remote repository
git remote add origin <repository-url>

# Push changes
git push origin <branch-name>

# Pull changes
git pull origin <branch-name>

# Fetch changes without merging
git fetch origin
```

### Advanced Operations

```bash
# Interactive rebase
git rebase -i HEAD~3

# Stash changes temporarily
git stash
git stash pop

# Cherry-pick commits
git cherry-pick <commit-hash>

# Reset changes
git reset --soft HEAD~1   # Keep changes staged
git reset --hard HEAD~1   # Discard changes completely
```

## Git Workflow Examples

### Feature Development Workflow
```bash
# 1. Start from main branch
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/user-authentication

# 3. Make changes and commit
git add .
git commit -m "Add user login functionality"

# 4. Push feature branch
git push origin feature/user-authentication

# 5. Create pull request (via GitHub CLI or web)
gh pr create --title "Add user authentication" --body "Implements login/logout"

# 6. After review, merge and cleanup
git checkout main
git pull origin main
git branch -d feature/user-authentication
```

### Hotfix Workflow
```bash
# 1. Create hotfix branch from main
git checkout main
git checkout -b hotfix/security-patch

# 2. Fix issue and commit
git add .
git commit -m "Fix security vulnerability in auth module"

# 3. Push and create urgent PR
git push origin hotfix/security-patch
gh pr create --title "URGENT: Security patch" --body "Fixes CVE-2025-xxx"
```

## Git Configuration Best Practices

### Essential Aliases
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

### Useful Git Settings
```bash
# Enable automatic line ending conversion
git config --global core.autocrlf input  # For Mac/Linux
git config --global core.autocrlf true   # For Windows

# Enable colored output
git config --global color.ui auto

# Set up default push behavior
git config --global push.default simple

# Enable git rerere (reuse recorded resolution)
git config --global rerere.enabled true
```

## Learning Resources

### Official Documentation
- [Git Official Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book) (Free online)

### Interactive Learning
- [Learn Git Branching](https://learngitbranching.js.org/)
- [GitHub Skills](https://skills.github.com/)

### Advanced Topics
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- [Git Workflows](https://www.atlassian.com/git/tutorials/comparing-workflows)

## Shell Customization

This workshop includes comprehensive shell customization profiles for both Bash and Zsh. Check out the [Shell Profiles Guide](./shell-profiles/README.md) to:

- Install beautiful, functional shell themes
- Add powerful aliases and functions
- Set up auto-completion and syntax highlighting
- Create portable configurations for Linux and macOS

## Practice Exercises

Ready to practice? Head over to the [exercises folder](./exercises/README.md) for hands-on Git scenarios:

- Basic Git operations
- Branching and merging challenges
- Conflict resolution
- Advanced Git workflows

## Contributing

Found an issue or want to improve the workshop? Contributions are welcome!

1. Fork this repository
2. Create a feature branch
3. Make your improvements
4. Submit a pull request

## License

This workshop is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

Happy Git-ing!

"Git good or git going!" - Anonymous Developer
