# File Display Commands in Linux

## Overview

File display commands are used to **view and inspect file contents** directly from the terminal.

They are essential for:

* reading configuration files
* debugging logs
* inspecting code on remote servers
* quick file validation
* backend troubleshooting

Linux provides multiple display tools optimized for different scenarios.

---

## 1️⃣ `cat` — Concatenate and Display File

### Purpose

Displays entire file content at once.

### Syntax

```bash
cat filename
```

### Example

```bash
cat file.txt
```

### Common Options

```bash
cat -n file.txt   # show line numbers
cat -b file.txt   # number non-empty lines
```

---

### Use Case

* Small config files
* Quick output
* Combining files

```bash
cat file1.txt file2.txt > combined.txt
```

⚠️ Not ideal for large files.

---

## 2️⃣ `less` — View Large Files Efficiently

### Purpose

View large files page by page.

```bash
less large.log
```

### Navigation

| Key   | Action        |
| ----- | ------------- |
| Space | Next page     |
| b     | Previous page |
| /word | Search        |
| n     | Next match    |
| q     | Quit          |

---

### Why `less` Is Powerful

* Does not load entire file into memory
* Ideal for large logs
* Interactive navigation

Common in production:

```bash
less /var/log/syslog
```

---

## 3️⃣ `more` — Basic Pager

Older version of `less`.

```bash
more file.txt
```

Limitations:

* Only forward navigation
* Less interactive

Mostly replaced by `less`.

---

## 4️⃣ `head` — Display Beginning of File

Shows first 10 lines by default.

```bash
head file.txt
```

Show specific number of lines:

```bash
head -n 20 file.txt
```

---

### Real Use Case

Preview large files:

```bash
head -n 50 app.log
```

---

## 5️⃣ `tail` — Display End of File

Shows last 10 lines by default.

```bash
tail file.txt
```

Show specific number:

```bash
tail -n 30 file.txt
```

---

### Live Monitoring (`-f`)

```bash
tail -f app.log
```

Used to monitor:

* server logs
* real-time application output
* background processes

Press `Ctrl + C` to exit.

---

## 6️⃣ `nl` — Number Lines

```bash
nl file.txt
```

Displays file with line numbers.

---

## 7️⃣ `tac` — Reverse Display

Opposite of `cat`.

```bash
tac file.txt
```

Displays lines from bottom to top.

---

## 8️⃣ `watch` — Periodic Display

Runs a command repeatedly.

```bash
watch -n 2 ls
```

Refreshes every 2 seconds.

Useful for monitoring file changes.

---

## When to Use What?

| Command | Best For              |
| ------- | --------------------- |
| cat     | Small files           |
| less    | Large files           |
| more    | Simple forward paging |
| head    | Beginning of file     |
| tail    | End of file           |
| tail -f | Live log monitoring   |
| nl      | Numbered output       |
| tac     | Reverse viewing       |

---

## Real Production Debugging Example

Application crash investigation:

```bash
tail -n 50 /var/log/app.log
```

If error found:

```bash
grep "ERROR" /var/log/app.log | less
```

Live monitor:

```bash
tail -f /var/log/app.log
```

These commands are essential for backend engineers.

---

## Performance Tip

For very large files:

Avoid:

```bash
cat hugefile.log
```

Use:

```bash
less hugefile.log
```

Because `cat` loads everything at once.

---

## Interview Questions

### 1. Difference between `more` and `less`?

**Answer:**
`less` allows backward navigation and search; `more` is limited.

---

### 2. What does `tail -f` do?

**Answer:**
It monitors file updates in real time.

---

### 3. How do you view only the first 20 lines?

**Answer:**
`head -n 20 file.txt`

---

### 4. Which command is best for large log files?

**Answer:**
`less` or `tail -f`

---

### 5. What does `tac` do?

**Answer:**
Displays file content in reverse order.

---

## Summary

* `cat` displays entire file

* `less` is best for large files

* `head` shows beginning

* `tail` shows end

* `tail -f` monitors live logs

* `nl` numbers lines

* `tac` reverses output

File display commands are fundamental for log analysis and server debugging.

---
