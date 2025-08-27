# Exercise 9: Git Workflows

**Objective**: Learn professional Git workflows used in team development and open source projects.

**Estimated Time**: 35-40 minutes

**Difficulty**: Advanced

## What You'll Learn

- Git Flow workflow
- GitHub Flow workflow
- Feature branch workflow
- Release management
- Hotfix procedures

## Prerequisites

- Completed Exercises 1-8
- Understanding of branching, merging, and rebasing
- Experience with remote repositories

## Tasks

### Task 1: Git Flow Workflow Setup

```bash
mkdir gitflow-practice
cd gitflow-practice
git init

# Initialize Git Flow structure
git checkout -b develop
echo "# Project" > README.md
git add README.md
git commit -m "Initial project setup"

# Push both branches (if you have remote)
git checkout main
git merge develop
# git push origin main develop
```

### Task 2: Feature Development in Git Flow

```bash
# Create feature branch from develop
git checkout develop
git checkout -b feature/user-authentication

# Develop the feature
mkdir src
echo "class AuthSystem:" > src/auth.py
echo "    def login(self, username, password):" >> src/auth.py
echo "        pass" >> src/auth.py

git add src/
git commit -m "Add authentication system skeleton"

echo "    def logout(self, user):" >> src/auth.py
echo "        pass" >> src/auth.py

git add src/auth.py
git commit -m "Add logout functionality"

# Feature complete - merge back to develop
git checkout develop
git merge --no-ff feature/user-authentication
git branch -d feature/user-authentication

git log --oneline --graph
```

### Task 3: Release Branch Workflow

```bash
# Create release branch
git checkout -b release/1.0.0

# Prepare release
echo "## Version 1.0.0" >> README.md
echo "- User authentication system" >> README.md
echo "- Basic project structure" >> README.md

echo "__version__ = '1.0.0'" > src/version.py

git add .
git commit -m "Prepare release 1.0.0"

# Release is ready - merge to main and develop
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"

git checkout develop  
git merge --no-ff release/1.0.0
git branch -d release/1.0.0

git log --oneline --graph --all
```

### Task 4: Hotfix Workflow

```bash
# Critical bug found in production!
git checkout main
git checkout -b hotfix/security-patch

# Fix the critical issue
echo "    def validate_password(self, password):" >> src/auth.py
echo "        return len(password) >= 8" >> src/auth.py

git add src/auth.py
git commit -m "Add password validation for security"

# Update version
echo "__version__ = '1.0.1'" > src/version.py
git add src/version.py
git commit -m "Bump version to 1.0.1"

# Merge hotfix to main and develop
git checkout main
git merge --no-ff hotfix/security-patch
git tag -a v1.0.1 -m "Hotfix version 1.0.1"

git checkout develop
git merge --no-ff hotfix/security-patch
git branch -d hotfix/security-patch
```

### Task 5: GitHub Flow Workflow

```bash
# Create new repository for GitHub Flow practice
cd ..
mkdir github-flow-practice
cd github-flow-practice
git init

# Main branch is always deployable
echo "# Web Application" > README.md
echo "print('Hello, World!')" > app.py

git add .
git commit -m "Initial deployable application"

# Feature development
git checkout -b add-user-profile

echo "def get_user_profile(user_id):" >> app.py
echo "    return {'id': user_id, 'name': 'User'}" >> app.py

git add app.py
git commit -m "Add user profile function"

echo "## Features" >> README.md
echo "- User profiles" >> README.md

git add README.md
git commit -m "Document user profile feature"

# In real GitHub Flow, this would be a Pull Request
# Simulate review and merge
git checkout main
git merge --no-ff add-user-profile
git branch -d add-user-profile

# Immediate deployment would happen here
```

### Task 6: Feature Branch Workflow

```bash
# Create another feature
git checkout -b feature/api-endpoints

# Develop API
mkdir api
echo "from flask import Flask, jsonify" > api/server.py
echo "app = Flask(__name__)" >> api/server.py
echo "" >> api/server.py
echo "@app.route('/api/users/<int:user_id>')" >> api/server.py
echo "def get_user(user_id):" >> api/server.py
echo "    return jsonify({'id': user_id})" >> api/server.py

git add api/
git commit -m "Add Flask API server"

# Add tests
mkdir tests
echo "import unittest" > tests/test_api.py
echo "class TestAPI(unittest.TestCase):" >> tests/test_api.py
echo "    def test_get_user(self):" >> tests/test_api.py
echo "        pass" >> tests/test_api.py

git add tests/
git commit -m "Add API tests"

# Rebase to clean up history before merge
git rebase -i HEAD~2  # Squash if desired

git checkout main
git merge feature/api-endpoints
git branch -d feature/api-endpoints
```

### Task 7: Release Management

```bash
# Prepare for release
git checkout -b prepare-release-2.0

# Update documentation
cat >> README.md << 'EOF'

## Version 2.0.0
- RESTful API endpoints
- User profile management
- Comprehensive test suite

## Installation
```bash
pip install flask
python api/server.py
```
EOF

echo "__version__ = '2.0.0'" > version.py

git add .
git commit -m "Prepare version 2.0.0 release"

# Create release
git checkout main
git merge prepare-release-2.0
git tag -a v2.0.0 -m "Release version 2.0.0"
git branch -d prepare-release-2.0

# Show complete history
git log --oneline --graph --all
git tag
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Implemented Git Flow workflow with develop/main branches
- [ ] Created feature branches and merged properly  
- [ ] Managed releases with release branches
- [ ] Handled hotfixes correctly
- [ ] Used GitHub Flow for continuous deployment
- [ ] Applied feature branch workflow
- [ ] Tagged releases appropriately

## 💡 Key Concepts

### Git Flow
- **main**: Production-ready code
- **develop**: Integration branch for features
- **feature/***: Individual features
- **release/***: Prepare new releases
- **hotfix/***: Critical production fixes

### GitHub Flow
- **main**: Always deployable
- **feature-branches**: Short-lived, frequently merged
- **Pull Requests**: Code review and discussion
- **Deploy**: Immediately after merge

### Workflow Comparison

| Aspect | Git Flow | GitHub Flow | Feature Branch |
|--------|----------|-------------|----------------|
| Complexity | High | Low | Medium |
| Release Cycle | Scheduled | Continuous | Flexible |
| Team Size | Large | Small-Medium | Any |
| Best For | Traditional releases | Web applications | Most projects |

## Troubleshooting

**"Merge conflicts in workflow"**
- More common with multiple branches
- Use rebase to stay up-to-date with main branch

**"Too many branches"**
- Clean up merged branches regularly
- Use `git branch -d` for merged branches

**"Lost track of workflow"**
- Use `git log --graph --all` to visualize
- Stick to established team conventions

## Next Steps

1. Proceed to [Exercise 10: Git Hooks and Automation](../10-hooks/README.md)
2. Choose appropriate workflow for your team
3. Practice with real projects and pull requests

## Additional Resources

- [Git Flow Original Post](https://nvie.com/posts/a-successful-git-branching-model/)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- [Feature Branch Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)

---

**Outstanding!** You now understand professional Git workflows for team collaboration.