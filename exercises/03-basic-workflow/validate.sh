#!/bin/bash

# Validation script for Exercise 3: Basic Add, Commit, Push
# This script checks if the student has mastered the basic Git workflow

echo "🔍 Validating Exercise 3: Basic Add, Commit, Push..."
echo "==================================================="

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for passed checks
passed=0
total=7

# Check if we're in a Git repository
if [[ ! -d ".git" ]]; then
    echo -e "${RED}❌ Not in a Git repository${NC}"
    echo "Please run this from inside a Git repository (git-workflow-practice or similar)"
    exit 1
fi

# Check 1: Repository has sufficient commits
echo -n "1. Checking commit count... "
commit_count=$(git rev-list --count HEAD 2>/dev/null)
if [[ $? -eq 0 && $commit_count -ge 4 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($commit_count commits found)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Need at least 4 commits, found: $commit_count)"
fi

# Check 2: Multiple files committed
echo -n "2. Checking for multiple files... "
file_count=$(git ls-files | wc -l)
if [[ $file_count -ge 3 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($file_count files tracked)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Need at least 3 files, found: $file_count)"
fi

# Check 3: Commit messages are descriptive
echo -n "3. Checking commit message quality... "
short_messages=$(git log --pretty=format:"%s" | awk 'length($0) < 10' | wc -l)
total_commits=$(git rev-list --count HEAD)
if [[ $short_messages -eq 0 || $(($short_messages * 100 / $total_commits)) -lt 50 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Descriptive commit messages)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Too many short commit messages)"
fi

# Check 4: Working directory is clean
echo -n "4. Checking working directory status... "
if git diff-index --quiet HEAD --; then
    echo -e "${GREEN}✓ PASS${NC} (Working directory clean)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ WARNING${NC} (Uncommitted changes present)"
    ((passed++))  # Still pass, as this might be expected
fi

# Check 5: Remote repository configured
echo -n "5. Checking remote configuration... "
remote_url=$(git remote get-url origin 2>/dev/null)
if [[ -n "$remote_url" ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($remote_url)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ WARNING${NC} (No remote configured - optional)"
    # Don't increment passed for this optional check
fi

# Check 6: Recent commits show proper Git workflow
echo -n "6. Checking for proper Git workflow... "
recent_commits=$(git log --oneline -5)
if [[ -n "$recent_commits" ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Recent activity found)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No recent commits found)"
fi

# Check 7: Repository has typical project files
echo -n "7. Checking for project structure... "
has_readme=$(git ls-files | grep -i readme | wc -l)
has_code=$(git ls-files | grep -E '\.(py|js|java|cpp|c|txt)$' | wc -l)
if [[ $has_readme -gt 0 && $has_code -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (README and code files present)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Missing README or code files)"
fi

echo
echo "==================================================="
echo "Results: $passed/$total checks passed"

# Bonus checks
echo
echo "📋 Bonus Analysis:"
echo "=================="

# Check for good commit practices
echo "📊 Commit Statistics:"
echo "- Total commits: $commit_count"
echo "- Files tracked: $file_count"
echo "- Average commit message length: $(git log --pretty=format:"%s" | awk '{sum+=length($0)} END {printf "%.1f\n", sum/NR}')"

# Show recent commit history
echo
echo "📝 Recent Commits:"
git log --oneline -5

# Check if pushed to remote
if [[ -n "$remote_url" ]]; then
    echo
    echo "🔗 Remote Status:"
    local_commits=$(git rev-list HEAD 2>/dev/null | wc -l)
    remote_commits=$(git rev-list origin/main 2>/dev/null | wc -l) 2>/dev/null || remote_commits=0
    
    if [[ $local_commits -gt $remote_commits ]]; then
        echo -e "${YELLOW}ℹ INFO${NC} You have $((local_commits - remote_commits)) unpushed commits"
    else
        echo -e "${GREEN}✓ BONUS${NC} All commits are pushed to remote"
    fi
fi

echo

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}🎉 Congratulations! All checks passed!${NC}"
    echo "You've mastered the basic Git workflow!"
    echo "You're ready to move on to Exercise 4."
    exit 0
elif [[ $passed -ge 5 ]]; then
    echo -e "${YELLOW}⚠ Good progress! Please address the remaining issues.${NC}"
    exit 1
else
    echo -e "${RED}❌ More work needed. Please review the exercise instructions.${NC}"
    echo
    echo "💡 Tips:"
    echo "- Make sure you have at least 4 commits"
    echo "- Include multiple files (README, code files, etc.)"
    echo "- Write descriptive commit messages"
    echo "- Consider setting up a remote repository"
    exit 1
fi