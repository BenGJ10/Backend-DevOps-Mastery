# Linux Basic Commands

## Overview

Mastering basic Linux commands is foundational for:

* navigating servers
* creating and managing files
* searching logs
* debugging production issues
* automating workflows

Backend engineers spend most of their time inside the terminal — so fluency with these commands is non-negotiable.

---

## 1️⃣ `touch` — Create Empty Files

### Purpose

Creates a new empty file or updates the timestamp of an existing file.

### Syntax

```bash
touch filename
```

### Example

```bash
touch app.log
```

If `app.log` exists, it updates its modification time.

### Common Use Cases

* Creating log files
* Creating placeholder files
* Triggering timestamp updates

---

## 2️⃣ `mkdir` — Create Directories

### Purpose

Creates directories.

### Syntax

```bash
mkdir directory_name
```

### Example

```bash
mkdir project
```

### Create Nested Directories

```bash
mkdir -p project/src/controllers
```

`-p` creates parent directories if they don't exist.

---

## 3️⃣ `cp` — Copy Files

### Purpose

Copies files or directories.

### Copy a File

```bash
cp file1.txt file2.txt
```

### Copy to Another Directory

```bash
cp file.txt /home/ben/
```

---

## 4️⃣ `cp -R` — Copy Directories Recursively

### Purpose

Copies directories along with their contents.

```bash
cp -R project backup_project
```

Without `-R`, directories cannot be copied.

---

## 5️⃣ `mv` — Move or Rename Files

### Rename a File

```bash
mv old.txt new.txt
```

### Move File to Directory

```bash
mv file.txt /var/www/
```

Also used for organizing logs and deployments.

---

## 6️⃣ `rm` — Remove Files

### Remove File

```bash
rm file.txt
```

### Remove Directory Recursively

```bash
rm -r folder
```

### Force Remove

```bash
rm -rf folder
```

⚠️ Extremely dangerous — no confirmation.

---

## 7️⃣ `vi` — Text Editor

vi

`vi` is a lightweight terminal-based text editor available on almost all Linux systems.

### Open File

```bash
vi file.txt
```

### Basic Modes

| Mode    | Purpose    |
| ------- | ---------- |
| Normal  | Navigation |
| Insert  | Editing    |
| Command | Save/exit  |

### Common Shortcuts

* `i` → enter insert mode
* `Esc` → exit insert mode
* `:w` → save
* `:q` → quit
* `:wq` → save and quit
* `:q!` → force quit

Most production servers use `vi` for quick config edits.

---

## 8️⃣ `find` — Search Files in Real Time

### Purpose

Search files by name, size, type, permissions, etc.

### Syntax

```bash
find [path] [condition]
```

### Search by Name

```bash
find /home -name "app.log"
```

### Search by Type

```bash
find /var -type d
```

### Search by Size

```bash
find . -size +10M
```

`find` is powerful and commonly used in debugging.

---

## 9️⃣ `locate` — Fast File Search

### Purpose

Search files using an indexed database.

```bash
locate nginx.conf
```

Much faster than `find`, but may not show recently created files.

Update database:

```bash
sudo updatedb
```

---

## 🔟 `cat` — Display File Content

```bash
cat file.txt
```

Used for:

* reading small files
* checking logs
* debugging configs

---

## 1️⃣1️⃣ `less` — View Large Files

```bash
less large.log
```

Navigate:

* `Space` → next page
* `b` → previous page
* `/keyword` → search

Better than `cat` for large logs.

---

# 1️⃣2️⃣ `pwd` — Print Working Directory

```bash
pwd
```

Shows your current location in the file system.

---

## 1️⃣3️⃣ `ls` — List Files

```bash
ls
```

Common options:

```bash
ls -l    # detailed view
ls -a    # show hidden files
ls -lh   # human-readable sizes
```

---

## 1️⃣4️⃣ `grep` — Search Inside Files

```bash
grep "error" app.log
```

Case insensitive:

```bash
grep -i "error" app.log
```

Used heavily in log analysis.

---


## Interview Questions

### 1. Difference between `find` and `locate`?

**Answer:**
`find` searches in real time; `locate` uses a prebuilt database.

---

### 2. What does `mkdir -p` do?

**Answer:**
Creates parent directories if they don't exist.

---

### 3. Why is `rm -rf` dangerous?

**Answer:**
It recursively deletes files without confirmation.

---

### 4. How do you search for a string inside a file?

**Answer:**
Using `grep`.

---

### 5. How do you copy a directory?

**Answer:**
Using `cp -R`.

---
