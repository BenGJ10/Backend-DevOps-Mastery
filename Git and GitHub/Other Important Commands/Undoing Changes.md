# Undoing Changes

## Overview

Git allows you to **undo changes and move to different points in project history** without losing control of your codebase.  

This capability is often described as **time traveling** — you can inspect, rewind, or modify history at both the file and repository level.

Understanding the appropriate commands and their impact is critical.  
Some operations are **safe and reversible**, while others can **rewrite history** and should be used carefully in shared repositories.

---

## Levels of Undo in Git

You can undo changes at multiple stages:

1. **Working directory** – edits not yet staged  
2. **Staging area** – files added with `git add`  
3. **Committed history** – recorded snapshots  

Different commands apply at each level, covered below.

---

## Undoing Changes in the Working Directory

### Discard unstaged changes in a file

```bash
git restore filename
```

This resets the file to its last committed version.

> Use only if you are sure you don’t need the current edits.

---

### Discard all unstaged changes

```bash
git restore .
```

Reverts the entire working directory to the latest commit.

---

## Undoing Changes in the Staging Area

### Unstage a file (keep changes in working directory)

```bash
git restore --staged filename
```

Moves file back from **staging** to **working directory**.

---

### Unstage everything

```bash
git restore --staged .
```

Useful when you staged too many files accidentally.

---

## Amending the Last Commit

### Modify last commit message or include new changes

```bash
git commit --amend
```

Uses when:

* commit message was incorrect
* you forgot to add a file to the commit

> Avoid amending commits already pushed to shared branches.

---

## Reverting Commits (Safe for Shared Repositories)

### `git revert`

Creates a **new commit** that undoes the changes of a previous commit.

```bash
git revert <commit-hash>
```

Properties:

* history is preserved
* ideal for public/shared branches
* does not rewrite commit history

Example usage: undoing a bad production deployment.

---

## Resetting Commits (History Rewriting — Be Careful)

`git reset` **moves branch pointers** and optionally changes working directory content.

### Soft Reset — keep changes staged

```bash
git reset --soft <commit-hash>
```

* branch pointer moves back
* your changes remain staged
* useful for squashing or reorganizing commits

---

### Mixed Reset (default) — keep changes unstaged

```bash
git reset <commit-hash>
```

* commit history is rewound
* changes remain in working directory
* commonly used to “uncommit” work but keep changes

---

### Hard Reset — dangerous and destructive

```bash
git reset --hard <commit-hash>
```

* history rewritten
* staged and working directory changes deleted
* difficult to recover

Avoid using on pushed/shared branches.

---

## Time Traveling to Older Commits

### Temporarily checkout an old commit

```bash
git checkout <commit-hash>
```

This puts you in a **detached HEAD** state.

You can:

* explore old code
* run previous versions
* debug regressions

To resume normal work:

```bash
git switch main
```

---

## Recovering Lost Commits Using Reflog

### View every movement of HEAD

```bash
git reflog
```

Shows:

* branch moves
* resets
* checkouts
* rebases

You can restore commits that seemed “lost”:

```bash
git reset --hard <reflog-hash>
```

Reflog is your **safety net**.

---

## Practical Backend Scenarios

Undoing or time traveling is common when:

* a buggy commit breaks CI/CD pipelines
* migrations were applied incorrectly
* wrong branch commits were made
* large refactors need rollback
* production hotfixes require reverting behavior

---

## Interview Questions

### 1. What is the difference between `git revert` and `git reset`?

**Answer:**

* `git revert` creates a new commit that undoes changes, preserving history (safe for shared branches)
* `git reset` rewrites history by moving branch pointers and optionally deleting changes (unsafe for shared branches)

---

### 2. What is a “detached HEAD” state?

**Answer:**
Detached HEAD occurs when `HEAD` points directly to a commit instead of a branch, typically when checking out an old commit. New commits here are not attached to any branch unless explicitly branched.

---

### 3. How do you undo the last commit but keep the changes in your working directory?

**Answer:**
Use:

```bash
git reset HEAD~
```

or explicitly:

```bash
git reset --mixed HEAD~
```

This removes the commit while retaining your file modifications.

---

### 4. How can you recover a commit lost after `git reset --hard`?

**Answer:**
Use:

```bash
git reflog
```

find the previous commit reference, then reset back to it.

---

### 5. When should `git revert` be preferred over `git reset`?

**Answer:**
Use `git revert` when the commit is already pushed or shared with others, since it does not rewrite history and is safe in collaborative environments.

---

## Summary

* Git supports undoing changes at working, staging, and commit levels

* `restore` discards file changes safely

* `reset` rewrites history and must be used cautiously

* `revert` safely undoes commits without rewriting history

* `reflog` allows recovery from destructive operations

* Time traveling enables debugging and historic analysis of code

---