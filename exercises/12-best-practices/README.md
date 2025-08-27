# Exercise 12: Git Best Practices

**Objective**: Learn and apply Git best practices for professional development and team collaboration.

**Estimated Time**: 30-35 minutes

**Difficulty**: Advanced

## What You'll Learn

- Writing effective commit messages
- Repository organization and structure
- Security best practices
- Performance optimization
- Team collaboration guidelines
- Code review processes

## Prerequisites

- Completed Exercises 1-11
- Experience with all Git fundamentals
- Understanding of team development workflows

## Tasks

### Task 1: Commit Message Best Practices

```bash
mkdir best-practices-demo
cd best-practices-demo
git init

# Configure commit template
cat > .git/commit-template << 'EOF'
# <type>(<scope>): <subject>
#
# <body>
#
# <footer>

# Type: feat, fix, docs, style, refactor, perf, test, chore
# Scope: component, module, or area affected
# Subject: Brief description (50 chars max, imperative mood)
# Body: Detailed explanation (wrap at 72 chars)
# Footer: Breaking changes, issue references
EOF

git config commit.template .git/commit-template

# Example of good commit messages
echo "# User Authentication System" > README.md
git add README.md
git commit -m "feat: initialize user authentication system

Add basic structure for user authentication including:
- User registration and login endpoints
- Password hashing utilities
- JWT token management
- Input validation middleware

This establishes the foundation for secure user management
in the application.

Closes #123"

# Add more examples
mkdir src tests docs
echo "class User {}" > src/user.py
echo "# User model tests" > tests/test_user.py
echo "# API Documentation" > docs/api.md

git add .
git commit -m "feat(auth): add user model and basic structure

- Create User class with email and password fields
- Add password hashing using bcrypt
- Include basic validation for email format
- Set up test structure for user model

The User model follows secure practices:
- Passwords are never stored in plain text
- Email validation prevents invalid formats
- Created/updated timestamps for audit trail

Refs #124"
```

### Task 2: Repository Structure and Organization

```bash
# Create professional repository structure
mkdir -p {src/{models,controllers,middleware,utils},tests/{unit,integration},docs/{api,deployment},scripts,config}

# Add appropriate files
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
__pycache__/
*.pyc
.venv/
venv/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Environment
.env
.env.local
.env.*.local

# Build outputs
dist/
build/
*.min.js
*.min.css

# Temporary files
tmp/
temp/
.tmp/

# Database
*.db
*.sqlite
*.sqlite3

# Uploads
uploads/
media/

# Secrets
secrets/
*.key
*.pem
EOF

cat > README.md << 'EOF'
# Project Name

Brief description of what this project does and who it's for.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Installation

```bash
# Clone the repository
git clone https://github.com/username/project-name.git
cd project-name

# Install dependencies
npm install  # or pip install -r requirements.txt
```

## Usage

Basic usage examples here.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.
EOF

cat > CONTRIBUTING.md << 'EOF'
# Contributing Guidelines

## Code Style

- Use descriptive variable names
- Follow language-specific style guides
- Write tests for new features
- Document public APIs

## Commit Messages

Follow the [Conventional Commits](https://conventionalcommits.org/) specification:

```
type(scope): description

[optional body]

[optional footer]
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Update documentation
6. Submit pull request

## Code Review Checklist

- [ ] Code follows style guidelines
- [ ] Tests are included and passing
- [ ] Documentation is updated
- [ ] No sensitive data in commits
- [ ] Commit messages are descriptive
EOF

git add .
git commit -m "docs: add project structure and contributing guidelines

Establish professional repository organization:
- Clear directory structure for src, tests, docs
- Comprehensive .gitignore for multiple environments
- README with installation and usage instructions
- Contributing guidelines for team collaboration

This structure supports scalable development and makes
the project accessible to new contributors."
```

### Task 3: Security Best Practices

```bash
# Demonstrate security practices
echo "=== Security Best Practices ==="

# 1. Never commit secrets
cat > config/example.env << 'EOF'
# Copy this file to .env and fill in your values
DATABASE_URL=your_database_url_here
API_KEY=your_api_key_here
JWT_SECRET=your_jwt_secret_here
EOF

echo "# Never add actual .env files" >> .gitignore
echo ".env*" >> .gitignore

# 2. Use secrets scanning
cat > scripts/check-secrets.sh << 'EOF'
#!/bin/bash

echo "Checking for potential secrets..."

# Check for common secret patterns
secret_patterns=(
    "password\s*=\s*['\"][^'\"]*['\"]"
    "api_key\s*=\s*['\"][^'\"]*['\"]"
    "secret\s*=\s*['\"][^'\"]*['\"]"
    "[A-Za-z0-9]{32,}"  # Long hex strings
)

for pattern in "${secret_patterns[@]}"; do
    if git log --all -S"$pattern" --oneline | head -1; then
        echo "⚠️  Potential secret found: $pattern"
    fi
