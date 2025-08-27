# Exercise 3: Basic Add, Commit, Push

**Objective**: Master the fundamental Git workflow of adding, committing, and pushing changes.

**Estimated Time**: 20-25 minutes

**Difficulty**: Beginner

## What You'll Learn

- Understanding Git's three-stage workflow
- Using git add effectively (files, patterns, interactive)
- Writing good commit messages
- Understanding git push and remote synchronization
- Basic Git status interpretation

## Prerequisites

- Completed Exercise 1: Basic Git Setup
- Completed Exercise 2: Creating Your First Repository
- Repository connected to GitHub (recommended)

## Tasks

### Task 1: Understanding Git Status

```bash
# Create a new working directory or use existing repo
mkdir git-workflow-practice
cd git-workflow-practice
git init

# Create several files
echo "# Project Documentation" > README.md
echo "print('Hello World')" > app.py
echo "requests==2.28.1" > requirements.txt
mkdir docs
echo "## API Documentation" > docs/api.md

# Check status to see untracked files
git status
git status --short  # Shorter format
```

### Task 2: Staging Files (git add)

```bash
# Add individual files
git add README.md
git status

# Add multiple files
git add app.py requirements.txt
git status

# Add all files in a directory
git add docs/
git status

# See what's staged vs unstaged
git diff            # Shows unstaged changes
git diff --staged   # Shows staged changes
```

### Task 3: Making Commits

```bash
# Make your first commit
git commit -m "Initial project setup

- Add README.md with project title
- Add app.py with basic hello world
- Add requirements.txt with dependencies
- Add docs/api.md for documentation"

# Check your commit
git log
git show HEAD
```

### Task 4: More Advanced Staging

```bash
# Modify multiple files
echo "## Installation" >> README.md
echo "# TODO: Add more features" >> app.py
echo "flask==2.2.2" >> requirements.txt

# Check what changed
git status
git diff

# Stage only specific files
git add README.md app.py

# Check status - requirements.txt should be unstaged
git status

# Commit staged changes
git commit -m "Update README and add TODO comment

- Add installation section to README
- Add TODO comment for future features"

# Stage and commit remaining changes
git add requirements.txt
git commit -m "Add Flask dependency to requirements"
```

### Task 5: Interactive Staging

```bash
# Make changes to a file
cat >> app.py << 'EOF'

def greet(name):
    return f"Hello, {name}!"

def main():
    print("Hello World")
    print(greet("Git Workshop"))

if __name__ == "__main__":
    main()
EOF

# Use interactive add
git add -i
# Choose option 2 (update) to see files
# Choose option 5 (patch) to select parts of files
# Or use: git add -p app.py

# Alternative: use git add --patch
git add --patch app.py

# Commit the changes
git commit -m "Add greet function and improve main function

- Create reusable greet function
- Update main to demonstrate greeting
- Improve code organization"
```

### Task 6: Working with Remotes

```bash
# If you haven't connected to GitHub yet:
# git remote add origin https://github.com/USERNAME/git-workflow-practice.git

# Check remotes
git remote -v

# Push your commits
git push -u origin main

# Make another change
echo "## Usage" >> README.md
echo "Run: python app.py" >> README.md

git add README.md
git commit -m "Add usage instructions to README"

# Push the new commit
git push

# Check your repository on GitHub
```

### Task 7: Checking History and Status

```bash
# View commit history
git log
git log --oneline
git log --graph --oneline
git log --stat  # Shows files changed

# Check current status
git status

# See differences
git diff HEAD~1  # Compare with previous commit
git diff HEAD~2  # Compare with 2 commits ago

# Show specific commit
git show HEAD
git show <commit-hash>
```

## Validation

Run the validation script to check your work:

```bash
./validate.sh
```

## Success Criteria

- [ ] Repository has at least 4 commits
- [ ] Used `git add` to stage files
- [ ] Made commits with descriptive messages
- [ ] Pushed commits to remote repository
- [ ] Can check status and view history
- [ ] Understand staging area concept

## 💡 Key Concepts

### The Three Areas

1. **Working Directory** - Your current files
2. **Staging Area (Index)** - Files ready for commit
3. **Repository** - Committed snapshots

### Git Add Options

```bash
git add file.txt          # Add specific file
git add *.py             # Add all Python files
git add .                # Add all files in current directory
git add -A               # Add all files including deleted
git add -u               # Add modified files (not new)
git add -p               # Patch mode (interactive)
```

### Commit Message Best Practices

- **First line**: Brief summary (50 chars max)
- **Blank line**: Separate summary from body
- **Body**: Detailed explanation if needed
- **Use imperative mood**: "Add feature" not "Added feature"

### Understanding Git Status

```
Changes to be committed:     # Staged files
Changes not staged:          # Modified but unstaged
Untracked files:            # New files not in Git
```

## Troubleshooting

### Common Issues

**"nothing to commit, working tree clean"**
- This means all changes are committed
- Make some changes first, then add and commit

**"Changes not staged for commit"**
- You modified files but didn't stage them
- Use `git add <file>` to stage changes

**"Your branch is ahead of origin/main"**
- You have local commits not pushed to remote
- Use `git push` to sync

**Commit message editor opens**
- If you forget `-m`, Git opens an editor
- Write message, save and exit
- Or set editor: `git config --global core.editor "code --wait"`

## Next Steps

Once you've completed this exercise:
1. Proceed to [Exercise 4: Working with Remote Repositories](../04-remotes/README.md)
2. Practice the add-commit-push workflow daily
3. Experiment with different `git add` options

## Additional Resources

- [Git Basics - Recording Changes](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)
- [Commit Message Guidelines](https://chris.beams.io/posts/git-commit/)

---

**Excellent!** You now understand the core Git workflow that you'll use every day.