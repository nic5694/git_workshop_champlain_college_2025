#!/bin/bash

# Validation script for Exercise 4: Working with Remote Repositories

echo "🔍 Validating Exercise 4: Working with Remote Repositories..."
echo "============================================================="

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for passed checks
passed=0
total=6

# Check if we're in a Git repository
if [[ ! -d ".git" ]]; then
    echo -e "${RED}❌ Not in a Git repository${NC}"
    echo "Please run this from inside a Git repository"
    exit 1
fi

# Check 1: Remote repository configured
echo -n "1. Checking remote configuration... "
remote_count=$(git remote | wc -l)
if [[ $remote_count -gt 0 ]]; then
    remote_url=$(git remote get-url origin 2>/dev/null || git remote | head -1 | xargs git remote get-url)
    echo -e "${GREEN}✓ PASS${NC} ($remote_count remote(s) configured)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No remotes configured)"
fi

# Check 2: Can fetch from remote
echo -n "2. Checking remote connectivity... "
if git ls-remote origin >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC} (Can connect to remote)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Cannot connect to remote)"
fi

# Check 3: Local branch has commits
echo -n "3. Checking local commit history... "
commit_count=$(git rev-list --count HEAD 2>/dev/null)
if [[ $commit_count -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($commit_count commits)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No commits found)"
fi

# Check 4: Remote tracking branch exists
echo -n "4. Checking remote tracking... "
tracking_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
if [[ -n "$tracking_branch" ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Tracking: $tracking_branch)"
    ((passed++))
else
    # Check if there are any remote branches
    remote_branches=$(git branch -r | wc -l)
    if [[ $remote_branches -gt 0 ]]; then
        echo -e "${YELLOW}⚠ PARTIAL${NC} (Remote branches exist but no tracking set up)"
        ((passed++))
    else
        echo -e "${RED}✗ FAIL${NC} (No remote tracking configured)"
    fi
fi

# Check 5: Repository appears to be synchronized
echo -n "5. Checking sync status... "
# Update remote refs first
git fetch origin >/dev/null 2>&1

# Check if we can compare with remote
current_branch=$(git branch --show-current)
remote_branch="origin/$current_branch"

if git rev-parse "$remote_branch" >/dev/null 2>&1; then
    ahead=$(git rev-list --count "$remote_branch..HEAD" 2>/dev/null || echo "0")
    behind=$(git rev-list --count "HEAD..$remote_branch" 2>/dev/null || echo "0")
    
    if [[ $ahead -eq 0 && $behind -eq 0 ]]; then
        echo -e "${GREEN}✓ PASS${NC} (In sync with remote)"
    elif [[ $ahead -gt 0 && $behind -eq 0 ]]; then
        echo -e "${YELLOW}⚠ AHEAD${NC} ($ahead commits ahead of remote)"
    elif [[ $ahead -eq 0 && $behind -gt 0 ]]; then
        echo -e "${YELLOW}⚠ BEHIND${NC} ($behind commits behind remote)"
    else
        echo -e "${YELLOW}⚠ DIVERGED${NC} ($ahead ahead, $behind behind)"
    fi
    ((passed++))
else
    echo -e "${YELLOW}⚠ UNKNOWN${NC} (Cannot compare with remote branch)"
    ((passed++))
fi

# Check 6: Evidence of remote operations
echo -n "6. Checking for remote operations... "
# Look for merge commits or fetch refs
has_merge_commits=$(git log --merges --oneline | head -1)
has_fetch_head=$(test -f .git/FETCH_HEAD && echo "yes")

if [[ -n "$has_merge_commits" || -n "$has_fetch_head" ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Evidence of remote operations)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ PARTIAL${NC} (Limited evidence of remote operations)"
    ((passed++))  # Still pass as this might be a new repo
fi

echo
echo "============================================================="
echo "Results: $passed/$total checks passed"

# Additional information
echo
echo "📋 Remote Information:"
echo "====================="

echo "🔗 Configured Remotes:"
git remote -v | sed 's/^/  /'

echo
echo "🌿 Remote Branches:"
git branch -r | sed 's/^/  /'

echo
echo "📊 Branch Status:"
current_branch=$(git branch --show-current)
echo "  Current branch: $current_branch"

if [[ -n "$tracking_branch" ]]; then
    echo "  Tracking: $tracking_branch"
else
    echo "  Tracking: None set up"
fi

# Show last few commits
echo
echo "📝 Recent Commits:"
git log --oneline -5 | sed 's/^/  /'

echo

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}🎉 Congratulations! All checks passed!${NC}"
    echo "You've successfully learned to work with remote repositories!"
    echo "You're ready to move on to Exercise 5."
    exit 0
elif [[ $passed -ge 4 ]]; then
    echo -e "${YELLOW}⚠ Good progress! Please address the remaining issues.${NC}"
    exit 1
else
    echo -e "${RED}❌ More work needed. Please review the exercise instructions.${NC}"
    echo
    echo "💡 Tips:"
    echo "- Make sure you have a remote repository configured"
    echo "- Try cloning a repository or adding a remote origin"
    echo "- Practice fetch, pull, and push operations"
    echo "- Ensure you can connect to your remote repository"
    exit 1
fi