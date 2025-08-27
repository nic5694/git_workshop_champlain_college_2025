# Exercise 5: Branching and Merging

**Objective**: Master Git branching and merging strategies for effective collaboration and feature development.

**Estimated Time**: 30-35 minutes

**Difficulty**: Intermediate

## What You'll Learn

- Creating and managing branches
- Switching between branches
- Merging strategies (fast-forward, three-way merge)
- Resolving basic merge conflicts
- Branch management best practices

## Prerequisites

- Completed Exercises 1-4
- Understanding of basic Git workflow
- Repository with some commit history

## Tasks

### Task 1: Understanding Branches

```bash
# Create a new repository for this exercise
mkdir branching-practice
cd branching-practice
git init

# Create initial commit
echo "# Branching Practice" > README.md
git add README.md
git commit -m "Initial commit"

# Check current branch
git branch
git branch -v  # Verbose output
git status
```

### Task 2: Creating and Switching Branches

```bash
# Create a new branch
git branch feature-login
git branch  # List branches

# Switch to the new branch
git checkout feature-login
# Or use newer syntax: git switch feature-login

# Check current branch
git branch
git status

# Create and switch in one command
git checkout -b feature-dashboard
# Or: git switch -c feature-dashboard
```

### Task 3: Working on Feature Branches

```bash
# Work on dashboard feature
echo "## Dashboard Feature" >> README.md
echo "- User dashboard" >> README.md
echo "- Analytics display" >> README.md

git add README.md
git commit -m "Add dashboard feature documentation"

# Create some code files
mkdir src
echo "def create_dashboard():" > src/dashboard.py
echo "    pass" >> src/dashboard.py

git add src/
git commit -m "Add dashboard.py skeleton"

# Check commit history
git log --oneline
```

### Task 4: Switching Between Branches

```bash
# Go back to main branch
git checkout main
git log --oneline  # Notice dashboard commits are not here

# Check file differences
cat README.md  # Should not have dashboard content
ls src/  # Directory shouldn't exist

# Go back to feature branch
git checkout feature-dashboard
cat README.md  # Dashboard content should be back
ls src/  # Directory exists again
```

### Task 5: Fast-Forward Merge

```bash
# Go to main branch
git checkout main

# Merge feature-dashboard (fast-forward)
git merge feature-dashboard

# Check history - should be linear
git log --oneline
git log --graph --oneline

# Clean up merged branch
git branch -d feature-dashboard
```

### Task 6: Three-Way Merge

```bash
# Create a new feature branch
git checkout -b feature-user-auth

# Add authentication feature
echo "## Authentication" >> README.md
echo "- User login" >> README.md
echo "- Password reset" >> README.md

echo "def authenticate_user():" > src/auth.py
echo "    pass" >> src/auth.py

git add .
git commit -m "Add user authentication feature"

# Switch to main and make different changes
git checkout main
echo "## Project Overview" >> README.md
echo "This project demonstrates Git branching." >> README.md

git add README.md
git commit -m "Add project overview to README"

# Now merge - this will create a merge commit
git merge feature-user-auth

# Check the history
git log --graph --oneline
git log --graph --pretty=format:'%h - %s (%an, %ar)'
```

### Task 7: Advanced Branch Operations

```bash
# Create multiple branches
git checkout -b feature-api
git checkout -b hotfix-critical

# Work on hotfix
echo "## Hotfix Applied" >> README.md
git add README.md
git commit -m "Apply critical security hotfix"

# Merge hotfix to main
git checkout main
git merge hotfix-critical

# Delete hotfix branch
git branch -d hotfix-critical

# Work on API feature
git checkout feature-api
mkdir api
echo "from flask import Flask" > api/app.py
echo "app = Flask(__name__)" >> api/app.py

git add api/
git commit -m "Initialize Flask API"

# More work on API
echo "@app.route('/api/status')" >> api/app.py
echo "def status():" >> api/app.py
echo "    return {'status': 'ok'}" >> api/app.py

git add api/app.py
git commit -m "Add API status endpoint"

# Merge back to main
git checkout main
git merge feature-api
git branch -d feature-api
```

### Task 8: Branch Management

```bash
# View all branches (including deleted ones in reflog)
git branch -a
git reflog

# Create and work with remote tracking branches
# (if you have a remote repository)
git push -u origin main

# View branch relationships
git log --graph --all --oneline
git show-branch
```

## Validation

Run the validation script to check your work:

```bash
./validate.sh
```

## Success Criteria

- [ ] Created multiple feature branches
- [ ] Successfully merged branches using fast-forward
- [ ] Successfully merged branches using three-way merge
- [ ] Understand difference between merge types
- [ ] Can switch between branches safely
- [ ] Cleaned up merged branches

## 💡 Key Concepts

### Branch Types
- **Main/Master**: Primary development branch
- **Feature**: New features under development
- **Hotfix**: Critical fixes that need immediate deployment
- **Release**: Preparing for a new release

### Merge Types

**Fast-Forward Merge**
```
main:    A---B
              \
feature:       C---D

After merge:
main:    A---B---C---D
```

**Three-Way Merge**
```
main:    A---B---E
              \  \
feature:       C---D

After merge:
main:    A---B---E---M
              \     /
feature:       C---D
```

### Best Practices
- Use descriptive branch names
- Keep branches focused on single features
- Merge frequently to avoid conflicts
- Delete merged branches
- Use `git merge --no-ff` for feature branches in teams

## Troubleshooting

### Common Issues

**"Already up to date"**
- The branch you're merging has no new commits
- This is normal if no work was done on the branch

**"Cannot delete branch 'branch-name'"**
- Branch is not fully merged
- Use `git branch -D branch-name` to force delete (be careful!)

**"Checkout conflicts with the following files"**
- You have uncommitted changes
- Commit, stash, or discard changes before switching branches

**"Merge conflict"**
- Two branches modified the same lines
- We'll cover this in Exercise 6!

## Next Steps

Once you've completed this exercise:
1. Proceed to [Exercise 6: Resolving Merge Conflicts](../06-conflicts/README.md)
2. Practice branching workflows on real projects
3. Learn about Git Flow and GitHub Flow

## Additional Resources

- [Git Branching - Branches in a Nutshell](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)
- [Git Flow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

---

**Outstanding!** You now understand how to use branches effectively for development.