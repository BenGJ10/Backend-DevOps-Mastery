# MySQL Named Volume Workflow in Docker

## Overview

This document walks through a **complete, end-to-end MySQL workflow** using Docker named volumes.  
It covers everything — from creating the volume, running the database container, interacting with MySQL, persisting data, and finally cleaning up safely.

This workflow demonstrates **why named volumes are critical** for any stateful database workload.

---

## The Problem Without Volumes

Running MySQL without a volume:

```bash
docker run -d --name mysql-temp -e MYSQL_ROOT_PASSWORD=secret mysql
```

When you delete this container:

```bash
docker rm -f mysql-temp
```

**All your database data is permanently gone.**

Named volumes solve this.

---

## Step 1 — Create a Named Volume

Before starting MySQL, explicitly create the named volume:

```bash
docker volume create mysql-data
```

This is better than letting Docker auto-create it during `docker run`, because:

- the name is intentional and tracked  
- it can be pre-inspected before attaching  
- it documents the intent in your deployment steps  

---

## Step 2 — Verify the Volume Exists

```bash
docker volume ls
```

Expected output:

```
DRIVER    VOLUME NAME
local     mysql-data
```

Inspect the volume for details:

```bash
docker volume inspect mysql-data
```

Example output:

```json
[
    {
        "CreatedAt": "2026-04-02T07:00:00Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/mysql-data/_data",
        "Name": "mysql-data",
        "Options": {},
        "Scope": "local"
    }
]
```

Key field: `Mountpoint` — this is where Docker physically stores your MySQL data on the host.

---

## Step 3 — Run MySQL with the Named Volume

### Using `-v` Syntax

```bash
docker run -d \
  --name mysql-server \
  -e MYSQL_ROOT_PASSWORD=rootsecret \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=appuser \
  -e MYSQL_PASSWORD=apppassword \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:8
```

### Flag Breakdown

| Flag | Purpose |
|---|---|
| `-d` | Run container in detached/background mode |
| `--name mysql-server` | Assign a readable name to the container |
| `-e MYSQL_ROOT_PASSWORD` | Set root password (required by MySQL image) |
| `-e MYSQL_DATABASE` | Auto-create this database on first startup |
| `-e MYSQL_USER / PASSWORD` | Create a non-root application user |
| `-v mysql-data:/var/lib/mysql` | Mount the named volume to MySQL's data directory |
| `-p 3306:3306` | Expose MySQL port to the host |
| `mysql:8` | Use MySQL version 8 image |

### Why `/var/lib/mysql`?

This is the default data directory for MySQL inside the container.  
All databases, tables, and records are stored here.  
Mounting a volume at this path ensures data persists independently of the container.

---

## Step 4 — Verify the Container is Running

```bash
docker ps
```

Expected output:

```
CONTAINER ID   IMAGE     COMMAND                  STATUS         PORTS                    NAMES
a1b2c3d4e5f6   mysql:8   "docker-entrypoint.s…"  Up 30 seconds  0.0.0.0:3306->3306/tcp   mysql-server
```

Check container logs to confirm MySQL started cleanly:

```bash
docker logs mysql-server
```

Look for:

```
/usr/sbin/mysqld: ready for connections.
```

---

## Step 5 — Connect to the MySQL Shell

Drop into the MySQL container's shell:

```bash
docker exec -it mysql-server bash
```

Then connect with the MySQL client:

```bash
mysql -u root -p
```

Enter: `rootsecret`

Or connect directly in one step:

```bash
docker exec -it mysql-server mysql -u root -prootsecret
```

---

## Step 6 — Interact with MySQL

Once inside the MySQL shell:

### List all databases

```sql
SHOW DATABASES;
```

Expected output includes `app_db` created automatically:

```
+--------------------+
| Database           |
+--------------------+
| app_db             |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

### Switch to the app database

```sql
USE app_db;
```

### Create a table

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Insert test data

```sql
INSERT INTO users (name, email) VALUES 
    ('Alice Johnson', 'alice@example.com'),
    ('Bob Smith', 'bob@example.com'),
    ('Charlie Brown', 'charlie@example.com');
