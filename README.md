# Terraform AWS Infrastructure Project

## Project Architecture

![Terraform AWS Project](project_img.png)

---

# Project Overview

This project demonstrates production-style AWS infrastructure provisioning using Terraform.  
The infrastructure is fully automated using Infrastructure as Code (IaC) principles.

The project provisions:
- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Ubuntu Instance
- Remote Terraform Backend using S3

---

# Objectives

- Learn Terraform practically
- Automate AWS infrastructure provisioning
- Understand Infrastructure as Code
- Practice production-style Terraform workflow
- Configure secure networking
- Implement remote Terraform state management

---

# AWS Services Used

| Service | Purpose |
|---|---|
| EC2 | Ubuntu server |
| VPC | Private cloud network |
| Subnet | Public subnet for EC2 |
| Internet Gateway | Internet access |
| Route Table | Routing traffic |
| Security Group | Firewall rules |
| S3 | Remote Terraform backend |

---

# Architecture Flow

Terraform → S3 Backend → AWS Infrastructure

AWS Infrastructure Includes:
- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Ubuntu Instance

---

# Project Folder Structure

```bash
terraform-prod-project/
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── locals.tf
├── backend.tf
├── .gitignore
├── README.md
└── project_img.png
