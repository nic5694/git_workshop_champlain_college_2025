In the following folders 001 for Chrsitine's Section and 002 for Bahman's students.

Under the folder create a folder with your full name in snake_case and insert a screenshot of the validation script passing for exercise 1


## Git Merge Conflict Exercise

To practice resolving merge conflicts, follow these steps:

1. **Clone the repository and create a new branch:**
	- `git checkout -b your-branch-name`

2. **Edit the file:**
	- Open `001/merge_conflict.txt` (or `002/merge_conflict.txt` for your section).
	- Change the line:
	  ```
	  This is a line that will cause a conflict.
	  ```
	  to something unique, e.g.:
	  ```
	  This is a line changed by [Your Name].
	  ```

3. **Commit your changes:**
	- `git add 001/merge_conflict.txt`
	- `git commit -m "Changed conflict line"`

4. **Switch back to `main` and make a different change to the same line:**
	- `git checkout main`
	- Edit the same line in `001/merge_conflict.txt` to something else, and commit.

5. **Try to merge your branch into `main`:**
	- `git merge your-branch-name`
	- You will see a merge conflict in `merge_conflict.txt`.

6. **Resolve the conflict:**
	- Open the file and choose which change to keep (or combine them).
	- Remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
	- Save the file.
	- `git add 001/merge_conflict.txt`
	- `git commit -m "Resolved merge conflict"`

This exercise will help you understand how merge conflicts happen and how to resolve them in Git.

