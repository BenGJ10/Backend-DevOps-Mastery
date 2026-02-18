# Files and Directories Permissions

## Overview

Linux uses a **permission-based security model** to control who can:

* read files
* modify files
* execute programs
* access directories

Every file and directory in Linux has:

* an **owner (user)**
* a **group**
* permission settings for **owner, group, and others**

Understanding permissions is critical for:

* securing production servers
* debugging “Permission Denied” errors
* managing web servers and databases
* DevOps and container deployments

---

## Viewing Permissions

Use:

```bash
ls -l
```

Example:

```bash
-rwxr-xr-- 1 ben developers 4096 Jan 10 script.sh
```

Let’s break it down.

---

## Permission Structure Explained

```
-rwxr-xr--
│││││││││
││││││││└── Others
││││││└──── Group
│││└──────── Owner
└──────────── File type
```

---

## 1️⃣ File Type Indicator

| Symbol | Meaning          |
| ------ | ---------------- |
| `-`    | Regular file     |
| `d`    | Directory        |
| `l`    | Symbolic link    |
| `c`    | Character device |
| `b`    | Block device     |

Example:

```
drwxr-xr-x
```

`d` → directory

---

## 2️⃣ Permission Groups

Permissions are divided into:

```
Owner | Group | Others
rwx   r-x     r--
```

---

## 3️⃣ Permission Types

| Symbol | Meaning (File)    | Meaning (Directory)                  |
| ------ | ----------------- | ------------------------------------ |
| r      | Read file content | List directory contents              |
| w      | Modify file       | Create/delete files inside directory |
| x      | Execute file      | Enter/traverse directory             |

---

## Directory Permission Example

If a directory has:

```
drwxr-x---
```

* Owner → full access
* Group → read + enter
* Others → no access

If `x` is missing → you cannot enter the directory.

---

## Numeric (Octal) Permissions

Each permission has a value:

| Permission | Value |
| ---------- | ----- |
| r          | 4     |
| w          | 2     |
| x          | 1     |

Add them:

```
rwx = 4+2+1 = 7
r-x = 4+0+1 = 5
r-- = 4+0+0 = 4
```

Example:

```
chmod 754 file.sh
```

Means:

* Owner → 7 (rwx)
* Group → 5 (r-x)
* Others → 4 (r--)

---

## Changing Permissions

### Using Numeric Mode

```bash
chmod 755 script.sh
```

---

### Using Symbolic Mode

```bash
chmod u+x script.sh
chmod g-w file.txt
chmod o=r file.txt
```

Where:

* `u` = user
* `g` = group
* `o` = others
* `a` = all

---

## Changing Ownership

### Change Owner

```bash
chown user file.txt
```

### Change Owner and Group

```bash
chown user:group file.txt
```

Example:

```bash
sudo chown root:root config.conf
```

---

## Special Permission Bits

Linux supports advanced permissions.

---

### 1️⃣ SUID (Set User ID)

When set on an executable:

* Runs with file owner's privileges

```bash
chmod u+s file
```

Example:

```
-rwsr-xr-x
```

`s` replaces `x`.

Used in system binaries like `passwd`.

---

### 2️⃣ SGID (Set Group ID)

* Runs with group privileges
* On directories → new files inherit group

```bash
chmod g+s directory
```

---

### 3️⃣ Sticky Bit

Common in `/tmp`.

Prevents users from deleting files owned by others.

```bash
chmod +t directory
```

Example:

```
drwxrwxrwt
```

`t` indicates sticky bit.

---

## Real Production Scenario

Imagine:

* Nginx cannot read config file
* Application fails with 403 error
* Script won’t execute

You would check:

```bash
ls -l
```

Common issues:

* File not executable (`chmod +x`)
* Wrong ownership (`chown www-data`)
* Directory lacks execute permission

Most production permission bugs come from:

* missing `x` on directories
* incorrect ownership
* wrong numeric mode

---

## Permission Best Practices

### Web Servers

* Files → `644`
* Directories → `755`

### Scripts

* `755`

### Private Files

* `600`

Never use:

```bash
chmod 777
```

Unless absolutely necessary.

---

## Interview Questions

### 1. What does `chmod 755` mean?

**Answer:**
Owner has full permissions; group and others have read and execute.

---

### 2. What does execute permission mean for directories?

**Answer:**
It allows traversal into the directory.

---

### 3. What is SUID?

**Answer:**
A special permission that allows a file to run with the owner's privileges.

---

### 4. Why is `chmod 777` dangerous?

**Answer:**
It gives full permissions to everyone, creating security risks.

---

### 5. How do you change file ownership?

**Answer:**
Using `chown`.

---

## Summary

* Every file has owner, group, and permissions

* Permissions control read, write, execute access

* Directories interpret permissions differently

* Numeric and symbolic modes can modify permissions

* Special bits include SUID, SGID, and sticky bit

* Most Linux production errors involve permissions

---
