# Merge Conflicts How to Resolve Them

## Overview

A **merge conflict** occurs when Git cannot automatically combine changes from two branches because both branches modified the **same part of the codebase in incompatible ways**.  
Git stops the merge to avoid guessing the correct result and asks the developer to resolve the conflict manually.

Understanding **why conflicts happen, how to detect them, and how to resolve them safely** is essential in collaborative backend development.

---

## When Do Merge Conflicts Occur?

Merge conflicts typically occur in the following situations:

- Two branches edit the **same line** in a file
- One branch **deletes** a file that the other branch **modifies**
- Both branches **rename** a file differently
- Structural changes that Git cannot automatically reconcile

Conflicts are not errors in Git — they are a natural result of **parallel development**.

---

## Example Scenario

Assume we have a file `UserService.java`.

### Branch `feature-A` changes this line:
```java
return "Welcome User";
```

### Branch `feature-B` changes the same line:

```java
return "Hello User";
```

When attempting to merge, Git cannot decide which version is correct.

---

## What a Merge Conflict Looks Like in a File

After a conflict, Git marks the conflicting area like this:

```text
<<<<<<< HEAD
return "Welcome User";
=======
return "Hello User";
>>>>>>> feature-B
```

Meaning:

* `HEAD` → current branch changes
* below `=======` → incoming branch changes

You must **edit the file** to choose or combine the correct version.

Example resolution:

```java
return "Welcome User";
```

or

```java
return "Hello User";
```

or a combined one:

```java
return "Hello, Welcome User";
```

Then remove all conflict markers.

---

## Detecting Merge Conflicts

### During merge

```bash
git merge feature-B
```

Output example:

```text
CONFLICT (content): Merge conflict in UserService.java
Automatic merge failed; fix conflicts and commit the result.
```

### Useful commands

```bash
git status
```

Shows files with conflicts as:

```text
both modified: UserService.java
```

---

## Steps to Resolve Merge Conflicts

### Step 1 — Identify conflicting files

```bash
git status
```

### Step 2 — Open and manually edit the conflicting files

Remove:

* `<<<<<<<`
* `=======`
* `>>>>>>>`

Choose the correct code version or manually combine.

### Step 3 — Mark conflicts as resolved

```bash
git add UserService.java
```

### Step 4 — Complete the merge

```bash
git commit
```

Git auto-generates a merge commit message unless you specify one.

---

## Aborting a Merge

If you want to cancel the merge and return to the pre-merge state:

```bash
git merge --abort
```

Used when the merge is too complex or accidental.

---

## Resolving Conflicts Using Stash

If conflicts arise due to local uncommitted changes:

```bash
git stash
git pull
git stash pop
```

You may still need to resolve conflicts after `stash pop`.

---

## Resolving Conflicts in Rebase (Brief)

Conflicts also occur during **rebase**.

Continue after fixing:

```bash
git add .
git rebase --continue
```

Abort rebase if needed:

```bash
git rebase --abort
```

---

## Best Practices to Avoid Merge Conflicts

* Pull latest changes frequently
* Keep feature branches short-lived
* Break large changes into smaller commits
* Avoid formatting changes mixed with logic changes
* Communicate when multiple people modify the same file/module

---

## Interview Questions

1. **What is a merge conflict and why does it occur?**
   Explain conflicting simultaneous edits.

2. **How do you resolve a merge conflict manually?**
   Describe editing conflict markers and committing.

3. **What does `git merge --abort` do?**
   Explain restoring pre-merge state.

4. **What happens internally when Git detects a merge conflict?**
   Discuss automatic merge failure and file marking.

5. **How would you reduce merge conflicts in large teams?**
   Mention frequent pulls, small branches, and communication.

---

## Summary

* Merge conflicts arise when Git cannot auto-combine changes

* Conflicts are normal in collaborative development

* They are resolved by editing files, staging them, and committing

* Merge and rebase both can produce conflicts

* Good branching discipline reduces conflict frequency

---
