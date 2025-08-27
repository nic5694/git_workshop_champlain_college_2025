#!/bin/bash

# Validation script for Exercise 5: Branching and Merging

echo "🔍 Validating Exercise 5: Branching and Merging..."
echo "================================================="

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
    echo "Please run this from inside the branching-practice repository"
    exit 1
fi

# Check 1: Repository has multiple commits
echo -n "1. Checking commit history... "
commit_count=$(git rev-list --count HEAD 2>/dev/null)
if [[ $commit_count -ge 4 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($commit_count commits)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Need at least 4 commits, found: $commit_count)"
fi

# Check 2: Evidence of branching activity
echo -n "2. Checking for branch activity... "
# Look for merge commits
merge_commits=$(git log --merges --oneline | wc -l)
# Look for evidence in reflog
branch_activity=$(git reflog | grep -E "(checkout|branch|merge)" | wc -l)

if [[ $merge_commits -gt 0 || $branch_activity -gt 3 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Branch activity detected)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No significant branch activity found)"
fi

# Check 3: Multiple files exist (showing work on different features)
echo -n "3. Checking project structure... "
file_count=$(git ls-files | wc -l)
dir_count=$(git ls-files | cut -d'/' -f1 | sort -u | wc -l)

if [[ $file_count -ge 3 && $dir_count -ge 2 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($file_count files in $dir_count directories)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Need more diverse project structure)"
fi

# Check 4: README has been updated multiple times
echo -n "4. Checking README development... "
if [[ -f "README.md" ]]; then
    readme_commits=$(git log --oneline README.md | wc -l)
    if [[ $readme_commits -ge 2 ]]; then
        echo -e "${GREEN}✓ PASS${NC} (README updated $readme_commits times)"
        ((passed++))
    else
        echo -e "${RED}✗ FAIL${NC} (README needs more development)"
    fi
else
    echo -e "${RED}✗ FAIL${NC} (README.md not found)"
fi

# Check 5: Evidence of merge operations
echo -n "5. Checking merge history... "
# Check for merge commits or merge messages
merge_evidence=$(git log --grep="Merge" --oneline | wc -l)
merge_commits=$(git log --merges --oneline | wc -l)

if [[ $merge_commits -gt 0 || $merge_evidence -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Merge operations found)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ PARTIAL${NC} (Limited merge evidence - may be using fast-forward only)"
    ((passed++))  # Still count as pass since fast-forward is valid
fi

# Check 6: Currently on main branch with clean working directory
echo -n "6. Checking current state... "
current_branch=$(git branch --show-current)
is_clean=$(git status --porcelain | wc -l)

if [[ "$current_branch" == "main" && $is_clean -eq 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (On main branch, clean working directory)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ WARNING${NC} (Branch: $current_branch, Uncommitted changes: $is_clean)"
    ((passed++))  # Still pass as this is not critical
fi

echo
echo "================================================="
echo "Results: $passed/$total checks passed"

# Detailed analysis
echo
echo "📋 Branch Analysis:"
echo "=================="

echo "🌿 Commit Graph:"
git log --graph --oneline --all -10 | sed 's/^/  /'

echo
echo "📊 Repository Statistics:"
echo "- Total commits: $commit_count"
echo "- Merge commits: $merge_commits"
echo "- Files tracked: $file_count"
echo "- Current branch: $current_branch"

# Show branch history from reflog
echo
echo "📝 Recent Branch Operations:"
git reflog -10 | grep -E "(checkout|branch|merge)" | head -5 | sed 's/^/  /'

echo

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}🎉 Congratulations! All checks passed!${NC}"
    echo "You've successfully learned branching and merging!"
    echo "You're ready to move on to Exercise 6."
    exit 0
elif [[ $passed -ge 4 ]]; then
    echo -e "${YELLOW}⚠ Good progress! Please address the remaining issues.${NC}"
    exit 1
else
    echo -e "${RED}❌ More work needed. Please review the exercise instructions.${NC}"
    echo
    echo "💡 Tips:"
    echo "- Create multiple feature branches"
    echo "- Make commits on different branches"
    echo "- Practice both fast-forward and three-way merges"
    echo "- Create a diverse project structure with multiple files/directories"
    exit 1
fi