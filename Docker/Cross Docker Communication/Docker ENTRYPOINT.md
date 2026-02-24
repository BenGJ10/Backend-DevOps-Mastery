# Docker ENTRYPOINT

## Overview

`ENTRYPOINT` defines the **main executable that will always run when a container starts**.

It configures a container to behave like a specific application, ensuring that the container always executes the intended process regardless of runtime arguments.

Understanding `ENTRYPOINT` is important for building production-ready Docker images with predictable behavior.

---

## ENTRYPOINT vs CMD

Both `ENTRYPOINT` and `CMD` define what runs when a container starts, but they behave differently.

- **ENTRYPOINT** → Defines the fixed executable
- **CMD** → Provides default arguments

They are often used together.

---

## Basic ENTRYPOINT Syntax

There are two forms:

### 1️⃣ Exec Form (Recommended)

```dockerfile
ENTRYPOINT ["node", "server.js"]
````

This form:

* does not invoke a shell
* handles signals properly
* is safer and preferred

---

### 2️⃣ Shell Form

```dockerfile
ENTRYPOINT node server.js
```

This runs through `/bin/sh -c`.

Less predictable signal handling.

Avoid in production.

---

## How ENTRYPOINT Works

If your Dockerfile contains:

```dockerfile
ENTRYPOINT ["node", "server.js"]
```

Running:

```bash
docker run my-app
```

Always executes:

```
node server.js
```

Even if arguments are passed.

---

## Using ENTRYPOINT with CMD

Common pattern:

```dockerfile
ENTRYPOINT ["python"]
CMD ["app.py"]
```

Now:

```bash
docker run my-app
```

Runs:

```
python app.py
```

But if you pass arguments:

```bash
docker run my-app script.py
```

It becomes:

```
python script.py
```

CMD values are overridden; ENTRYPOINT remains fixed.

---

## Overriding ENTRYPOINT

You can override ENTRYPOINT at runtime:

```bash
docker run --entrypoint /bin/bash my-app
```

Useful for debugging.

---

## When to Use ENTRYPOINT

Use ENTRYPOINT when:

* container should always run a specific program
* building CLI tools
* enforcing container behavior
* preventing accidental override

Example: Database containers, CLI utilities.

---

## Example: Building a CLI Tool Container

Dockerfile:

```dockerfile
FROM python:3.11
COPY script.py .
ENTRYPOINT ["python", "script.py"]
```

Now container behaves like a command-line tool:

```bash
docker run my-script arg1 arg2
```

Executes:

```
python script.py arg1 arg2
```

---

## ENTRYPOINT vs CMD — Summary Table

| Feature                    | ENTRYPOINT               | CMD                |
| -------------------------- | ------------------------ | ------------------ |
| Defines main executable    | Yes                      | No                 |
| Provides default arguments | No                       | Yes                |
| Can be overridden          | Harder                   | Easier             |
| Best use case              | Fixed container behavior | Default parameters |

---

## Best Practice Pattern

For backend applications:

```dockerfile
ENTRYPOINT ["java", "-jar"]
CMD ["app.jar"]
```

This ensures:

* Java runtime is fixed
* Jar file can be replaced if needed

---

## Signal Handling Importance

Using exec form:

```dockerfile
ENTRYPOINT ["node", "server.js"]
```

Ensures proper handling of:

* SIGTERM
* SIGINT

Important for graceful shutdown in production systems.

---

## Common Mistakes

### Using Shell Form in Production

Leads to poor signal propagation.

---

### Replacing ENTRYPOINT Instead of CMD

Makes container less flexible.

---

### Forgetting Exec Form JSON Syntax

Missing brackets can break behavior.

---

## Interview Questions

### 1. What is Docker ENTRYPOINT?

**Answer:**
ENTRYPOINT defines the main executable that runs when a container starts.

---

### 2. What is the recommended form of ENTRYPOINT?

**Answer:**
The exec (JSON array) form.

---

### 3. How does ENTRYPOINT differ from CMD?

**Answer:**
ENTRYPOINT sets the fixed executable, while CMD provides default arguments.

---

### 4. Can ENTRYPOINT be overridden?

**Answer:**
Yes, using the `--entrypoint` flag at runtime.

---

### 5. Why is exec form preferred?

**Answer:**
Because it handles signals properly and avoids shell interpretation issues.

---

## Summary

* ENTRYPOINT defines the primary container process

* Exec form is recommended

* Often combined with CMD for flexibility

* Important for predictable container behavior

* Essential for production-ready Docker images

---