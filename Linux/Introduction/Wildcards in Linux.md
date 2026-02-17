# Overview of Wildcards in Linux

## Overview

**Wildcards** (also called glob patterns) are special characters used in Linux to match filenames and directory names.

They are heavily used in:

* file management
* log analysis
* automation scripts
* batch operations
* DevOps workflows

Wildcards allow you to operate on **multiple files at once** without manually typing every filename.

---

## Why Wildcards Matter

Imagine a log directory with:

```
app.log
app.log.1
app.log.2
error.log
debug.log
```

Instead of deleting files one by one, you can use:

```bash
rm *.log
```

Wildcards increase productivity and reduce manual effort.

---

## 1️⃣ `*` — Match Any Number of Characters

Matches zero or more characters.

### Example

```bash
ls *.txt
```

Matches:

```
notes.txt
data.txt
report.txt
```

But NOT:

```
notes.txt.bak
```

---

### Match Anything Starting With

```bash
ls app*
```

Matches:

```
app.log
application.conf
app_backup.tar
```

---

## 2️⃣ `?` — Match Exactly One Character

Matches only one character.

### Example

```bash
ls file?.txt
```

Matches:

```
file1.txt
fileA.txt
```

But NOT:

```
file10.txt
```

Because `10` is two characters.

---

## 3️⃣ `[]` — Match a Range or Set of Characters

### Match Specific Characters

```bash
ls file[123].txt
```

Matches:

```
file1.txt
file2.txt
file3.txt
```

---

### Match a Range

```bash
ls file[a-z].txt
```

Matches lowercase alphabet.

---

### Exclude Characters

```bash
ls file[!1].txt
```

Matches all except `file1.txt`.

---

## 4️⃣ `{}` — Brace Expansion (Pattern Generation)

Brace expansion generates multiple patterns.

```bash
touch file{1,2,3}.txt
```

Creates:

```
file1.txt
file2.txt
file3.txt
```

---

### Range Expansion

```bash
touch file{1..5}.txt
```

Creates:

```
file1.txt
file2.txt
file3.txt
file4.txt
file5.txt
```

---


## Wildcards in Real Production Use

### Delete All Log Files

```bash
rm *.log
```

---

### Backup All Config Files

```bash
cp /etc/*.conf /backup/
```

---

### Find Specific Pattern Logs

```bash
ls error_2025-??-01.log
```

Matches:

```
error_2025-01-01.log
error_2025-12-01.log
```

---

## Wildcards vs Regex

Important distinction:

| Wildcards         | Regular Expressions              |
| ----------------- | -------------------------------- |
| Used by shell     | Used by tools like `grep`, `sed` |
| Simpler           | More powerful                    |
| Filename matching | Pattern matching inside text     |

Example:

```bash
ls *.txt   # wildcard
grep "^a.*z$" file.txt   # regex
```

Wildcards are for **file name expansion**, not text search.

---

## Globbing (How Wildcards Work)

Wildcards are processed by the **shell** before the command runs.

Example:

```bash
rm *.txt
```

The shell expands `*.txt` into:

```bash
rm file1.txt file2.txt file3.txt
```

Then executes the command.

This is called **globbing**.

---

## Hidden Files and Wildcards

Files beginning with `.` are hidden.

```bash
ls *
```

Will NOT show:

```
.gitignore
.env
```

To include hidden files:

```bash
ls .*
```

---

## Safety Tip ⚠️

Before running destructive commands like:

```bash
rm *.log
```

First check:

```bash
ls *.log
```

Always verify what the wildcard expands to.

---

## Interview Questions

### 1. What does `*` match in Linux?

**Answer:**
Zero or more characters.

---

### 2. Difference between `?` and `*`?

**Answer:**
`?` matches exactly one character; `*` matches any number of characters.

---

### 3. What is globbing?

**Answer:**
Shell expansion of wildcard patterns before command execution.

---

### 4. Do wildcards use regex?

**Answer:**
No. Wildcards use glob patterns, which are simpler than regex.

---

### 5. Why don’t hidden files appear with `*`?

**Answer:**
Because files starting with `.` are excluded unless explicitly matched.

---

## Summary

* Wildcards simplify file operations

* `*` matches many characters

* `?` matches one character

* `[]` matches specific ranges

* `{}` generates patterns

* Wildcards are expanded by the shell (globbing)

* Always verify before running destructive commands

---
