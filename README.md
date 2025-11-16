# Infra Repo (Terraform + Ansible) - Sample Submission

This repository contains example Terraform and Ansible configuration to provision an AWS VPC + EC2 instance(s), and to deploy Jenkins, Nexus, and SonarQube using Ansible (Docker containers). It also contains an optional Jenkins -> EKS pipeline example.

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
## This repository provides a fully automated Infrastructure-as-Code (IaC) setup to deploy a complete DevSecOps CI/CD environment using:

.  Terraform – Infrastructure provisioning

.  Ansible – Configuration management & tool installation

.  AWS – VPC, EC2, EKS

.  Docker – Nexus & SonarQube containers

.  Kubernetes (EKS) – for application deployment

### This project deploys and configures the following DevSecOps tools:

.  Jenkins (Port 8080)

.  Nexus Repository Manager (Port 8081)

.  SonarQube (Port 9000)



## Quick step-by-step execution guide

**Prepare AWS credentials** (environment variables or shared credentials file).
   - `export AWS_PROFILE=yourprofile` or `export AWS_ACCESS_KEY_ID=...` and `export AWS_SECRET_ACCESS_KEY=...`

  # 💻 Install AWS CLI on Windows


  ```
   # 📦 Step 1: Download the latest AWS CLI v2 Installer (64-bit)
     Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
 
   # 🧩 Step 2: Run the installer
     Start-Process msiexec.exe -Wait -ArgumentList '/i AWSCLIV2.msi /qn'

   # 🧹 Step 3: Clean up the installer
       Remove-Item "AWSCLIV2.msi"

   # ✅ Step 4: Verify installation
       aws --version
  ```

   Once aws is installed provide your credentials to authenticate by using :
   ```
   aws configure

   ```



# Install and configure Infrastructure Provisioning (Terraform)

 1. **Install Terraform on Windows**:
    * Download Terraform ZIP: https://developer.hashicorp.com/terraform/downloads
    
  * Extract terraform.exe.
  
 * Move it to: C:\terraform\


* Add folder to PATH:

  Control Panel → System → Advanced System Settings
  Environment Variables
  Edit PATH → Add:


  **Verify installation**
   ```
  terraform -version
   ```

2. **Terraform (create infra)**:
   * Create and enter the project directory
   ```
   ### 💻 Windows PowerShell
   touch main.tf vpc.tf variables.tf outputs.tf
   ```

  * Add the basic configuration in the files (you can find the files in the terraform folder)
  * Initialize and deploy terraform

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
