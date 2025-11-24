# 🚀 IAM Account Project

This project automates the creation of a **new IAM user with admin privileges** from your AWS root or IAM account.  
It follows a **Terraform-like modular structure** to keep things clean and maintainable.

---

## 📁 Structure

- **backend/** → Remote backend setup (S3 + DynamoDB)  
- **modules/** → Reusable Terraform modules  
- **deployments/** → Environment deployments  
- **config/** → Environment configurations

---

## 📂 Project Folder Structure

IAM-Account/
├── backend/
│   ├── main.tf
│   └── README.md
├── config/
│   └── README.md
├── deployments/
│   ├── main.tf
│   └── README.md
├── modules/
│   └── iam_user/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
└── README.md
