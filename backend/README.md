## 🧱 1. backend/README.md

### **Purpose**

This folder contains Terraform configuration files for **bootstrapping the S3 remote backend** that stores the project’s Terraform state files.  
The backend setup ensures that all state data is centralized, consistent, and securely managed — a key DevOps best practice.

### **Key Components**

- **S3 Bucket** – Stores the Terraform state file.  
- **DynamoDB Table** – Provides state locking to prevent concurrent edits.  
- **IAM Role/Policy** – Grants Terraform access to manage backend resources.

### **Setup Steps**

1. Navigate to the backend directory:

cd backend

2. Initialize Terraform:

terraform init

3. Deploy the backend:

terraform apply

4. Copy the output bucket and DynamoDB details into your environment config files (e.g., `config/dev/backend.hcl`).

### **Why This Matters**

- Enables **collaboration** — everyone shares the same remote state.  
- Provides **locking** — no conflicting updates.  
- Improves **disaster recovery** — the state is not tied to any local machine.
