# Exercise 11: Advanced Git Operations

**Objective**: Master advanced Git operations for complex scenarios and repository management.

**Estimated Time**: 35-40 minutes

**Difficulty**: Advanced

## What You'll Learn

- Git bisect for bug hunting
- Git cherry-pick for selective commits
- Git submodules for project dependencies
- Git worktrees for parallel development
- Advanced Git configuration and aliases

## Prerequisites

- Completed Exercises 1-10
- Strong understanding of Git fundamentals
- Experience with Git workflows

## Tasks

### Task 1: Git Bisect - Finding Bugs

```bash
mkdir bisect-practice
cd bisect-practice
git init

# Create a project with a hidden bug
echo "def calculate(x):" > calculator.py
echo "    return x * 2" >> calculator.py

git add calculator.py
git commit -m "Initial calculator: multiply by 2"

# Add more features (some introducing bugs)
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        # Introduce a bug in commit 5
        echo "def calculate(x):" > calculator.py
        echo "    return x * 3 + 1  # BUG: should be x * 2" >> calculator.py
    elif [ $i -eq 7 ]; then
        # Add more complexity
        echo "def calculate(x):" > calculator.py
        echo "    result = x * 3 + 1" >> calculator.py
        echo "    return result" >> calculator.py
    else
        # Normal evolution
        echo "# Version $i" >> calculator.py
    fi
    
    git add calculator.py
    git commit -m "Update calculator v$i"
done

# Create test to find the bug
cat > test_calculator.py << 'EOF'
from calculator import calculate

def test_calculate():
    result = calculate(5)
    expected = 10  # 5 * 2 = 10
    if result != expected:
        print(f"Bug found! Expected {expected}, got {result}")
        exit(1)
    else:
        print("Test passed")
        exit(0)

if __name__ == "__main__":
    test_calculate()
EOF

# Start bisect
git log --oneline
git bisect start HEAD HEAD~10  # Bad commit is HEAD, good is 10 commits ago

# Git will checkout a commit in the middle
python3 test_calculator.py

# If test fails:
git bisect bad

# If test passes:
# git bisect good

# Continue until Git finds the first bad commit
# (This is interactive, so simulate the process)
echo "Bisect process would continue until bug is found"
git bisect reset
```

### Task 2: Cherry-Pick Operations

```bash
# Create branches with specific commits to cherry-pick
git checkout -b feature-logging

echo "import logging" >> calculator.py
echo "logging.basicConfig(level=logging.INFO)" >> calculator.py
git add calculator.py
git commit -m "Add logging setup"

echo "def log_calculation(x, result):" >> calculator.py
echo "    logging.info(f'Calculated {x} -> {result}')" >> calculator.py
git add calculator.py
git commit -m "Add calculation logging function"

# Switch to different branch
git checkout main
git checkout -b feature-validation

echo "def validate_input(x):" > validation.py
echo "    if not isinstance(x, (int, float)):" >> validation.py
echo "        raise TypeError('Input must be a number')" >> validation.py
git add validation.py
git commit -m "Add input validation"

# Cherry-pick specific commit from logging branch
LOGGING_COMMIT=$(git log --oneline feature-logging | grep "Add logging setup" | cut -d' ' -f1)
git cherry-pick $LOGGING_COMMIT

# Cherry-pick multiple commits
git cherry-pick feature-logging~1..feature-logging

git log --oneline --graph --all
```

### Task 3: Git Submodules

```bash
cd ..
mkdir main-project
cd main-project
git init

# Add a submodule (simulate external library)
mkdir external-lib
cd external-lib
git init

echo "def utility_function():" > utils.py
echo "    return 'Hello from submodule'" >> utils.py

git add utils.py
git commit -m "Initial utility function"

cd ..
git submodule add ./external-lib lib
git commit -m "Add external library as submodule"

# Work with submodule
echo "from lib.utils import utility_function" > main.py
echo "print(utility_function())" >> main.py

git add main.py
git commit -m "Use external library"

# Update submodule
cd lib
echo "def another_function():" >> utils.py
echo "    return 'Another utility'" >> utils.py

git add utils.py
git commit -m "Add another utility function"

cd ..
git add lib  # Update submodule reference
git commit -m "Update external library"

# Show submodule status
git submodule status
cat .gitmodules
```

### Task 4: Git Worktrees

```bash
cd ..
mkdir worktree-practice
cd worktree-practice
git init

# Initial setup
echo "# Main Project" > README.md
git add README.md
git commit -m "Initial commit"

# Create additional worktrees
git worktree add ../worktree-feature feature-branch
git worktree add ../worktree-hotfix hotfix-branch

# Work in different worktrees simultaneously
cd ../worktree-feature
echo "def new_feature():" > feature.py
echo "    pass" >> feature.py

git add feature.py
git commit -m "Add new feature"

cd ../worktree-hotfix
echo "## Hotfix Applied" >> README.md
git add README.md
git commit -m "Apply critical hotfix"

# Back to main worktree
cd ../worktree-practice
git worktree list

# Merge changes
git merge feature-branch
git merge hotfix-branch

# Clean up worktrees
git worktree remove ../worktree-feature
git worktree remove ../worktree-hotfix
```