done

echo "✅ Secret check completed"
EOF

chmod +x scripts/check-secrets.sh

# 3. Signed commits (demonstrate setup)
echo "Setting up signed commits..."
git config --global commit.gpgsign false  # Set to true if you have GPG
git config --global user.signingkey YOUR_GPG_KEY_ID

git add .
git commit -m "security: implement secrets management and scanning

Add security measures to prevent credential leaks:
- Example environment file with placeholders
- Updated .gitignore to exclude environment files
- Script to scan for potential secrets in history
- Documentation for signed commits setup

These practices prevent accidental exposure of sensitive
information and establish security-first development."
```

### Task 4: Performance and Maintenance

```bash
# Performance optimization practices
cat > scripts/git-maintenance.sh << 'EOF'
#!/bin/bash

echo "=== Git Repository Maintenance ==="

echo "Repository size before cleanup:"
du -sh .git

echo "Running garbage collection..."
git gc --aggressive --prune=now

echo "Checking repository integrity..."
git fsck --full

echo "Repository statistics:"
git count-objects -v

echo "Cleaning up merged branches..."
git branch --merged main | grep -v "main\|master" | xargs -n 1 git branch -d 2>/dev/null || true

echo "Pruning remote tracking branches..."
git remote prune origin 2>/dev/null || true

echo "Repository size after cleanup:"
du -sh .git

echo "✅ Maintenance completed"
EOF

chmod +x scripts/git-maintenance.sh

# Large file handling
echo "=== Large File Management ==="
cat > .gitattributes << 'EOF'
# Large files
*.zip filter=lfs diff=lfs merge=lfs -text
*.tar.gz filter=lfs diff=lfs merge=lfs -text
*.mp4 filter=lfs diff=lfs merge=lfs -text
*.mov filter=lfs diff=lfs merge=lfs -text

# Line ending normalization
*.js text eol=lf
*.py text eol=lf
*.md text eol=lf
*.yml text eol=lf
*.yaml text eol=lf

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
EOF

git add .
git commit -m "perf: add maintenance scripts and file handling

Implement repository optimization practices:
- Automated maintenance script for cleanup
- Git attributes for proper file handling
- LFS configuration for large files
- Line ending normalization for consistency

Regular maintenance prevents repository bloat and
ensures optimal performance for the team."
```

### Task 5: Team Collaboration Guidelines

```bash
# Branch naming conventions
cat > docs/branching-strategy.md << 'EOF'
# Branching Strategy

## Branch Types

### Main Branches
- `main`: Production-ready code
- `develop`: Integration branch (if using Git Flow)

### Supporting Branches
- `feature/TICKET-123-short-description`: New features
- `bugfix/TICKET-456-fix-description`: Bug fixes
- `hotfix/critical-security-patch`: Critical production fixes
- `release/v1.2.0`: Release preparation

## Naming Rules
- Use lowercase letters and hyphens
- Include ticket/issue number when available
- Keep descriptions short but descriptive
- Use prefixes consistently

## Workflow
1. Create branch from appropriate base (main/develop)
2. Work on feature/fix
3. Create pull request with description
4. Code review and approval
5. Merge and delete branch

## Examples
```bash
git checkout -b feature/USER-123-add-user-profile
git checkout -b bugfix/BUG-456-fix-login-validation
git checkout -b hotfix/security-patch-auth
```
EOF

# Pull request template
mkdir -p .github
cat > .github/pull_request_template.md << 'EOF'
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added to hard-to-understand areas
- [ ] Documentation updated
- [ ] No console.log or debug statements
- [ ] No sensitive data included

## Screenshots (if applicable)
Add screenshots here.

## Related Issues
Closes #(issue number)
EOF

git add .
git commit -m "docs: add team collaboration guidelines

Establish clear team development standards:
- Branching strategy with naming conventions
- Pull request template for consistent reviews
- Workflow documentation for new team members
- Examples and best practices

These guidelines ensure consistent development
practices across the team and improve code quality."
```

### Task 6: Code Review Best Practices

```bash
# Code review checklist
cat > docs/code-review-checklist.md << 'EOF'
# Code Review Checklist

## Functionality
- [ ] Code accomplishes what it's supposed to do
- [ ] Edge cases are handled appropriately
- [ ] Error handling is robust
- [ ] Performance considerations addressed

## Code Quality
- [ ] Code is readable and well-structured
- [ ] Functions are appropriately sized
- [ ] Variable names are descriptive
- [ ] No code duplication
- [ ] Comments explain "why", not "what"

## Testing
- [ ] Unit tests cover new functionality
- [ ] Tests are meaningful and not just for coverage
- [ ] Integration tests updated if needed
- [ ] Manual testing scenarios documented

## Security
- [ ] No hardcoded secrets or credentials
- [ ] Input validation implemented
- [ ] Authentication/authorization handled correctly
- [ ] No SQL injection or XSS vulnerabilities

