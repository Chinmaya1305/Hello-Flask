# Hello DevOps Microservice

A minimal Python Flask microservice used to demonstrate a full local DevOps flow:
GitHub → Jenkins CI → Docker image → local Docker registry → Kubernetes (kind) deployment.
Provisioning automation provided via Ansible.

Ports used (uncommon):
- Local Docker registry: `localhost:10090` (maps to registry:5000)
- Jenkins UI: `http://localhost:9111`
- App NodePort: `http://localhost:31555`
- Container port (Flask): `5000`

## Quick local run (manual)
1. Build & push to local registry:
```bash
docker run -d --restart=always --name registry-local -p 10090:5000 registry:2
docker build -t localhost:10090/hello-flask:latest .
docker push localhost:10090/hello-flask:latest

# Hello-Flask
