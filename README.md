# DevPulse – DevOps CI/CD Pipeline

This repository contains the complete DevOps setup for the DevPulse application.
It manages infrastructure provisioning, configuration management, and CI/CD
for separate backend and frontend repositories.

The system is designed to automatically deploy backend and frontend services
whenever code is pushed to their respective repositories.

---

## Repositories Overview

1. devpulse-devops  
   Central DevOps repository (this repo)
   - Terraform: infrastructure provisioning
   - Ansible: backend and frontend deployment
   - Jenkinsfile: CI/CD pipeline orchestration

2. devpulse-backend  
   Backend application source code
   - Node.js backend
   - Deployed using PM2
   - No DevOps logic inside this repo

3. devpulse-frontend  
   Frontend application source code
   - React (Vite)
   - Built as static files
   - Served using Nginx

---

## Architecture Overview

High-level flow:

GitHub (backend / frontend)
        ↓
GitHub Webhooks
        ↓
Jenkins (devpulse-devops pipeline)
        ↓
Ansible Playbooks
        ↓
EC2 Instance
   - Backend (PM2)
   - Frontend (Nginx)

Infrastructure is provisioned using Terraform, while all deployments are handled
by Ansible executed through Jenkins.

---

## CI/CD Flow

1. Code is pushed to devpulse-backend or devpulse-frontend
2. GitHub webhook triggers Jenkins pipeline
3. Jenkins identifies which repository triggered the build
4. Jenkins runs the corresponding Ansible playbook:
   - backend.yml for backend changes
   - frontend.yml for frontend changes
5. Application is deployed automatically on the EC2 instance

No manual intervention is required.

---

## Infrastructure (Terraform)

Terraform is used to:
- Provision EC2 instances
- Configure security groups
- Manage SSH key pairs

All infrastructure code is located inside the terraform directory.

---

## Configuration Management (Ansible)

Ansible is used for:
- Installing system dependencies
- Deploying backend and frontend code
- Managing PM2 for backend
- Configuring and restarting Nginx for frontend

Playbooks are located inside:

Key playbooks:
- backend.yml
- frontend.yml

---

## Secrets Management

Secrets are NOT stored in GitHub.

All sensitive values such as:
- Database connection string
- JWT secrets
- API keys

are stored securely in Jenkins Credentials and injected at runtime during deployment.

---

## Jenkins Pipeline

- A single Jenkins pipeline is used
- Jenkinsfile is stored in devpulse-devops
- Pipeline is triggered by GitHub webhooks
- Uses Generic Webhook Trigger plugin
- Selectively deploys backend or frontend based on trigger source

---

## Deployment Result

- Backend runs on PM2
- Frontend is served as static files via Nginx
- Fully automated CI/CD
- Production-style setup suitable for real-world applications

---

## Why This Project

This project demonstrates:
- Real-world CI/CD design
- Multi-repository orchestration
- Infrastructure as Code
- Secure secrets handling
- End-to-end automation

It is built to reflect how DevOps is done in professional environments.
