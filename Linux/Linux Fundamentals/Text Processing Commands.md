# Text Processing Commands in Linux

## Overview

Linux provides powerful **text processing utilities** that allow you to:

* search logs
* filter data
* transform text
* extract columns
* automate reporting
* process large files efficiently

These tools are heavily used in:

* backend debugging
* DevOps workflows
* data engineering
* log analysis
* shell scripting

The Unix philosophy:

> Build small tools that do one thing well — combine them.

![Text Processing Commands](https://assets.bytebytego.com/diagrams/0263-log-parsing.png)

---

## 1️⃣ `grep` — Search Inside Files

### Purpose

Search for patterns in text.

```bash
grep "ERROR" app.log
```

---

### Common Options

```bash
grep -i "error" file.txt    # case-insensitive
grep -n "error" file.txt    # show line numbers
grep -r "TODO" .            # recursive search
grep -v "DEBUG" file.txt    # invert match
```

---

### Real Example

```bash
grep "500" access.log
```

Find all HTTP 500 errors.

---

## 2️⃣ `sed` — Stream Editor

### Purpose

Search and replace text in streams.

```bash
sed 's/old/new/' file.txt
```

---

### Replace Globally

```bash
sed 's/error/ERROR/g' file.txt
```

---

### Edit File In-Place

```bash
sed -i 's/localhost/127.0.0.1/g' config.txt
```

---

### Use Case

Bulk update config values.

---

## 3️⃣ `awk` — Pattern Scanning & Processing

`awk` is a mini programming language for text processing.

### Print Specific Column

```bash
awk '{print $1}' file.txt
```

---

### Example with Logs

```bash
awk '{print $9}' access.log
```

Extract HTTP status codes.

---

### Conditional Example

```bash
awk '$9 == 500 {print $0}' access.log
```

Print only 500 errors.

---

## 4️⃣ `cut` — Extract Columns

Extract specific fields.

```bash
cut -d ":" -f 1 /etc/passwd
```

* `-d` → delimiter
* `-f` → field number

---

### Example

```bash
cut -d "," -f 2 data.csv
```

Extract second column.

---

## 5️⃣ `sort` — Sort Lines

```bash
sort file.txt
```

---

### Numeric Sort

```bash
sort -n numbers.txt
```

---

### Reverse Sort

```bash
sort -r file.txt
```

---

## 6️⃣ `uniq` — Remove Duplicate Lines

Works best with sorted input.

```bash
sort file.txt | uniq
```

---

### Count Duplicates

```bash
sort file.txt | uniq -c
```

---

## 7️⃣ `wc` — Word Count

```bash
wc file.txt
```

Output:

```
lines words bytes
```

---

## Count Lines Only

```bash
wc -l file.txt
```

---

## 8️⃣ `tr` — Translate or Delete Characters

Convert lowercase to uppercase:

```bash
tr 'a-z' 'A-Z' < file.txt
```

Delete characters:

```bash
tr -d ',' < file.txt
```

---

## 9️⃣ `paste` — Merge Files Line by Line

```bash
paste file1.txt file2.txt
```

---

## 🔟 `diff` — Compare Files

```bash
diff file1.txt file2.txt
```

Used in:

* version control
* configuration comparison
* debugging

---

## Powerful Combined Example

Find most frequent IP address in access log:

```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -n 1
```

Pipeline Explanation:

1. Extract IP column
2. Sort
3. Count duplicates
4. Sort numerically (descending)
5. Show top result

This is real-world DevOps usage.

---

## Tool Comparison

| Command | Best For                 |
| ------- | ------------------------ |
| grep    | Pattern search           |
| sed     | Replace/modify text      |
| awk     | Structured processing    |
| cut     | Column extraction        |
| sort    | Sorting lines            |
| uniq    | Removing duplicates      |
| wc      | Counting                 |
| tr      | Character transformation |
| diff    | File comparison          |

---

## Interview Questions

### 1. Difference between `grep` and `awk`?

**Answer:**
`grep` searches patterns; `awk` processes structured text and fields.

---

### 2. Why is `uniq` usually used with `sort`?

**Answer:**
Because `uniq` only removes adjacent duplicates.

---

### 3. How do you replace text in a file?

**Answer:**
Using `sed`.

---

### 4. How do you extract a specific column?

**Answer:**
Using `cut` or `awk`.

---

### 5. How do you count lines in a file?

**Answer:**
`wc -l file.txt`

---

## Summary

* Linux provides powerful text-processing utilities

* `grep` searches text

* `sed` edits streams

* `awk` processes structured data

* `cut`, `sort`, `uniq`, `wc`, `tr` handle filtering & transformations

* Combining tools with pipes creates powerful workflows

---
