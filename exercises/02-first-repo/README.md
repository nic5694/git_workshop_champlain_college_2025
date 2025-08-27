# Exercise 2: Creating Your First Repository

**Objective**: Learn how to create and initialize Git repositories both locally and on GitHub.

**Estimated Time**: 15-20 minutes

**Difficulty**: Beginner

## What You'll Learn

- How to initialize a new Git repository
- Understanding the `.git` directory structure
- Creating your first commit
- Connecting local repository to GitHub
- Basic repository status checking

## Prerequisites

- Completed Exercise 1: Basic Git Setup
- GitHub account created
- Git configured with your identity

## Tasks

### Task 1: Create a Local Repository

```bash
# Create a new directory for your project
mkdir my-first-repo
cd my-first-repo

# Initialize the Git repository
git init

# Check the status
git status

# Look at what Git created
ls -la
```

### Task 2: Understand Repository Structure

```bash
# Explore the .git directory (don't modify anything!)
ls -la .git/

# Check current branch
git branch

# Check remote repositories (should be empty)
git remote -v
```

### Task 3: Create Your First File and Commit

```bash
# Create a README file
echo "# My First Repository" > README.md
echo "This is my first Git repository!" >> README.md

# Check repository status
git status

# Add the file to staging area
git add README.md

# Check status again
git status

# Make your first commit
git commit -m "Initial commit: Add README.md"

# View your commit history
git log
git log --oneline
```

### Task 4: Create Additional Content

```bash
# Create a simple Python script
cat > hello.py << 'EOF'
#!/usr/bin/env python3

def main():
    print("Hello, Git!")
    print("This is my first repository.")

if __name__ == "__main__":
    main()
EOF

# Add and commit the new file
git add hello.py
git commit -m "Add hello.py script"

# View your updated log
git log --oneline
```

### Task 5: Connect to GitHub (Optional but Recommended)

```bash
# First, create a new repository on GitHub:
# 1. Go to github.com
# 2. Click "+" in top right corner
# 3. Click "New repository"
# 4. Name it "my-first-repo"
# 5. Don't initialize with README (we already have one)
# 6. Click "Create repository"

# Add the remote origin (replace USERNAME with your GitHub username)
git remote add origin https://github.com/USERNAME/my-first-repo.git

# Verify the remote was added
git remote -v

# Push your commits to GitHub
git push -u origin main

# Check the repository on GitHub in your browser
```

## Validation

Run the validation script to check your work:

```bash
./validate.sh
```

## Success Criteria

- [ ] Git repository initialized successfully
- [ ] At least two commits made with meaningful messages
- [ ] README.md file exists and has content
- [ ] hello.py file exists
- [ ] Repository connected to GitHub remote (optional)
- [ ] Can view commit history with `git log`

## 💡 Key Concepts

### Repository Initialization
- `git init` creates a new Git repository
- The `.git` directory contains all Git metadata
- Initially you'll be on the default branch (main)

### The Three States
Files in Git can be in three states:
1. **Modified** - Changed but not staged
2. **Staged** - Marked for inclusion in next commit
3. **Committed** - Safely stored in Git database

### Working Directory vs Repository
- **Working Directory** - Files you can see and edit
- **Staging Area** - Files ready for next commit
- **Repository** - Git's database of commits

### Remote Repositories
- **Origin** - Default name for main remote repository
- Remotes let you collaborate and backup your work
- `git push` sends commits to remote
- `git pull` gets commits from remote

## Troubleshooting

### Common Issues

**"fatal: not a git repository"**
- Make sure you're in the correct directory
- Run `git init` if you haven't initialized the repo

**"Author identity unknown"**
- Complete Exercise 1 to set up your Git identity
- Run: `git config --global user.name "Your Name"`
- Run: `git config --global user.email "your.email@example.com"`

**"remote origin already exists"**
- Remove existing remote: `git remote rm origin`
- Add the correct remote: `git remote add origin <URL>`

## Next Steps

Once you've completed this exercise:
1. Proceed to [Exercise 3: Basic Add, Commit, Push](../03-basic-workflow/README.md)
2. Try creating another repository on your own
3. Explore other files in the `.git` directory

## Additional Resources

- [Git Basics - Getting a Git Repository](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
- [GitHub - Creating a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

---

**Great job!** You've created your first Git repository and understand the basic workflow.