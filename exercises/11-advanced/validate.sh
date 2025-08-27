#!/bin/bash

echo "🔍 Validating Exercise: ${PWD##*/}"
echo "================================"

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

passed=0
total=5

echo -n "1. Checking Git repository... "
if [[ -d ".git" ]]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (Not a Git repository)"
fi

echo -n "2. Checking commit history... "
commit_count=$(git rev-list --count HEAD 2>/dev/null || echo "0")
if [[ $commit_count -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($commit_count commits)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No commits found)"
fi

echo -n "3. Checking working directory... "
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo -e "${GREEN}✓ PASS${NC} (Clean working directory)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ WARNING${NC} (Uncommitted changes)"
    ((passed++))
fi

echo -n "4. Checking files... "
file_count=$(git ls-files | wc -l)
if [[ $file_count -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} ($file_count files tracked)"
    ((passed++))
else
    echo -e "${RED}✗ FAIL${NC} (No files tracked)"
fi

echo -n "5. Checking recent activity... "
recent_activity=$(git log --since="1 week ago" --oneline | wc -l)
if [[ $recent_activity -gt 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC} (Recent activity found)"
    ((passed++))
else
    echo -e "${YELLOW}⚠ INFO${NC} (No recent activity)"
    ((passed++))
fi

echo
echo "================================"
echo "Results: $passed/$total checks passed"

if [[ $passed -ge 4 ]]; then
    echo -e "${GREEN}🎉 Exercise validation completed!${NC}"
    echo "Review the exercise instructions to ensure all tasks were completed."
    exit 0
else
    echo -e "${RED}❌ Please review the exercise instructions.${NC}"
    exit 1
fi
