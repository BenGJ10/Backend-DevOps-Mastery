# Inodes Deep Dive

## Overview

An **inode (Index Node)** is a core data structure used by Linux file systems to store metadata about a file.

Every file and directory has:

* a unique **inode number**
* metadata stored in that inode
* a filename stored separately in a directory entry

Understanding inodes is crucial for:

* hard links
* file system debugging
* storage limits
* performance tuning
* forensic analysis

Without understanding inodes, you don’t truly understand how Linux stores data.

---

## What Is an Inode?

An inode stores **file metadata**, but NOT the filename.

It contains:

* file type
* permissions
* owner (UID)
* group (GID)
* file size
* timestamps (atime, mtime, ctime)
* link count
* disk block pointers

Think of it as a **file’s identity card**.

---

## Where Are Inodes Used?

Inodes are used by Linux file systems like:

* ext4
* XFS
* Btrfs

These file systems organize disk storage using:

* superblocks
* inode tables
* data blocks

---

## How Linux Stores a File

When you create a file:

```bash
touch file.txt
```

Linux does:

1. Allocates an inode
2. Creates a directory entry (filename → inode number)
3. Allocates data blocks

---

### Storage Flow

```
Filename → Inode → Data Blocks
```

---

## Viewing Inode Numbers

```bash
ls -i file.txt
```

Example:

```
123456 file.txt
```

Here:

* `123456` is the inode number

To view full inode metadata:

```bash
stat file.txt
```

---

## What Inode Does NOT Store

Important:

* ❌ Filename
* ❌ Parent directory

Filenames are stored in directory entries.

This is why multiple filenames (hard links) can point to the same inode.

---

## Hard Links and Inodes

Example:

```bash
echo "hello" > file1.txt
ln file1.txt file2.txt
```

Check:

```bash
ls -li
```

Output:

```
123456 file1.txt
123456 file2.txt
```

Same inode → same file.

Deleting one name does NOT delete the data.

Only when link count = 0 does Linux free the inode and blocks.

---

## Inode Link Count

Check with:

```bash
ls -l
```

Second column shows number of links.

Example:

```
-rw-r--r-- 3 ben ben 2048 file.txt
```

Link count = 3.

---

## Inode and File Deletion

When you run:

```bash
rm file.txt
```

Linux:

1. Removes directory entry
2. Decreases inode link count
3. If link count = 0 → frees data blocks

Data isn't deleted until link count reaches zero.

---

## Running Out of Inodes

You can run out of inodes even if disk space exists.

Check inode usage:

```bash
df -i
```

Example output:

```
Filesystem     Inodes  IUsed  IFree IUse%
/dev/sda1      655360 655360      0 100%
```

Common cause:

* Millions of small files

Often seen in:

* cache directories
* mail servers
* log-heavy systems

---

## Inode vs Disk Blocks

| Concept     | Meaning            |
| ----------- | ------------------ |
| Inode       | Stores metadata    |
| Data Blocks | Store file content |

Small files:

* Use 1 inode
* Use few data blocks

Large files:

* Use 1 inode
* Use many data blocks

---

## How Large Files Work

Inodes contain block pointers:

* Direct pointers
* Indirect pointers
* Double indirect
* Triple indirect

This allows Linux to handle very large files efficiently.

---

## Inode Allocation at Filesystem Creation

When formatting a disk:

```bash
mkfs.ext4 /dev/sdb1
```

The number of inodes is decided at creation time.

It cannot easily be changed later.

This is why planning matters in production systems.

---

## Real Production Scenario

Problem:

```
No space left on device
```

But:

```bash
df -h
```

Shows free space.

Cause:

```bash
df -i
```

Shows 100% inode usage.

This means:

* Too many small files
* No inodes available

Common fix:

* Delete unused small files
* Reformat with higher inode density

---


## Interview Questions

### 1. What is an inode?

**Answer:**
A data structure storing file metadata and disk block pointers.

---

### 2. Does an inode store filename?

**Answer:**
No. Filenames are stored in directory entries.

---

### 3. Why can hard links exist?

**Answer:**
Because multiple filenames can point to the same inode.

---

### 4. Can you run out of inodes?

**Answer:**
Yes, even if disk space remains.

---

### 5. What happens when link count becomes zero?

**Answer:**
The inode and its data blocks are freed.

---

## Summary

* Every file has an inode

* Inodes store metadata, not filenames

* Hard links share the same inode

* Data is freed only when link count reaches zero

* You can run out of inodes before disk space

* Understanding inodes is essential for Linux internals

---
