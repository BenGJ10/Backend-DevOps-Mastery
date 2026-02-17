# Soft Links vs Hard Links

## Overview

Linux allows multiple references to the same file using **links**.

There are two types:

* **Hard Links**
* **Soft Links (Symbolic Links / Symlinks)**

Understanding links is important for:

* storage efficiency
* backup systems
* file versioning
* DevOps deployments
* understanding inodes

---

## What Is a Hard Link?

A **hard link** is an additional directory entry that points to the **same inode** as the original file.

This means:

* Both filenames point to the same physical data on disk
* Deleting one does NOT delete the data
* Data is removed only when all hard links are deleted

---

### Creating a Hard Link

```bash
ln original.txt hardlink.txt
```

---

### Example

```bash
echo "Hello" > file1.txt
ln file1.txt file2.txt
```

Now:

```bash
ls -li
```

You will see:

```
12345 -rw-r--r-- 2 ben ben 6 file1.txt
12345 -rw-r--r-- 2 ben ben 6 file2.txt
```

Notice:

* Same inode number (`12345`)
* Link count = 2

Both names point to the same data.

---

## What Is a Soft Link (Symbolic Link)?

A **soft link** (symlink) is a special file that stores the **path** of another file.

It does NOT share the same inode.

If the original file is deleted, the symlink becomes broken.

---

### Creating a Soft Link

```bash
ln -s original.txt softlink.txt
```

---

### Example

```bash
ln -s file1.txt link.txt
```

Check with:

```bash
ls -li
```

You’ll see:

* Different inode number
* File type `l`
* Arrow pointing to original file

Example:

```
12345 -rw-r--r-- 1 ben ben 6 file1.txt
67890 lrwxrwxrwx 1 ben ben 9 link.txt -> file1.txt
```

---

## Key Differences

| Feature                    | Hard Link        | Soft Link           |
| -------------------------- | ---------------- | ------------------- |
| Inode                      | Same as original | Different inode     |
| Cross Filesystem           | ❌ No             | ✅ Yes               |
| Links to Directory         | ❌ No             | ✅ Yes               |
| Survives Original Deletion | ✅ Yes            | ❌ No                |
| File Type                  | Regular file     | `l` (symbolic link) |

---

## What Happens When Original File Is Deleted?

### Hard Link Case

```
file1.txt
file2.txt (hard link)
```

Delete:

```bash
rm file1.txt
```

`file2.txt` still works because data still exists.

---

### Soft Link Case

```
file1.txt
link.txt -> file1.txt
```

Delete:

```bash
rm file1.txt
```

Now:

```
link.txt -> broken link
```

The symlink points to a non-existent path.

---

## Why Hard Links Cannot Cross File Systems

Hard links work at the inode level.

Each filesystem has its own inode table.

Therefore, you cannot create:

```bash
ln /home/file.txt /mnt/usb/file.txt
```

If they are different filesystems.

Soft links work because they store a path.

---

## Real Production Use Cases

### Hard Links

* Backup systems
* Deduplication
* File versioning
* Package managers

Example: some package managers use hard links to save disk space.

---

### Soft Links

* Linking config files
* `/bin` linking to `/usr/bin`
* Creating shortcuts
* Version switching

Example:

```
/usr/bin/python -> /usr/bin/python3
```

---

## Checking Link Count

```bash
ls -l
```

Second column shows number of hard links.

Example:

```
-rw-r--r-- 3 ben ben 2048 file.txt
```

Link count = 3

---

## Important Commands

### Create Hard Link

```bash
ln file1 file2
```

### Create Soft Link

```bash
ln -s target linkname
```

### Find Broken Symlinks

```bash
find . -xtype l
```

---

### Conceptual Understanding

Think of:

* **Hard link** → Two names for the same file
* **Soft link** → Shortcut pointing to a file

---

## Interview Questions

### 1. What is the main difference between hard and soft links?

**Answer:**
Hard links share the same inode; soft links store the file path.

---

### 2. What happens if you delete the original file of a hard link?

**Answer:**
The file remains accessible via other hard links.

---

### 3. Can hard links cross filesystems?

**Answer:**
No.

---

### 4. How can you identify a symbolic link?

**Answer:**
It starts with `l` in `ls -l` output.

---

### 5. Why are hard links not allowed for directories?

**Answer:**
To prevent circular references and filesystem corruption.

---

## Summary

* Hard links point to the same inode

* Soft links point to a file path

* Hard links survive original deletion

* Soft links break if original file is deleted

* Hard links cannot cross filesystems

* Soft links can link across filesystems

---