```

### Query the data

```sql
SELECT * FROM users;
```

```
+----+---------------+---------------------+---------------------+
| id | name          | email               | created_at          |
+----+---------------+---------------------+---------------------+
|  1 | Alice Johnson | alice@example.com   | 2026-04-02 07:05:00 |
|  2 | Bob Smith     | bob@example.com     | 2026-04-02 07:05:01 |
|  3 | Charlie Brown | charlie@example.com | 2026-04-02 07:05:02 |
+----+---------------+---------------------+---------------------+
```

Exit the MySQL shell:

```sql
EXIT;
```

---

## Step 7 — Prove Data Persistence

### Delete the container

```bash
docker rm -f mysql-server
```

The container is gone. Now confirm the volume still exists:

```bash
docker volume ls
```

```
DRIVER    VOLUME NAME
local     mysql-data
```

### Restart a new container with the same volume

```bash
docker run -d \
  --name mysql-server-v2 \
  -e MYSQL_ROOT_PASSWORD=rootsecret \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:8
```

### Connect and verify the data survived

```bash
docker exec -it mysql-server-v2 mysql -u root -prootsecret
```

```sql
USE app_db;
SELECT * FROM users;
```

The same three users are returned — **data persisted even after destroying the original container.**

---

## Step 8 — Sharing the Volume with Another Container

Run a second container (e.g., a backup utility) that reads from the same volume:

```bash
docker run -d \
  --name mysql-backup \
  -v mysql-data:/backup-source:ro \
  ubuntu \
  sleep infinity
```

The `:ro` flag makes the mount **read-only** — the backup container can read but not modify MySQL's data.

Inspect inside the backup container:

```bash
docker exec -it mysql-backup ls /backup-source
```

You will see MySQL's raw data directory files.

---

## Step 9 — Back Up the Volume Data

A production-grade backup using `tar`:

```bash
docker run --rm \
  -v mysql-data:/source:ro \
  -v $(pwd):/backup \
  ubuntu \
  tar czf /backup/mysql-backup-$(date +%Y%m%d).tar.gz -C /source .
```

This produces a compressed archive of the MySQL volume data in your current directory.

Verify the backup:

```bash
ls -lh mysql-backup-*.tar.gz
```

---

## Step 10 — Restore the Volume from Backup

To restore data into a fresh volume:

```bash
# Create a new empty volume
docker volume create mysql-data-restored

# Extract the backup into it
docker run --rm \
  -v mysql-data-restored:/target \
  -v $(pwd):/backup \
  ubuntu \
  tar xzf /backup/mysql-backup-20260402.tar.gz -C /target
```

Now run MySQL against the restored volume:

```bash
docker run -d \
  --name mysql-restored \
  -e MYSQL_ROOT_PASSWORD=rootsecret \
  -v mysql-data-restored:/var/lib/mysql \
  -p 3307:3306 \
  mysql:8
```

---

## Step 11 — Clean Up

### Stop and remove containers

```bash
docker stop mysql-server-v2 mysql-backup
docker rm mysql-server-v2 mysql-backup
```

### Remove a specific volume

```bash
docker volume rm mysql-data
```

### Remove all unused volumes at once

```bash
docker volume prune
```

⚠️ This removes all volumes not currently attached to any container. Use with extreme caution in production.

---

## Common Mistakes

### Not Using a Volume for MySQL

```bash
# ❌ Data is lost when container is removed
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=secret mysql
```

```bash
# ✅ Data persists via named volume
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=secret -v mysql-data:/var/lib/mysql mysql
```

---

### Pruning Volumes Without Verifying Attachments

Always check which containers are using a volume before pruning:

```bash
docker ps -a --filter volume=mysql-data
```

---

### Running Two MySQL Containers on the Same Volume Simultaneously

Two MySQL instances simultaneously writing to the same volume **will corrupt the database**.  
Always stop the first container before starting a second one on the same volume.

---

### Forgetting to Expose the Port

Without `-p 3306:3306`, MySQL is inaccessible from outside Docker.  
Tools like MySQLWorkbench or your application will fail to connect.

---

## Summary

* Always create a named volume before running MySQL

* Mount the volume to `/var/lib/mysql` — MySQL's data directory

* Data persists even after the container is removed

* Use `docker volume inspect` to audit where data is physically stored

* Back up volumes with `tar` before performing any destructive operations

* Use `--mount` syntax in scripts and production environments

* Never run two MySQL instances simultaneously on the same volume

* Use `docker volume prune` cautiously — it permanently deletes data

---
