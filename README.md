# Infra Repo (Terraform + Ansible) - Sample Submission

This repository contains example Terraform and Ansible configuration to provision an AWS VPC + EC2 instance(s), and to deploy Jenkins, Nexus, and SonarQube using Ansible (Docker containers). It also contains an optional Jenkins -> EKS pipeline example.

> **Important:** This is a template. You must provide AWS credentials and adjust variables before running. I did not deploy resources here — follow the step-by-step guide below to run in your own AWS account.

---
## Repo layout
```
terraform/
  ├─ main.tf
  ├─ variables.tf
  ├─ outputs.tf
  └─ eks.tf (optional, commented)
ansible/
  ├─ inventory.ini
  ├─ site.yml
  └─ roles/
      ├─ common/
      ├─ jenkins/
      ├─ nexus/
      └─ sonarqube/
k8s/
  ├─ deployment.yaml
  └─ service.yaml
Jenkinsfile
README.md
```

---
## Quick step-by-step execution guide

1. **Prepare AWS credentials** (environment variables or shared credentials file).
   - `export AWS_PROFILE=yourprofile` or `export AWS_ACCESS_KEY_ID=...` and `export AWS_SECRET_ACCESS_KEY=...`

2. **Terraform (create infra)**:
   ```bash
   cd terraform
   terraform init
   terraform plan -out plan.tf
   terraform apply "plan.tf"
   ```
   - After apply you'll see outputs with EC2 public IP(s) and (optionally) EKS info.
   - Note: `eks.tf` is optional. If you want EKS, uncomment the module and configure values.

3. **Update Ansible inventory**:
   - Copy `ansible/inventory.ini.example` to `ansible/inventory.ini` (or update `ansible/inventory.ini`) and place the public IP(s) from Terraform outputs.

4. **Run Ansible to deploy apps (runs Docker containers)**:
   ```bash
   cd ansible
   ansible-galaxy install -r requirements.yml  # optional if you use galaxy roles
   ansible-playbook -i inventory.ini site.yml --ask-become-pass
   ```
   - This will run `common` role (installs Docker) and per-app roles to run containers for Jenkins, Nexus, SonarQube.

5. **Access dashboards**:
   - Jenkins: `http://<jenkins_ip>:8080`
   - Nexus: `http://<nexus_ip>:8081`
   - SonarQube: `http://<sonarqube_ip>:9000`

6. **kubectl (if you created EKS)**:
   - Update kubeconfig: `aws eks --region <region> update-kubeconfig --name <cluster-name>`
   - Check nodes: `kubectl get nodes`

7. **Bonus — Jenkins pipeline to deploy to EKS**:
   - `Jenkinsfile` provided demonstrates building a sample container image and applying `k8s/` manifests to the cluster (requires Jenkins credentials + kubeconfig/configured `kubectl`).

---
## Screenshots
Place screenshots here (replace placeholders in this README with real images after you deploy):
- `screenshots/jenkins.png` (Jenkins dashboard)
- `screenshots/nexus.png` (Nexus dashboard)
- `screenshots/sonarqube.png` (SonarQube dashboard)
- `screenshots/kubectl_nodes.png` (kubectl get nodes)

---
## Notes & Security
- This template opens ports for demonstration. In production, restrict access and use proper IAM roles, security groups, and SSL.
- Clean up: `terraform destroy` to remove created AWS resources.
