# `sed` Command in Linux

## Overview

`sed` (Stream Editor) is a powerful Linux utility used to **process and transform text streams**.

It is commonly used for:

* searching and replacing text
* editing files automatically
* modifying configuration files
* processing logs and data streams
* automating text transformations in scripts

Unlike traditional editors, `sed` works **non-interactively**, meaning it processes text automatically without opening a text editor.

---

## What Is a Stream Editor?

A **stream editor** processes input line by line and applies commands to transform the text.

Input can come from:

* files
* pipes
* standard input (stdin)

Example:

```bash
sed 's/linux/Linux/' file.txt
```

This replaces the first occurrence of `linux` with `Linux`.

---

## Basic Syntax

```bash
sed [options] 'command' file
```

Example:

```bash
sed 's/apple/orange/' fruits.txt
```

Explanation:

* `s` → substitute command
* `apple` → search pattern
* `orange` → replacement text

---

## Substitute Command (`s`)

The most common `sed` operation is **search and replace**.

Format:

```bash
sed 's/pattern/replacement/' file
```

Example:

```bash
sed 's/error/ERROR/' log.txt
```

Only the **first occurrence per line** is replaced.

---

## Replace All Matches

Use the `g` flag for global replacement.

```bash
sed 's/error/ERROR/g' log.txt
```

Now every occurrence in each line is replaced.

---

## Case-Insensitive Replacement

```bash
sed 's/error/ERROR/gi' file.txt
```

The `i` flag makes matching case-insensitive.

---

## Editing Files In Place

By default, `sed` prints output without modifying the file.

To edit the file directly:

```bash
sed -i 's/localhost/127.0.0.1/g' config.txt
```

This modifies the file itself.

---

## Print Specific Lines

Use `-n` to suppress default output.

Example:

```bash
sed -n '5p' file.txt
```

Prints only line 5.

---

## Print Range of Lines

```bash
sed -n '2,5p' file.txt
```

Prints lines 2 through 5.

---

## Delete Lines

Delete a specific line:

```bash
sed '3d' file.txt
```

Delete range:

```bash
sed '2,4d' file.txt
```

Delete blank lines:

```bash
sed '/^$/d' file.txt
```

---

## Insert Text

Insert text before a line:

```bash
sed '3i New line added' file.txt
```

Insert after a line:

```bash
sed '3a New line added' file.txt
```

---

## Replace Entire Line

```bash
sed '3c This is the new line' file.txt
```

Replaces line 3 with new content.

---

## Using `sed` With Pipes

`sed` works well with pipelines.

Example:

```bash
cat file.txt | sed 's/foo/bar/g'
```

Better approach:

```bash
sed 's/foo/bar/g' file.txt
```

---

## Using Different Delimiters

Sometimes `/` conflicts with file paths.

You can use other delimiters:

```bash
sed 's|/usr/bin|/usr/local/bin|g' file.txt
```

This avoids escaping `/`.

---

## Common `sed` Options

| Option | Description                    |
| ------ | ------------------------------ |
| `-i`   | Edit file in place             |
| `-n`   | Suppress automatic printing    |
| `-e`   | Execute multiple commands      |
| `-f`   | Read commands from script file |

---

### Multiple Commands

Use `-e` to run multiple commands:

```bash
sed -e 's/foo/bar/' -e 's/hello/world/' file.txt
```

---

## `sed` vs Other Tools

| Tool   | Purpose                    |
| ------ | -------------------------- |
| `grep` | Search text                |
| `sed`  | Modify text streams        |
| `awk`  | Structured text processing |

---

## Interview Questions

### 1. What is `sed`?

**Answer:**
`sed` is a stream editor used to perform text transformations on input streams.

---

### 2. What does the `s` command do in `sed`?

**Answer:**
It performs substitution (search and replace).

---

### 3. How do you replace all occurrences of a word?

**Answer:**

```bash
sed 's/word/newword/g' file.txt
```

---

### 4. What does `-i` do?

**Answer:**
It edits the file directly (in place).

---

### 5. How do you delete blank lines using `sed`?

**Answer:**

```bash
sed '/^$/d' file.txt
```

---

## Summary

* `sed` is a powerful stream editor for text transformation

* Commonly used for search and replace operations

* Works efficiently with files, pipes, and scripts

* Supports line selection, insertion, deletion, and modification

* Widely used in automation, DevOps, and log processing workflows

---
