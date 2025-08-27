#!/bin/bash

# Validation script for Exercise 2: Creating Your First Repository
# This script checks if the student has completed the repository creation tasks

echo "🔍 Validating Exercise 2: Creating Your First Repository..."
echo "=========================================================="

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for passed checks
passed=0
total=6

# Check if we need to look for a practice repository
REPO_DIR="my-first-repo"
if [[ -d "$REPO_DIR" ]]; then
    cd "$REPO_DIR"
elif [[ -d "../my-first-repo" ]]; then
    cd "../my-first-repo"
else
    echo -e "${RED}❌ Repository 'my-first-repo' not found${NC}"
    echo "Please create the repository as instructed in the exercise."
    exit 1
fi

# Check 1: Git repository exists
echo -n "1. Checking if Git repository is initialized... "
if [[ -d ".git" ]]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No .git directory found)"
fi

# Check 2: README.md exists with content
echo -n "2. Checking for README.md file... "
if [[ -f "README.md" && -s "README.md" ]]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (README.md not found or empty)"
fi

# Check 3: hello.py exists
echo -n "3. Checking for hello.py file... "
if [[ -f "hello.py" ]]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (hello.py not found)"
fi

# Check 4: At least 2 commits exist
echo -n "4. Checking commit history... "
commit_count=$(git rev-list --count HEAD 2>/dev/null)
if [[ $? -eq 0 && $commit_count -ge 2 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($commit_count commits found)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Need at least 2 commits, found: $commit_count)"
fi

# Check 5: Current branch exists and has commits
echo -n "5. Checking current branch... "
current_branch=$(git branch --show-current 2>/dev/null)
if [[ -n "$current_branch" ]]; then
    echo -e "${GREEN}✓ PASS${NC} (On branch: $current_branch)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No current branch or no commits)"
fi

# Check 6: Repository has meaningful commit messages
echo -n "6. Checking commit messages... "
commit_messages=$(git log --pretty=format:"%s" 2>/dev/null)
if [[ -n "$commit_messages" && ! $(echo "$commit_messages" | grep -q "^$") ]]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No commit messages found)"
fi

echo
echo "=========================================================="
echo "Results: $passed/$total checks passed"

# Bonus checks (optional)
echo
echo "📋 Bonus Checks:"
echo "=================="

# Check for remote
remote_url=$(git remote get-url origin 2>/dev/null)
if [[ -n "$remote_url" ]]; then
    echo -e "${GREEN}✓ BONUS${NC} Remote repository configured: $remote_url"
else
    echo -e "${YELLOW}ℹ INFO${NC} No remote repository configured (optional)"
fi

# Check README content
if [[ -f "README.md" ]]; then
    if grep -q "My First Repository" "README.md"; then
        echo -e "${GREEN}✓ BONUS${NC} README has proper title"
    else
        echo -e "${YELLOW}ℹ INFO${NC} Consider adding a proper title to README"
    fi
fi

echo

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}🎉 Congratulations! All checks passed!${NC}"
    echo "You've successfully created your first Git repository."
    echo "You're ready to move on to Exercise 3."
    exit 0
elif [[ $passed -ge 4 ]]; then
    echo -e "${YELLOW}⚠ Good progress! Please address the remaining issues.${NC}"
    exit 1
else
    echo -e "${RED}❌ More work needed. Please review the exercise instructions.${NC}"
    echo
    echo "💡 Tips:"
    echo "- Make sure you're in the my-first-repo directory"
    echo "- Run 'git init' to initialize the repository"
    echo "- Create README.md and hello.py files"
    echo "- Make at least 2 commits with 'git add' and 'git commit'"
    exit 1
fi