## Documentation
- [ ] Public APIs documented
- [ ] README updated if needed
- [ ] Comments added for complex logic
- [ ] Breaking changes documented

## Git Practices
- [ ] Commit messages are descriptive
- [ ] Commits are logically organized
- [ ] No merge commits in feature branch
- [ ] Branch follows naming conventions
EOF

# Review response examples
cat > docs/review-examples.md << 'EOF'
# Code Review Examples

## Constructive Feedback

### Good Examples:
- "Consider using a more descriptive variable name here for clarity"
- "This function is getting large. Could we extract some logic into helper functions?"
- "We should add error handling for this API call"
- "Great solution! Have you considered how this performs with large datasets?"

### Avoid:
- "This is wrong"
- "Bad code"
- "You always do this"
- "Just use X instead"

## Responding to Reviews

### As Author:
- Thank reviewers for their time
- Ask questions if feedback isn't clear
- Explain decisions when needed
- Make requested changes promptly

### As Reviewer:
- Focus on the code, not the person
- Explain the "why" behind suggestions
- Acknowledge good practices
- Be specific in feedback
EOF

git add .
git commit -m "docs: add comprehensive code review guidelines

Provide structured approach to code reviews:
- Detailed checklist covering all aspects
- Examples of constructive feedback
- Guidelines for both reviewers and authors
- Focus on code quality and team growth

Effective code reviews improve code quality,
share knowledge, and strengthen team collaboration."
```

### Task 7: Final Repository Audit

```bash
# Comprehensive repository audit
cat > scripts/repo-audit.sh << 'EOF'
#!/bin/bash

echo "=== Repository Audit ==="

echo "📊 Repository Statistics:"
echo "- Total commits: $(git rev-list --count HEAD)"
echo "- Contributors: $(git log --format='%an' | sort -u | wc -l)"
echo "- Branches: $(git branch -a | wc -l)"
echo "- Tags: $(git tag | wc -l)"
echo "- Files tracked: $(git ls-files | wc -l)"

echo ""
echo "📁 Repository Structure:"
find . -type d -name ".git" -prune -o -type d -print | head -20

echo ""
echo "🔍 Large Files (>1MB):"
git ls-files | xargs ls -la 2>/dev/null | awk '$5 > 1048576 {print $9, $5}' | head -10

echo ""
echo "📝 Recent Activity:"
git log --oneline -10

echo ""
echo "🌿 Active Branches:"
git for-each-ref --format='%(refname:short) %(authordate)' refs/heads | sort -k2

echo ""
echo "✅ Repository audit completed"
EOF

chmod +x scripts/repo-audit.sh

# Run the audit
bash scripts/repo-audit.sh

git add .
git commit -m "feat: add repository audit tooling

Complete best practices implementation with:
- Comprehensive audit script for repository health
- Statistics tracking for project metrics
- File size monitoring for performance
- Activity analysis for team insights

This tooling supports ongoing repository maintenance
and provides visibility into project health."

# Show final repository state
echo "=== Final Repository Structure ==="
tree -a -I '.git' . 2>/dev/null || find . -name ".git" -prune -o -print
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Implemented conventional commit message format
- [ ] Created professional repository structure
- [ ] Applied security best practices
- [ ] Set up performance optimization tools
- [ ] Established team collaboration guidelines
- [ ] Created comprehensive code review process
- [ ] Completed repository audit

## 💡 Key Best Practices Summary

### Commit Messages
- Use conventional commits format
- Keep subject under 50 characters
- Explain "why" in the body
- Reference issues/tickets

### Repository Organization
- Clear directory structure
- Comprehensive .gitignore
- Documentation (README, CONTRIBUTING)
- Proper file attributes

### Security
- Never commit secrets
- Use environment files
- Implement secret scanning
- Consider signed commits

### Performance
- Regular garbage collection
- Monitor repository size
- Use LFS for large files
- Clean up merged branches

### Team Collaboration
- Consistent branching strategy
- Pull request templates
- Code review guidelines
- Clear documentation

## Troubleshooting

**"Repository is getting large"**
- Run git gc regularly
- Use Git LFS for large files
- Clean up old branches and tags

**"Team not following conventions"**
- Use commit hooks for enforcement
- Provide clear documentation
- Regular team training sessions

**"Code review delays"**
- Set review time expectations
- Use draft PRs for early feedback
- Keep PRs small and focused

## Next Steps

1. Apply these practices in your projects
2. Customize guidelines for your team
3. Continue learning advanced Git features
4. Contribute to open source projects

## Additional Resources

- [Conventional Commits](https://conventionalcommits.org/)
- [Git Best Practices](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

---

**🎉 Congratulations!** You've completed all Git exercises and mastered professional Git practices. You're now ready to lead Git adoption in your team and contribute to any software project with confidence.