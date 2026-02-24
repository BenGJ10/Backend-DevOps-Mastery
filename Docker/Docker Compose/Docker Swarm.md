# Docker Swarm Overview

## Overview

**Docker Swarm** is Docker’s native container orchestration platform that allows you to manage a cluster of Docker nodes as a single virtual system.

It enables:

- container replication  
- load balancing  
- service discovery  
- fault tolerance  
- rolling updates  

Swarm extends Docker from running containers on one machine to managing distributed systems across multiple machines.

---

## Why Docker Swarm Exists

Running containers on a single host works for small systems, but production systems require:

- high availability  
- horizontal scaling  
- distributed deployments  
- automatic recovery  
- cluster-wide networking  

Docker Swarm addresses these needs by orchestrating containers across multiple nodes.

---

## What Is a Swarm?

A **Swarm** is a cluster of Docker nodes that work together.

Each node runs Docker Engine and participates in the cluster.

Swarm makes multiple machines behave like a single logical Docker system.

---

## Node Types in Docker Swarm

### 1️⃣ Manager Node

Manager nodes:

- control the cluster  
- schedule services  
- maintain cluster state  
- handle orchestration decisions  

They use a consensus algorithm to maintain reliability.

---

### 2️⃣ Worker Node

Worker nodes:

- execute containers  
- receive instructions from managers  
- do not manage cluster state  

Workers focus only on running workloads.

---

## Core Swarm Concepts

### 1️⃣ Service

A **service** defines:

- container image  
- number of replicas  
- network configuration  
- update policy  

Example:

```
Run 5 replicas of nginx
```

Swarm ensures 5 containers are always running.

---

### 2️⃣ Task

A task represents a single running container created by a service.

If a task fails, Swarm automatically replaces it.

---

### 3️⃣ Overlay Network

Swarm creates **overlay networks** that allow containers across multiple hosts to communicate securely.

This enables distributed microservices.

---

## Initializing a Swarm

On a manager node:

```bash
docker swarm init
````

This creates the cluster.

Worker nodes join using:

```bash
docker swarm join --token <token> <manager-ip>:2377
```

---

## Deploying a Service

Example:

```bash
docker service create --replicas 3 -p 80:80 nginx
```

Swarm:

* distributes containers across nodes
* balances traffic
* restarts failed containers

---

## Scaling a Service

```bash
docker service scale nginx=5
```

Swarm automatically adds or removes replicas.

---

## Rolling Updates

Swarm supports controlled updates:

```bash
docker service update --image nginx:latest nginx
```

Containers are updated gradually without downtime.

---

## High Availability

If a node fails:

* Swarm reschedules containers on healthy nodes
* cluster continues functioning

Managers replicate state for fault tolerance.

---

## Docker Swarm vs Docker Compose

| Feature             | Docker Compose | Docker Swarm |
| ------------------- | -------------- | ------------ |
| Multi-container app | Yes            | Yes          |
| Single host         | Yes            | No           |
| Multi-host cluster  | No             | Yes          |
| Load balancing      | No             | Yes          |
| Auto-scaling        | No             | Yes          |

Compose is for development; Swarm is for clustered environments.

---

## Docker Swarm vs Kubernetes

| Feature             | Docker Swarm | Kubernetes   |
| ------------------- | ------------ | ------------ |
| Complexity          | Simpler      | More complex |
| Learning curve      | Lower        | Higher       |
| Ecosystem           | Smaller      | Larger       |
| Enterprise adoption | Moderate     | Very high    |

Swarm is easier to start with but Kubernetes dominates large-scale production.

---

## Limitations of Docker Swarm

* smaller ecosystem
* fewer advanced scheduling features
* less enterprise adoption compared to Kubernetes
* slower innovation

Still useful for simpler clustered deployments.

---

## Interview Questions

### 1. What is Docker Swarm?

**Answer:**
Docker Swarm is Docker’s native clustering and orchestration tool for managing containers across multiple nodes.

---

### 2. What are the two types of nodes in Swarm?

**Answer:**
Manager nodes and worker nodes.

---

### 3. What is a service in Docker Swarm?

**Answer:**
A service defines the desired state and replication of containers in the cluster.

---

### 4. What happens if a container fails in Swarm?

**Answer:**
Swarm automatically replaces it to maintain the desired state.

---

### 5. How does Swarm enable multi-host communication?

**Answer:**
Using overlay networks.

---

## Summary

* Docker Swarm manages container clusters

* Supports scaling, self-healing, and rolling updates

* Uses manager and worker nodes

* Services define desired container state

* Simpler than Kubernetes but less widely adopted

---