# Exercise 8: Interactive Rebase

**Objective**: Master interactive rebase to rewrite commit history cleanly and professionally.

**Estimated Time**: 30-35 minutes

**Difficulty**: Intermediate

## What You'll Learn

- Interactive rebase for editing commit history
- Squashing commits for cleaner history
- Reordering and editing commits
- Splitting commits
- Best practices for rebase

## Prerequisites

- Completed Exercises 1-7
- Understanding of Git commits and history
- Comfortable with Git workflow

## Tasks

### Task 1: Setup and Basic Rebase

```bash
mkdir rebase-practice
cd rebase-practice
git init

# Create messy commit history
echo "# Project" > README.md
git add README.md
git commit -m "initial commit"

echo "## Features" >> README.md
git add README.md
git commit -m "add features section"

echo "- Feature 1" >> README.md
git add README.md
git commit -m "typo fix"

echo "- Feature 2" >> README.md
git add README.md
git commit -m "add feature 2"

echo "print('hello')" > app.py
git add app.py
git commit -m "WIP: app file"

git log --oneline  # See messy history
```

### Task 2: Interactive Rebase - Squashing

```bash
# Start interactive rebase for last 4 commits
git rebase -i HEAD~4

# In the editor, change picks to squash:
# pick abc1234 add features section
# squash def5678 typo fix
# squash ghi9012 add feature 2
# pick jkl3456 WIP: app file

# Save and edit the commit message
# Combine into meaningful message

git log --oneline  # See cleaner history
```

### Task 3: Reordering Commits

```bash
# Add more commits
echo "def test():" >> app.py
echo "    pass" >> app.py
git add app.py
git commit -m "Add test function"

echo "## Installation" >> README.md
git add README.md
git commit -m "Add installation docs"

echo "## Usage" >> README.md
git add README.md
git commit -m "Add usage docs"

# Reorder to group documentation together
git rebase -i HEAD~3

# Reorder the commits in the editor:
# pick abc1234 Add installation docs
# pick def5678 Add usage docs  
# pick ghi9012 Add test function

git log --oneline  # See reordered history
```

### Task 4: Editing Commits

```bash
# Create a commit we want to edit
echo "def main():" >> app.py
echo "    print('Hello')" >> app.py
git add app.py
git commit -m "Add main function"

# Edit the commit
git rebase -i HEAD~1

# Change 'pick' to 'edit'
# Git will stop at that commit

# Make additional changes
echo "    print('World!')" >> app.py
git add app.py
git commit --amend -m "Add main function with proper greeting"

# Continue rebase
git rebase --continue

git log --oneline
```

### Task 5: Splitting Commits

```bash
# Create a commit that does too much
echo "## Contributing" >> README.md
echo "## License" >> README.md
echo "if __name__ == '__main__':" >> app.py
echo "    main()" >> app.py

git add .
git commit -m "Add docs and main execution"

# Split this commit
git rebase -i HEAD~1

# Change 'pick' to 'edit'
# Git stops at the commit

# Reset to unstage all changes
git reset HEAD^

# Make separate commits
git add README.md
git commit -m "Add contributing and license docs"

git add app.py
git commit -m "Add main execution block"

# Continue rebase
git rebase --continue

git log --oneline  # See split commits
```

### Task 6: Advanced Rebase Operations

```bash
# Create branch for feature
git checkout -b feature-branch

# Add commits
echo "class Calculator:" > calculator.py
echo "    def add(self, a, b):" >> calculator.py
echo "        return a + b" >> calculator.py

git add calculator.py
git commit -m "Add calculator class"

echo "    def subtract(self, a, b):" >> calculator.py
echo "        return a - b" >> calculator.py

git add calculator.py
git commit -m "Add subtract method"

# Rebase onto main with squash
git checkout main
echo "## Updates" >> README.md
git add README.md
git commit -m "Add updates section"

# Rebase feature branch onto main
git checkout feature-branch
git rebase main

# Interactive rebase to clean up
git rebase -i HEAD~2
# Squash the calculator commits

git checkout main
git merge feature-branch
```

### Task 7: Handling Rebase Conflicts

```bash
# Create conflict scenario
git checkout -b conflict-branch main~2

# Modify same file
sed -i '1s/^/# Advanced /' README.md
git add README.md
git commit -m "Update project title"

# Try to rebase (will conflict)
git rebase main

# Resolve conflict
# Edit README.md to resolve
git add README.md
git rebase --continue

git log --oneline --graph
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Used interactive rebase to squash commits
- [ ] Reordered commits logically  
- [ ] Edited existing commits
- [ ] Split a large commit into smaller ones
- [ ] Resolved rebase conflicts
- [ ] Understand when and when not to rebase

## 💡 Key Concepts

### Interactive Rebase Commands
- `pick`: Use commit as-is
- `squash`: Combine with previous commit
- `edit`: Stop to modify commit
- `reword`: Change commit message
- `drop`: Remove commit entirely

### When to Rebase
- ✅ Local commits not yet pushed
- ✅ Feature branches before merging  
- ✅ Cleaning up messy history
- ❌ Shared/public commits
- ❌ Main/master branch commits

### Rebase vs Merge
- **Rebase**: Linear history, rewrites commits
- **Merge**: Preserves branching history, creates merge commit

## Troubleshooting

**"Cannot rebase: You have uncommitted changes"**
- Commit or stash changes before rebasing

**"The following untracked working tree files would be overwritten"**
- Remove or commit untracked files

**"Rebase in progress"**
- Use `git rebase --continue` after resolving conflicts
- Or `git rebase --abort` to cancel

**"fatal: It seems that there is already a rebase-merge directory"**
- Previous rebase didn't complete
- Check status with `git status`

## Next Steps

1. Proceed to [Exercise 9: Git Workflows](../09-workflows/README.md)
2. Practice rebase on feature branches
3. Learn about git revert for public history

## Additional Resources

- [Git Tools - Rewriting History](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)
- [Interactive Rebase Guide](https://git-scm.com/docs/git-rebase#_interactive_mode)

---

**Excellent!** You can now maintain clean, professional commit history.