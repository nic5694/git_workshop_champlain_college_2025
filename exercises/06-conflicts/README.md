# Exercise 6: Resolving Merge Conflicts

**Objective**: Learn to identify, understand, and resolve merge conflicts effectively.

**Estimated Time**: 25-30 minutes

**Difficulty**: Intermediate

## What You'll Learn

- Understanding when merge conflicts occur
- Reading conflict markers
- Resolving conflicts manually
- Using merge tools
- Preventing conflicts through good practices

## Prerequisites

- Completed Exercises 1-5
- Understanding of branching and merging
- Experience with Git workflow

## Tasks

### Task 1: Create a Conflict Scenario

```bash
# Create repository for conflict practice
mkdir conflict-practice
cd conflict-practice
git init

# Create initial file
cat > story.txt << 'EOF'
Once upon a time, in a land far away,
there lived a brave knight.
The knight had many adventures.
The end.
EOF

git add story.txt
git commit -m "Initial story"
```

### Task 2: Create Conflicting Changes

```bash
# Create feature branch
git checkout -b feature-villain

# Modify the story on feature branch
cat > story.txt << 'EOF'
Once upon a time, in a land far away,
there lived a brave knight.
The knight faced a terrible dragon.
The knight defeated the dragon and saved the kingdom.
The end.
EOF

git add story.txt
git commit -m "Add dragon storyline"

# Switch to main and make conflicting changes
git checkout main

cat > story.txt << 'EOF'
Once upon a time, in a land far away,
there lived a brave knight.
The knight met a wise wizard.
The wizard taught the knight powerful magic.
The end.
EOF

git add story.txt
git commit -m "Add wizard storyline"
```

### Task 3: Trigger and Examine Conflict

```bash
# Try to merge - this will create a conflict
git merge feature-villain

# Examine the conflict
git status
cat story.txt

# See conflict in detail
git diff
```

### Task 4: Resolve Conflict Manually

```bash
# Edit story.txt to resolve conflict
cat > story.txt << 'EOF'
Once upon a time, in a land far away,
there lived a brave knight.
The knight met a wise wizard and faced a terrible dragon.
The wizard taught the knight powerful magic to defeat the dragon.
The knight defeated the dragon and saved the kingdom.
The end.
EOF

# Stage the resolved file
git add story.txt

# Complete the merge
git commit -m "Merge feature-villain: combine wizard and dragon storylines"

# Verify the merge
git log --oneline --graph
```

### Task 5: More Complex Conflict

```bash
# Create multiple conflicting branches
git checkout -b feature-characters

# Add characters
echo "Characters:" >> story.txt
echo "- Sir Galahad (the knight)" >> story.txt
echo "- Merlin (the wizard)" >> story.txt
echo "- Smaug (the dragon)" >> story.txt

git add story.txt
git commit -m "Add character list"

# Create another branch from main
git checkout main
git checkout -b feature-setting

# Add setting information
echo "" >> story.txt
echo "Setting: Medieval kingdom of Camelot" >> story.txt
echo "Time period: 12th century" >> story.txt

git add story.txt
git commit -m "Add setting information"

# Merge first branch
git checkout main
git merge feature-characters

# Try to merge second - conflict!
git merge feature-setting
```

### Task 6: Advanced Conflict Resolution

```bash
# View conflict with context
git diff
git log --merge
git log --oneline --left-right HEAD...MERGE_HEAD

# Resolve by combining both additions
cat >> story.txt << 'EOF'

Setting: Medieval kingdom of Camelot
Time period: 12th century
EOF

# Complete merge
git add story.txt
git commit -m "Merge feature-setting: add both characters and setting"

# Clean up branches
git branch -d feature-villain feature-characters feature-setting
```

### Task 7: Using Merge Tools

```bash
# Configure a merge tool (if available)
git config --global merge.tool vimdiff
# Or: git config --global merge.tool code

# Create another conflict for practice
git checkout -b fix-typos
sed -i 's/knight/brave warrior/g' story.txt
git add story.txt
git commit -m "Replace knight with brave warrior"

git checkout main
sed -i 's/kingdom/realm/g' story.txt
git add story.txt
git commit -m "Replace kingdom with realm"

# Merge with conflict
git merge fix-typos

# Try using merge tool (if configured)
# git mergetool

# Resolve manually if tool not available
cat > story.txt << 'EOF'
Once upon a time, in a land far away,
there lived a brave warrior.
The brave warrior met a wise wizard and faced a terrible dragon.
The wizard taught the brave warrior powerful magic to defeat the dragon.
The brave warrior defeated the dragon and saved the realm.
The end.

Characters:
- Sir Galahad (the brave warrior)
- Merlin (the wizard)
- Smaug (the dragon)

Setting: Medieval realm of Camelot
Time period: 12th century
EOF

git add story.txt
git commit -m "Resolve conflict: use both warrior and realm terms"
```

## Validation

```bash
./validate.sh
```

## Success Criteria

- [ ] Successfully created merge conflicts
- [ ] Resolved conflicts manually
- [ ] Understand conflict markers (<<<<<<, ======, >>>>>>)
- [ ] Completed merge commits
- [ ] Used git status and diff during conflicts
- [ ] Clean working directory after resolution

## 💡 Key Concepts

### Conflict Markers
```
<<<<<<< HEAD
Content from current branch
=======
Content from merging branch
>>>>>>> branch-name
```

### Resolution Process
1. Identify conflicted files with `git status`
2. Edit files to resolve conflicts
3. Remove conflict markers
4. Stage resolved files with `git add`
5. Complete merge with `git commit`

### Prevention Strategies
- Merge frequently
- Keep branches small and focused
- Communicate with team about changes
- Use `.gitattributes` for specific file types

## Troubleshooting

**"Merge conflict in file.txt"**
- Normal conflict message
- Edit the file to resolve conflicts

**"All conflicts fixed but you are still merging"**
- You resolved conflicts but didn't commit
- Run `git commit` to complete the merge

**"fatal: cannot do a partial commit during a merge"**
- You have unresolved conflicts
- Resolve all conflicts and stage files before committing

## Next Steps

1. Proceed to [Exercise 7: Git Stash and Reset](../07-stash-reset/README.md)
2. Practice conflict resolution on team projects
3. Learn about rebase for cleaner history

## Additional Resources

- [Git Branching - Basic Merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
- [Resolving Merge Conflicts](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line)

---

**Excellent!** You can now handle merge conflicts with confidence.