# User Account Management in Linux

## Overview

Linux is a **multiuser operating system**, meaning multiple users can access and use the same system simultaneously.

User account management is responsible for:

* creating and managing user accounts
* assigning permissions
* controlling system access
* securing resources

Proper user management is critical for **system security, administration, and resource control**.

---

## What Is a User Account?

A **user account** represents an identity used to log into a Linux system.

Each account has:

* a **username**
* a **User ID (UID)**
* a **home directory**
* a **login shell**
* associated **group memberships**

Example user:

```
ben
```

Home directory:

```
/home/ben
```

---

## 1️⃣ Root User

The **root user** is the system administrator.

Characteristics:

* UID = 0
* unrestricted system access
* can modify any file or process

Example:

```bash
sudo su
```

Root should be used carefully because it has full system privileges.

---

## 2️⃣ System Users

System users are created for services and background processes.

Examples:

```
mysql
www-data
nobody
```

Characteristics:

* usually no login shell
* used by system services
* have low privileges

---

## 3️⃣ Regular Users

Regular users represent human users of the system.

Example:

```
ben
developer
admin
```

These users have limited permissions.

---

## Important Files for User Management

Linux stores user information in several configuration files.

| File          | Purpose                         |
| ------------- | ------------------------------- |
| `/etc/passwd` | Stores user account information |
| `/etc/shadow` | Stores encrypted passwords      |
| `/etc/group`  | Stores group information        |

---

## `/etc/passwd` File

This file stores basic user account details.

Example entry:

```
ben:x:1001:1001:Ben:/home/ben:/bin/bash
```

Fields:

```
username : password_placeholder : UID : GID : description : home_directory : shell
```

Passwords are not stored here for security reasons.

---

## `/etc/shadow` File

This file stores **encrypted user passwords**.

Example:

```
ben:$6$gdfgdfgdfg...:19420:0:99999:7:::
```

It also includes password expiration information.

Only root can read this file.

---

## `/etc/group` File

Stores group membership information.

Example entry:

```
developers:x:1002:ben,alice
```

Fields:

```
group_name : password_placeholder : GID : members
```

---

## Creating User Accounts

Use the `useradd` command.

```bash
sudo useradd username
```

Example:

```bash
sudo useradd ben
```

---

### Create User with Home Directory

```bash
sudo useradd -m ben
```

Home directory created:

```
/home/ben
```

---

### Set Password

```bash
sudo passwd ben
```

You will be prompted to enter a password.

---

### Deleting Users

Remove a user:

```bash
sudo userdel username
```

Example:

```bash
sudo userdel ben
```

---

### Remove User with Home Directory

```bash
sudo userdel -r ben
```

---

## Modifying User Accounts

Use the `usermod` command.

---

### Change Username

```bash
sudo usermod -l newname oldname
```

---

### Change Home Directory

```bash
sudo usermod -d /new/home username
```

---

### Add User to Group

```bash
sudo usermod -aG groupname username
```

Example:

```bash
sudo usermod -aG sudo ben
```

---

## Checking User Information

Display user ID and groups:

```bash
id username
```

Example:

```bash
id ben
```

Output:

```
uid=1001(ben) gid=1001(ben) groups=1001(ben),27(sudo)
```

---

## Locking and Unlocking Accounts

Lock user account:

```bash
sudo passwd -l username
```

Unlock account:

```bash
sudo passwd -u username
```

This prevents login without deleting the account.

---

## User Environment Files

When a user logs in, the system loads configuration files.

Common files:

| File           | Purpose               |
| -------------- | --------------------- |
| `~/.bashrc`    | Shell configuration   |
| `~/.profile`   | Login environment     |
| `/etc/profile` | Global login settings |

These files define environment variables and shell behavior.

---

## Best Practices

* avoid daily work as root
* use strong passwords
* assign least privileges
* remove unused accounts
* monitor login activity

These practices improve system security.

---

## Interview Questions

### 1. What file stores user account information?

**Answer:**
`/etc/passwd`.

---

### 2. Where are encrypted passwords stored?

**Answer:**
`/etc/shadow`.

---

### 3. What command creates a new user?

**Answer:**

```bash
useradd
```

---

### 4. What is UID 0?

**Answer:**
It represents the root user.

---

### 5. How do you add a user to a group?

**Answer:**

```bash
usermod -aG group username
```

---

## Summary

* Linux supports multiple users with separate permissions

* User data is stored in `/etc/passwd`, `/etc/shadow`, and `/etc/group`

* `useradd`, `userdel`, and `usermod` manage accounts

* Root user has full system privileges

* Proper user management improves system security and administration

---
