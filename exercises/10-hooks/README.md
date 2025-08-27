# Exercise 10: Git Hooks and Automation

**Objective**: Learn to automate workflows and enforce standards using Git hooks and automation tools.

**Estimated Time**: 30-35 minutes

**Difficulty**: Advanced

## What You'll Learn

- Understanding Git hooks
- Creating pre-commit hooks
- Post-commit automation
- Server-side hooks
- CI/CD integration with Git

## Prerequisites

- Completed Exercises 1-9
- Basic scripting knowledge (bash/python)
- Understanding of Git workflows

## Tasks

### Task 1: Understanding Git Hooks

```bash
mkdir hooks-practice
cd hooks-practice
git init

# Explore hooks directory
ls -la .git/hooks/
cat .git/hooks/pre-commit.sample

# See available hooks
ls .git/hooks/*.sample
```

### Task 2: Create Pre-Commit Hook

```bash
# Create executable pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "Running pre-commit checks..."

# Check for debugging statements
if git diff --cached --name-only | grep -E '\.(py|js)$' | xargs grep -l "console.log\|print.*debug\|debugger" 2>/dev/null; then
    echo "❌ Error: Found debugging statements in staged files"
    echo "Please remove debugging code before committing"
    exit 1
fi

# Check for large files
for file in $(git diff --cached --name-only); do
    if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        if [ $size -gt 1048576 ]; then  # 1MB
            echo "❌ Error: File $file is larger than 1MB"
            exit 1
        fi
    fi
done

echo "✅ Pre-commit checks passed"
EOF

chmod +x .git/hooks/pre-commit
```

### Task 3: Test Pre-Commit Hook

```bash
# Create a file with debugging code
echo "print('debug: starting app')" > app.py
echo "def main():" >> app.py
echo "    print('Hello, World!')" >> app.py

git add app.py
git commit -m "Add main application"  # Should fail

# Fix the code
sed -i "s/print('debug: starting app')/# Application starting/" app.py
git add app.py
git commit -m "Add main application"  # Should succeed
```

### Task 4: Commit Message Hook

```bash
# Create commit-msg hook
cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash

commit_file=$1
commit_msg=$(cat $commit_file)

# Check commit message format
if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{1,50}"; then
    echo "❌ Error: Commit message format is invalid"
    echo "Expected format: type(scope): description"
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    echo "Example: feat(auth): add user login functionality"
    echo ""
    echo "Your message: $commit_msg"
    exit 1
fi

# Check for capitalization
if echo "$commit_msg" | grep -qE "^[a-z]+\([^)]*\): [A-Z]"; then
    echo "❌ Error: Commit description should start with lowercase"
    exit 1
fi

echo "✅ Commit message format is valid"
EOF

chmod +x .git/hooks/commit-msg

# Test the hook
echo "def test():" >> app.py
echo "    pass" >> app.py

git add app.py
git commit -m "add test function"  # Should fail

git commit -m "feat: add test function"  # Should succeed
```

### Task 5: Pre-Push Hook

```bash
# Create pre-push hook
cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash

echo "Running pre-push checks..."

# Run tests before pushing
if [ -f "test.py" ]; then
    echo "Running tests..."
    python3 test.py
    if [ $? -ne 0 ]; then
        echo "❌ Tests failed. Push aborted."
        exit 1
    fi
    echo "✅ All tests passed"
fi

# Check for TODO/FIXME in code
if git diff origin/main --name-only | grep -E '\.(py|js|java)$' | xargs grep -l "TODO\|FIXME" 2>/dev/null; then
    echo "⚠️  Warning: Found TODO/FIXME comments in pushed code"
    echo "Consider addressing these before pushing to main"
    echo -n "Continue anyway? (y/N): "
    read response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "Push aborted"
        exit 1
    fi
fi

echo "✅ Pre-push checks completed"
EOF

chmod +x .git/hooks/pre-push

# Create a simple test file
cat > test.py << 'EOF'
#!/usr/bin/env python3
import sys

def test_main_function():
    # Simple test - check if main function exists
    try:
        import app
        assert hasattr(app, 'main')
        print("✅ Main function exists")
        return True
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    success = test_main_function()
    sys.exit(0 if success else 1)
EOF

git add test.py
git commit -m "test: add simple test suite"
```

### Task 6: Post-Commit Hook

