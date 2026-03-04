# `git revert` vs `git reset` vs `git restore`

## Overview

Git provides several mechanisms to undo changes at different stages of the development workflow.
Three commonly used commands for this purpose are:

* **`git revert`** — creates a new commit that reverses a previous commit (safe for shared history)

* **`git reset`** — moves the branch pointer to another commit, rewriting history

* **`git restore`** — restores files in the working directory or staging area

---

## Git Workflow Layers

Understanding where each command operates requires knowing the three main Git areas:

```
Working Directory → Staging Area (Index) → Repository (Commits / HEAD)
```

| Layer             | Description                            |
| ----------------- | -------------------------------------- |
| Working Directory | Files currently checked out and edited |
| Staging Area      | Files prepared for the next commit     |
| Repository        | Committed project history              |

Each undo command targets one or more of these layers.

---

## When to Use Each Command

| Situation                                   | Recommended Command    |
| ------------------------------------------- | ---------------------- |
| Undo uncommitted file changes               | `git restore`          |
| Unstage staged files                        | `git restore --staged` |
| Modify or remove local commits (not pushed) | `git reset`            |
| Undo commits already pushed to remote       | `git revert`           |

---

## `git revert`

### Purpose

`git revert` safely undoes a commit by creating a **new commit that reverses its changes**.

Unlike `reset`, it **does not modify existing history**, making it safe for shared branches.

---

### Example

```
Before:
A --- B --- C

After git revert C:
A --- B --- C --- C'
```

`C'` contains the inverse changes of commit `C`.

History remains intact.

---

### Basic Usage

```
git revert <commit-hash>
```

Example:

```
git revert a1b2c3d
```

Git creates a new commit that reverses the specified commit.

To skip the editor:

```
git revert <commit-hash> --no-edit
```

---

### When to Use

Use `git revert` when:

* The commit has already been pushed
* The branch is shared with other developers
* You want to maintain a complete audit history

Avoid using `reset` in these scenarios, as rewriting shared history can cause conflicts for collaborators.

---

### Example Scenario

A buggy commit was pushed to `main`.

```
git log --oneline
```

```
d4e5f67 introduce payment bug
c3b2a1e update auth middleware
```

Revert it safely:
```
git revert d4e5f67
git push
```

A new commit is created that removes the bug while preserving history.

---

## `git reset`

### Purpose

`git reset` moves the current branch pointer (`HEAD`) to a different commit.

This **rewrites history locally**, which makes it powerful but potentially dangerous.

---

### Reset Modes

| Mode                | Commit History | Staging Area | Working Directory |
| ------------------- | -------------- | ------------ | ----------------- |
| `--soft`            | Reset          | Preserved    | Preserved         |
| `--mixed` (default) | Reset          | Cleared      | Preserved         |
| `--hard`            | Reset          | Cleared      | Cleared           |

---

### Visual Example

```
Before:
A --- B --- C --- D (HEAD)

git reset --hard B
```

```
After:
A --- B (HEAD)
```

Commits `C` and `D` are removed from branch history.

---

### Common Usage

### Soft Reset

Keeps all changes staged.

```
git reset --soft <commit>
```

Useful for reorganizing commits before pushing.

---

### Mixed Reset (Default)

Keeps changes in the working directory but removes them from staging.

```
git reset <commit>
```

---

### Hard Reset

Completely discards commits and local changes.

```
git reset --hard <commit>
```

Use with caution, as changes cannot easily be recovered.

---

### When to Use

Use `git reset` when:

* Commits exist only locally
* You want to clean up or reorganize commits
* Work was committed on the wrong branch

Avoid using `reset` on shared branches or commits already pushed to remote repositories.

---

### Example Scenario

Local commit history:

```
f7e8d9c typo fix
e6d7c8b more auth changes
d5c6b7a initial auth setup
c4b5a6e origin/feature-auth
```

Reset to the previous remote commit:

```
git reset c4b5a6e
```

Changes remain in the working directory so they can be recommitted cleanly.

---

## `git restore`

### Purpose

`git restore` restores file contents in the working directory or staging area.

It was introduced in Git 2.23 to replace ambiguous uses of `git checkout`.

This command **does not affect commit history**.

---

### Restore Unstaged Changes

```
git restore <file>
```

Example:

```
git restore config.yaml
```

The file returns to the state of the last commit.

---

### Restore All Files

```
git restore .
```

This discards all unstaged changes in the working directory.

---

### Unstage Files

```
git restore --staged <file>
```

Example:

```
git restore --staged app.js
```

This removes the file from staging but keeps its changes.

---

### Unstage Everything

```
git restore --staged .
```

---

### When to Use

Use `git restore` when:

* Discarding local file edits
* Removing files from the staging area
* Restoring files from a previous commit

It is not used for undoing committed changes.

---

## Comparison

| Feature                  | `git revert`                  | `git reset`            | `git restore`         |
| ------------------------ | ----------------------------- | ---------------------- | --------------------- |
| Purpose                  | Undo committed changes safely | Rewrite commit history | Restore file contents |
| Creates new commit       | Yes                           | No                     | No                    |
| Rewrites history         | No                            | Yes                    | No                    |
| Safe for shared branches | Yes                           | No                     | Yes                   |
| Targets                  | Commits                       | Commits                | Files                 |

---

## Decision Guide

### Undo a pushed commit

```
git revert <commit>
```

---

### Fix local commits before pushing

```
git reset --soft HEAD~2
```

---

### Discard file changes

```
git restore <file>
```

---

### Unstage files

```
git restore --staged <file>
```

---

### Remove recent commits completely

```
git reset --hard HEAD~2
```

Use only when certain that the changes are no longer needed.

---

## Summary

* **`git revert`** safely undoes commits by creating a new commit that reverses previous changes.

* **`git reset`** moves the branch pointer and rewrites local history, making it useful for cleaning up unpushed commits.

* **`git restore`** restores files in the working directory or staging area without affecting commit history.

---