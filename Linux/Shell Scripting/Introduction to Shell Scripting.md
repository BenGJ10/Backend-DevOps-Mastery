# Introduction to Shell Scripting

## Overview

**Shell scripting** is the process of writing a series of commands in a file that can be executed by a shell.

Instead of running commands manually in the terminal, shell scripts allow you to:

* automate repetitive tasks
* manage servers
* deploy applications
* process logs
* perform system maintenance

Shell scripting is widely used in **DevOps, backend infrastructure, and system administration**.

---

## What Is a Shell Script?

A **shell script** is a text file containing commands that are executed sequentially by a shell interpreter.

Example script:

```bash
#!/bin/bash
echo "Hello, Linux!"
date
whoami
```

When executed, the shell reads the file and runs each command.

---

## The Shebang (`#!`)

The first line of a shell script usually contains a **shebang**.

Example:

```bash
#!/bin/bash
```

This tells the system which interpreter should execute the script.

Common interpreters:

* `/bin/bash`
* `/bin/sh`
* `/bin/zsh`

---

## Creating a Shell Script

### Step 1: Create Script File

```bash
touch script.sh
```

---

### Step 2: Add Script Content

Open the file with a text editor:

```bash
vi script.sh
```

Example script:

```bash
#!/bin/bash
echo "Starting script..."
date
echo "Script finished."
```

---

### Step 3: Make Script Executable

```bash
chmod +x script.sh
```

---

### Step 4: Run the Script

```bash
./script.sh
```

Output:

```
Starting script...
Mon Mar 4 10:20:00 UTC
Script finished.
```

---

## Why Shell Scripting Is Powerful

Shell scripts enable automation such as:

* server provisioning
* log monitoring
* scheduled backups
* deployment pipelines
* batch file processing

Example automation:

```bash
#!/bin/bash

echo "Checking disk usage"
df -h

echo "Checking running processes"
ps aux
```

---

## Common Uses of Shell Scripts

### System Administration

Automate tasks like:

* backups
* service restarts
* user management

---

### DevOps Automation

Used in:

* CI/CD pipelines
* Docker containers
* deployment scripts

---

### Log Processing

Example:

```bash
grep "ERROR" app.log
```

Scripts can automate repeated log analysis.

---

## Variables in Shell Scripts

Variables store values.

Example:

```bash
#!/bin/bash

name="Ben"
echo "Hello $name"
```

Output:

```
Hello Ben
```

---

## Command Substitution

Capture command output.

```bash
today=$(date)
echo "Today is $today"
```

---

## Basic Script Example

```bash
#!/bin/bash

echo "System Information"
echo "-------------------"

echo "User:"
whoami

echo "Hostname:"
hostname

echo "Current Date:"
date
```

---

## Script Execution Methods

### Direct Execution

```bash
./script.sh
```

---

### Using Shell Interpreter

```bash
bash script.sh
```

---

## Shell Script Workflow

Typical process:

```
Write script
↓
Make executable
↓
Execute script
↓
Automate tasks
```

---

## Advantages vs Disadvantages 

| Advantages                            | Disadvantages                         |
| ------------------------------------- | ------------------------------------- |
| Automates repetitive tasks            | Can be error-prone if not tested      |
| Widely supported across Linux systems | Performance can be slower than compiled languages |
| Easy to learn and use                 | Not ideal for complex applications     |
| Integrates well with Linux utilities   | Limited debugging tools               |

---

## Real Production Example

Automated log cleanup script:

```bash
#!/bin/bash

LOG_DIR="/var/log/myapp"

echo "Cleaning old logs..."

find $LOG_DIR -name "*.log" -mtime +7 -delete

echo "Cleanup completed."
```

This script removes logs older than 7 days.

---

## Interview Questions

### 1. What is shell scripting?

**Answer:**
Shell scripting is writing commands in a file that are executed by a shell interpreter.

---

### 2. What is the purpose of the shebang?

**Answer:**
It specifies which interpreter should run the script.

---

### 3. How do you make a script executable?

**Answer:**

```bash
chmod +x script.sh
```

---

### 4. How do you run a shell script?

**Answer:**

```bash
./script.sh
```

---

### 5. Why are shell scripts useful?

**Answer:**
They automate repetitive tasks and simplify system administration.

---

## Summary

* Shell scripting automates Linux commands

* Scripts are executed by shell interpreters like Bash

* The shebang specifies the interpreter

* Scripts must be executable to run directly

* Commonly used in DevOps, automation, and server management

* Shell scripts simplify complex workflows by combining commands into reusable programs

---