```bash
# Create post-commit hook for notifications
cat > .git/hooks/post-commit << 'EOF'
#!/bin/bash

# Get commit info
commit_hash=$(git rev-parse HEAD)
commit_msg=$(git log -1 --pretty=format:"%s")
author=$(git log -1 --pretty=format:"%an")

# Log commit info
echo "$(date): $author committed $commit_hash - $commit_msg" >> .git/commit.log

# Send notification (simulate)
echo "📝 Commit notification sent: $commit_msg"

# Update statistics
commits_today=$(git log --since="00:00:00" --oneline | wc -l)
echo "Total commits today: $commits_today"
EOF

chmod +x .git/hooks/post-commit

# Test it
echo "# Documentation" > docs.md
git add docs.md
git commit -m "docs: add documentation file"

# Check the log
cat .git/commit.log
```

### Task 7: Server-Side Hook Simulation

```bash
# Create a "server" repository to simulate server-side hooks
cd ..
git clone --bare hooks-practice hooks-practice-server.git
cd hooks-practice-server.git

# Create update hook (runs on push)
cat > hooks/update << 'EOF'
#!/bin/bash

refname=$1
oldrev=$2
newrev=$3

echo "Server: Processing push to $refname"

# Prevent force pushes to main
if [ "$refname" = "refs/heads/main" ]; then
    if [ $(git merge-base $oldrev $newrev) != $oldrev ]; then
        echo "❌ Force push to main branch is not allowed"
        exit 1
    fi
fi

# Check for required files in main branch
if [ "$refname" = "refs/heads/main" ]; then
    if ! git cat-file -e $newrev:README.md 2>/dev/null; then
        echo "❌ README.md is required in main branch"
        exit 1
    fi
fi

echo "✅ Server-side checks passed"
EOF

chmod +x hooks/update

cd ../hooks-practice
git remote add server ../hooks-practice-server.git
git push server main
```

### Task 8: GitHub Actions Integration

```bash
# Create GitHub Actions workflow
mkdir -p .github/workflows

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        # pip install -r requirements.txt  # if you have one
    
    - name: Run tests
      run: python test.py
    
    - name: Check code quality
      run: |
        # Simulate linting
        echo "Running code quality checks..."
        if grep -r "TODO\|FIXME" --include="*.py" .; then
          echo "Warning: Found TODO/FIXME comments"
        fi
EOF

git add .github/
git commit -m "ci: add GitHub Actions workflow"
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Created and tested pre-commit hooks
- [ ] Implemented commit message validation
- [ ] Set up pre-push testing
- [ ] Added post-commit notifications
- [ ] Simulated server-side hooks
- [ ] Created CI/CD workflow configuration
- [ ] Understand hook execution order and purposes

## 💡 Key Concepts

### Hook Types

**Client-Side Hooks**
- `pre-commit`: Before commit is created
- `prepare-commit-msg`: Before commit message editor
- `commit-msg`: Validate commit message
- `post-commit`: After commit is created
- `pre-push`: Before push to remote
- `pre-rebase`: Before rebase operation

**Server-Side Hooks**
- `pre-receive`: Before any updates
- `update`: For each branch being updated
- `post-receive`: After all updates
- `post-update`: After all refs are updated

### Best Practices
- Keep hooks fast (< 1 second if possible)
- Make hooks informative with clear error messages
- Use exit codes properly (0 = success, non-zero = failure)
- Test hooks thoroughly
- Document hook requirements for team

### Common Use Cases
- Code quality enforcement (linting, formatting)
- Test running before commits/pushes
- Commit message standardization
- Preventing sensitive data commits
- Automatic documentation generation
- Deployment automation

## Troubleshooting

**"Hook not running"**
- Check file permissions (`chmod +x`)
- Verify hook file name (no extension)
- Check script syntax

**"Hook always fails"**
- Add debugging with `set -x` at top of script
- Check exit codes
- Verify all required tools are available

**"Permission denied"**
- Make sure hook files are executable
- Check if Git can execute the interpreter

## Next Steps

1. Proceed to [Exercise 11: Advanced Git Operations](../11-advanced/README.md)
2. Implement hooks in your team projects
3. Explore advanced CI/CD pipelines

## Additional Resources

- [Git Hooks Documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Pre-commit Framework](https://pre-commit.com/)

---

**Excellent!** You can now automate Git workflows and enforce development standards.