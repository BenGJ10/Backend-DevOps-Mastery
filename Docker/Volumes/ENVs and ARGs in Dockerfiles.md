# Docker Arguments and Environment Variables

## Overview

Docker provides two important mechanisms for passing configuration into containers:

- **Build Arguments (`ARG`)** — used during image build time  
- **Environment Variables (`ENV`)** — available at container runtime  

Understanding the difference is critical for building flexible images, managing configuration safely, and supporting multiple deployment environments.

---

## Why Configuration Matters in Containers

Hardcoding configuration inside images leads to:

- inflexible deployments  
- environment-specific rebuilds  
- security risks  
- poor scalability  

Instead, configuration should be externalized using arguments and environment variables.

---

## Build Arguments (`ARG`)

### What Is a Build Argument?

A **build argument** is a variable passed during the **image build process** that can influence how the image is created.

Important characteristic:

👉 Available only during build — **not accessible once the container runs**.

---

### Defining an ARG in Dockerfile

```dockerfile
ARG APP_VERSION
RUN echo "Building version $APP_VERSION"
```

---

### Passing a Build Argument

```bash
docker build --build-arg APP_VERSION=1.2.0 -t backend-app .
```

---

### Common Use Cases

* selecting base image versions
* injecting build metadata
* conditional dependency installation
* version labeling

---

### Key Limitation

`ARG` values are **not persisted** inside the container unless explicitly copied into `ENV`.

---

## Environment Variables (`ENV`)

### What Is an Environment Variable?

An environment variable is a key-value pair available to the container **while it is running**.

Applications can read these values dynamically.

---

### Setting ENV in Dockerfile

```dockerfile
ENV APP_ENV=production
```

Now every container created from this image has:

```
APP_ENV=production
```

---

### Passing Environment Variables at Runtime

```bash
docker run -e APP_ENV=staging backend-app
```

Overrides the default value.

---

### Using an Environment File

Create `.env`:

```
DB_HOST=localhost
DB_PORT=5432
```

Run container:

```bash
docker run --env-file .env backend-app
```

Useful for large configurations.

---

## ARG vs ENV — Core Differences

| Feature                | ARG                 | ENV               |
| ---------------------- | ------------------- | ----------------- |
| Available during build | Yes                 | Yes               |
| Available at runtime   | No                  | Yes               |
| Stored in final image  | No                  | Yes               |
| Override at runtime    | No                  | Yes               |
| Typical purpose        | Build customization | App configuration |

---

## Combining ARG and ENV

A common pattern is promoting a build argument into an environment variable.

```dockerfile
ARG APP_ENV=production
ENV APP_ENV=$APP_ENV
```

Now:

* configurable during build
* accessible at runtime

---

## Security Warning

### Never Store Secrets in ARG or ENV

Both can be inspected using Docker tools.

Avoid placing:

* API keys
* passwords
* tokens
* private certificates

Use secret managers instead.

---

## Best Practices

### Prefer ENV for Runtime Configuration

Keeps images reusable across environments.

---

### Avoid Hardcoding Values

Supports staging, testing, and production deployments.

---

### Use `.env` Files Carefully

Do not commit sensitive data to version control.

---

### Keep Images Environment-Agnostic

Promote portability across infrastructure.

---

## Common Mistakes

### Confusing ARG with ENV

Leads to missing configuration at runtime.

---

### Rebuilding Images for Small Config Changes

Use environment variables instead.

---

### Exposing Secrets

Always use secure secret management.

---

## Interview Questions

### 1. What is a Docker build argument?

**Answer:**
A build argument is a variable used during image build time but not available at runtime.

---

### 2. What is an environment variable in Docker?

**Answer:**
A runtime key-value configuration accessible to the containerized application.

---

### 3. What is the main difference between ARG and ENV?

**Answer:**
ARG is build-time only, while ENV persists and is available at runtime.

---

### 4. How do you pass an environment variable when starting a container?

**Answer:**
Using `docker run -e KEY=value`.

---

### 5. Should secrets be stored in ARG or ENV?

**Answer:**
No, secrets should be managed using secure secret tools.

---

## Summary

* `ARG` customizes the image during build

* `ENV` configures the container at runtime

* ENV values persist; ARG values do not

* Externalized configuration improves flexibility

* Never store secrets in Dockerfiles

---