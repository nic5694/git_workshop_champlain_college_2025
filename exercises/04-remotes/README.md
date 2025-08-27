# Exercise 4: Working with Remote Repositories

**Objective**: Learn to collaborate using remote repositories, including cloning, fetching, pulling, and pushing.

**Estimated Time**: 25-30 minutes

**Difficulty**: Beginner

## What You'll Learn

- Cloning repositories from GitHub
- Understanding remote repository concepts
- Fetching and pulling changes
- Pushing to remotes with different scenarios
- Handling basic remote conflicts

## Prerequisites

- Completed Exercise 1-3
- GitHub account and repository access
- Basic understanding of Git workflow

## Tasks

### Task 1: Clone a Repository

```bash
# Clone this workshop repository to practice
git clone https://github.com/nic5694/git_workshop_champlain_college_2025.git workshop-copy
cd workshop-copy

# Examine the cloned repository
git remote -v
git log --oneline -10
git branch -a  # Show all branches including remote
```

### Task 2: Understanding Remotes

```bash
# Check existing remotes
git remote
git remote -v
git remote show origin

# Add another remote (if you have a fork)
# git remote add upstream https://github.com/original-owner/repo.git

# List all remote branches
git branch -r
git branch -a
```

### Task 3: Fetch vs Pull

```bash
# Fetch updates without merging
git fetch origin

# See what was fetched
git log --oneline origin/main

# Compare local with remote
git log --oneline main..origin/main  # What's new on remote
git log --oneline origin/main..main  # What's new locally

# Pull (fetch + merge)
git pull origin main

# Check status
git status
```

### Task 4: Making Changes and Pushing

```bash
# Create a new branch for your changes
git checkout -b practice-changes

# Make some changes
mkdir practice-area
echo "# My Practice Notes" > practice-area/notes.md
echo "## What I learned today" >> practice-area/notes.md
echo "- Git clone downloads entire repository" >> practice-area/notes.md
echo "- Remotes allow collaboration" >> practice-area/notes.md

# Commit your changes
git add practice-area/
git commit -m "Add practice notes about remote repositories"

# Try to push (this might fail if you don't have write access)
git push origin practice-changes
```

### Task 5: Working with Your Own Repository

```bash
# Go back to your own repository from previous exercises
cd ..
# Or create a new one:
mkdir remote-practice
cd remote-practice
git init

# Create some content
echo "# Remote Practice Repository" > README.md
echo "This repository demonstrates remote Git operations." >> README.md

git add README.md
git commit -m "Initial commit for remote practice"

# Create repository on GitHub and add remote
# git remote add origin https://github.com/YOUR-USERNAME/remote-practice.git

# Push to GitHub
git push -u origin main
```

### Task 6: Simulating Collaboration

```bash
# Create a second local copy to simulate another developer
cd ..
git clone https://github.com/YOUR-USERNAME/remote-practice.git remote-practice-2
cd remote-practice-2

# Make changes as "another developer"
echo "## Installation" >> README.md
echo "git clone this-repository" >> README.md

git add README.md
git commit -m "Add installation instructions"
git push origin main

# Go back to first copy
cd ../remote-practice

# Try to push a change (will be rejected)
echo "## Usage" >> README.md
git add README.md
git commit -m "Add usage section"
git push origin main  # This should fail

# Pull the remote changes first
git pull origin main

# Now push your changes
git push origin main
```

### Task 7: Advanced Remote Operations

```bash
# Check remote tracking
git branch -vv

# Set upstream for easier pushing
git push --set-upstream origin main

# Push all branches
git push --all origin

# Remove a remote
# git remote remove old-remote

# Rename a remote
# git remote rename origin upstream
```

## Validation

Run the validation script to check your work:

```bash
./validate.sh
```

## Success Criteria

- [ ] Successfully cloned a repository
- [ ] Understand difference between fetch and pull
- [ ] Can push changes to remote repository
- [ ] Handle basic merge conflicts from remote
- [ ] Understand remote tracking branches
- [ ] Can work with multiple remotes

## 💡 Key Concepts

### Remote Repository Types
- **Origin**: Default remote when cloning
- **Upstream**: Original repository (when forked)
- **Fork**: Your copy of someone else's repository

### Common Remote Commands
```bash
git clone <url>              # Download repository
git remote -v                # List remotes
git fetch <remote>           # Download updates
git pull <remote> <branch>   # Fetch + merge
git push <remote> <branch>   # Upload commits
```

### Remote Tracking Branches
- Local branches can track remote branches
- `git push -u origin main` sets up tracking
- After setup, just use `git push` and `git pull`

## Troubleshooting

### Common Issues

**"Permission denied" when pushing**
- Check if you have write access to the repository
- Verify your GitHub authentication (token/SSH key)

**"Updates were rejected"**
- Someone else pushed changes first
- Run `git pull` to get latest changes, then push

**"Your branch is behind origin/main"**
- Run `git pull` to get the latest changes
- Or `git fetch` followed by `git merge origin/main`

**"fatal: not a git repository"**
- Make sure you're in the correct directory
- Check if the repository was cloned properly

## Next Steps

Once you've completed this exercise:
1. Proceed to [Exercise 5: Branching and Merging](../05-branching/README.md)
2. Practice collaborating on real projects
3. Learn about forking and pull requests

## Additional Resources

- [Git Basics - Working with Remotes](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
- [GitHub - Managing Remote Repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories)

---

**Fantastic!** You now understand how to collaborate using remote repositories.