### Task 5: Advanced Configuration

```bash
# Configure advanced Git settings
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.visual "!gitk"

# Configure merge and diff tools
git config --global merge.tool vimdiff
git config --global diff.tool vimdiff

# Set up rerere (reuse recorded resolution)
git config --global rerere.enabled true

# Configure push behavior
git config --global push.default current
git config --global push.autoSetupRemote true

# Show all configuration
git config --global --list | grep -E "(alias|merge|diff|rerere|push)"
```

### Task 6: Advanced Log and Search

```bash
# Create repository with rich history for searching
mkdir search-practice
cd search-practice
git init

# Create files with different content
echo "function login(username, password) {" > auth.js
echo "    // Authentication logic" >> auth.js
echo "}" >> auth.js

echo "def authenticate_user(username, password):" > auth.py
echo "    # Python authentication" >> auth.py

echo "class AuthenticationService {" > auth.java
echo "    // Java authentication" >> auth.java
echo "}" >> auth.java

git add .
git commit -m "Add authentication in multiple languages"

# More commits with various changes
echo "function logout() {" >> auth.js
echo "    // Logout logic" >> auth.js
echo "}" >> auth.js

git add auth.js
git commit -m "Add logout functionality to JavaScript"

echo "def logout_user():" >> auth.py
echo "    # Python logout" >> auth.py

git add auth.py
git commit -m "Add logout functionality to Python"

# Advanced log searches
echo "=== Searching commit history ==="
git log --grep="authentication"
git log --author="$(git config user.name)"
git log --since="1 day ago"
git log --oneline --grep="logout"

# Search code content
echo "=== Searching code content ==="
git log -S"authentication" --oneline
git log -G"function.*login" --oneline

# Pickaxe search for specific changes
git log -p -S"logout"

# Search across all branches
git log --all --grep="Add"
```

### Task 7: Repository Maintenance

```bash
# Repository cleanup and optimization
echo "=== Repository Maintenance ==="

# Check repository size
du -sh .git

# Garbage collection
git gc --aggressive --prune=now

# Check for unreferenced objects
git fsck --full

# Show repository statistics
git count-objects -v

# Clean up untracked files (dry run first)
git clean -n
# git clean -f  # Actually clean

# Remove old branches (simulate)
echo "Checking for merged branches to clean up..."
git branch --merged | grep -v "main\|master" | head -5

# Prune remote tracking branches
git remote prune origin

# Check reflog
git reflog --expire=90.days.ago --expire-unreachable=30.days.ago --all
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Used git bisect to find a bug
- [ ] Cherry-picked commits between branches
- [ ] Worked with git submodules
- [ ] Created and used git worktrees  
- [ ] Configured advanced Git aliases and settings
- [ ] Performed advanced log searches
- [ ] Executed repository maintenance tasks

## 💡 Key Concepts

### Git Bisect
- Binary search through commit history
- Automates finding the commit that introduced a bug
- Use `git bisect run <script>` for automation

### Cherry-Pick
- Apply specific commits to current branch
- Useful for backporting fixes
- Can cause duplicate commits if not careful

### Submodules
- Include other Git repositories as subdirectories
- Maintain specific commit references
- Useful for shared libraries

### Worktrees
- Multiple working directories for one repository
- Work on different branches simultaneously
- Faster than cloning multiple copies

### Advanced Configuration
- Aliases for frequently used commands
- Tool configuration for merge/diff
- Rerere for conflict resolution reuse

## Troubleshooting

**"Bisect in progress"**
- Complete with `git bisect good/bad` or reset with `git bisect reset`

**"Submodule issues"**
- Use `git submodule update --init --recursive`
- Check `.gitmodules` configuration

**"Worktree conflicts"**
- Can't checkout same branch in multiple worktrees
- Use different branches for each worktree

**"Configuration conflicts"**
- Check precedence: local > global > system
- Use `git config --list --show-origin`

## Next Steps

1. Proceed to [Exercise 12: Git Best Practices](../12-best-practices/README.md)
2. Apply these techniques in real projects
3. Explore Git internals and plumbing commands

## Additional Resources

- [Git Bisect](https://git-scm.com/docs/git-bisect)
- [Git Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
- [Git Worktrees](https://git-scm.com/docs/git-worktree)

---

**Impressive!** You've mastered advanced Git operations for complex development scenarios.