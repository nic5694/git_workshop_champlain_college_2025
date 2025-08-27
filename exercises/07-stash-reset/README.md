# Exercise 7: Git Stash and Reset

**Objective**: Learn to manage work-in-progress and undo changes safely using git stash and reset.

**Estimated Time**: 25-30 minutes

**Difficulty**: Intermediate

## What You'll Learn

- Using git stash to save work-in-progress
- Applying and managing stashes
- Understanding git reset (soft, mixed, hard)
- Safely undoing commits and changes
- Recovery techniques

## Prerequisites

- Completed Exercises 1-6
- Understanding of Git workflow and branching

## Tasks

### Task 1: Working with Git Stash

```bash
mkdir stash-practice
cd stash-practice
git init

# Create initial files
echo "# Project" > README.md
echo "print('hello')" > app.py
git add .
git commit -m "Initial commit"

# Start working on new feature
echo "## New Feature" >> README.md
echo "def new_function():" >> app.py
echo "    pass" >> app.py

# Emergency: need to switch branches
git status  # See uncommitted changes
git stash   # Save work-in-progress
git status  # Clean working directory

# Work is safely stored
git stash list
git stash show
```

### Task 2: Managing Multiple Stashes

```bash
# Apply stash and continue work
git stash pop  # Apply and remove from stash
git status

# Create another scenario
echo "## Documentation" >> README.md
git add README.md

echo "# TODO: implement" >> app.py
git stash push -m "WIP: documentation and TODOs"

# Make different changes
echo "## Installation" >> README.md
git stash push -m "WIP: installation notes"

# View all stashes
git stash list
git stash show stash@{0}
git stash show stash@{1}

# Apply specific stash
git stash apply stash@{1}
git commit -am "Add documentation sections"
```

### Task 3: Understanding Git Reset

```bash
# Create some commits to work with
echo "feature1" > feature1.txt
git add feature1.txt
git commit -m "Add feature 1"

echo "feature2" > feature2.txt
git add feature2.txt
git commit -m "Add feature 2"

echo "feature3" > feature3.txt
git add feature3.txt
git commit -m "Add feature 3"

git log --oneline  # See commit history

# Soft reset - keep changes staged
git reset --soft HEAD~1
git status  # feature3.txt still staged
git log --oneline  # Last commit gone

# Recommit
git commit -m "Add feature 3 (recommitted)"
```

### Task 4: Mixed and Hard Reset

```bash
# Mixed reset (default) - unstage changes
git reset HEAD~1
git status  # feature3.txt unstaged but exists
ls  # File still there

# Add it back and commit
git add feature3.txt
git commit -m "Add feature 3 again"

# Hard reset - DANGER: loses changes
git log --oneline
git reset --hard HEAD~2
git status  # Clean
git log --oneline  # Back to initial state
ls  # feature2.txt and feature3.txt gone!
```

### Task 5: Recovery Techniques

```bash
# Oh no! We lost work. How to recover?
git reflog  # Shows all ref changes

# Find the commit we want to recover
git log --oneline  # Current state
git reflog | grep "Add feature"

# Reset to recovered commit
COMMIT_HASH=$(git reflog | grep "Add feature 3" | head -1 | cut -d' ' -f1)
git reset --hard $COMMIT_HASH

# Verify recovery
git log --oneline
ls
```

### Task 6: Selective Reset

```bash
# Reset specific files
echo "modified" >> README.md
echo "modified" >> app.py
echo "modified" >> feature1.txt

git add .
git status

# Reset specific file from staging
git reset app.py
git status  # app.py unstaged, others staged

# Reset file to last commit
git checkout -- app.py
cat app.py  # Back to original

# Commit remaining changes
git commit -m "Modify README and feature1"
```

### Task 7: Advanced Stash Operations

```bash
# Stash including untracked files
echo "temp.log" > temp.log
echo "cache.tmp" > cache.tmp
git status

git stash -u  # Include untracked files
git status  # All clean

# Partial stashing
git stash pop
echo "more changes" >> README.md
echo "debug info" >> app.py

git add -p  # Interactively stage
git stash --keep-index  # Stash unstaged only

git status
git stash list
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Used git stash to save work-in-progress
- [ ] Applied and managed multiple stashes
- [ ] Understand git reset --soft, --mixed, --hard
- [ ] Successfully recovered lost commits using reflog
- [ ] Used selective reset operations
- [ ] Understand when to use each technique

## 💡 Key Concepts

### Git Stash
- Temporary storage for uncommitted changes
- Useful when switching branches quickly
- Can stash multiple times (stack-based)

### Git Reset Types
- `--soft`: Move HEAD, keep staging area and working directory
- `--mixed` (default): Move HEAD, reset staging, keep working directory  
- `--hard`: Move HEAD, reset staging and working directory (DESTRUCTIVE)

### Git Reflog
- Records all reference updates
- Useful for recovery
- Local to your repository

## Troubleshooting

**"Cannot apply stash - conflicts"**
- Stash conflicts with current changes
- Resolve conflicts manually or stash current work first

**"Cannot reset - uncommitted changes"**
- Reset would lose changes
- Commit, stash, or use `--hard` (carefully!)

**"Lost commits after reset"**
- Use `git reflog` to find lost commits
- Reset to the desired commit hash

## Next Steps

1. Proceed to [Exercise 8: Interactive Rebase](../08-rebase/README.md)
2. Practice safe undo operations
3. Learn about git revert for shared history

## Additional Resources

- [Git Tools - Stashing and Cleaning](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)
- [Git Basics - Undoing Things](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things)

---

**Great work!** You can now safely manage work-in-progress and undo changes.