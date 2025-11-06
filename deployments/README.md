# Deployments

This directory contains different deployment configurations. Each deployment is a separate use case or infrastructure component.

## 📁 Structure

```
deployments/
├── iam_users/           # IAM user and group management
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   ├── password_policy.tf
│   └── providers.tf
│
└── (future deployments)
    ├── iam_roles/       # IAM roles for services
    ├── s3_buckets/      # S3 bucket management
    ├── vpc/             # VPC infrastructure
    └── ...
```

## 🎯 Current Deployments

### **iam_users/**
Manages IAM users and groups with flexible policy assignments.

**Purpose**: Create and manage IAM users across multiple groups with different permissions.

**Usage**:
```bash
cd deployments/iam_users/

# Initialize
terraform init -backend-config=../../config/dev/backend.hcl

# Deploy
terraform apply -var-file=../../config/dev/terraform.tfvars
```

**Features**:
- Multiple groups with different policies
- Users can belong to multiple groups
- Automatic password generation and SSM storage
- Account-wide password policy

---

## 🚀 Adding New Deployments

To add a new deployment type:

```bash
# Create new deployment directory
mkdir -p deployments/my_deployment

# Create basic structure
cd deployments/my_deployment
touch main.tf variables.tf outputs.tf backend.tf providers.tf README.md
```

**Template `main.tf`:**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

module "my_module" {
  source = "../../modules/my_module"
  
  # Variables from config
}
```

**Template `backend.tf`:**
```hcl
terraform {
  # Backend config provided via: -backend-config=../../config/<env>/backend.hcl
  backend "s3" {}
}
```

---

## 📋 Deployment Workflow

Each deployment follows the same pattern:

```bash
# 1. Navigate to deployment
cd deployments/<deployment-name>/

# 2. Set environment
export ENV=dev

# 3. Initialize with backend config
terraform init -backend-config=../../config/$ENV/backend.hcl

# 4. Plan with environment config
terraform plan -var-file=../../config/$ENV/terraform.tfvars

# 5. Apply
terraform apply -var-file=../../config/$ENV/terraform.tfvars
```

---

## 🔄 Multiple Deployments

You can run multiple deployments in the same environment:

```
s3://project-terraform-state/
├── iam-users/
│   ├── dev/terraform.tfstate
│   ├── staging/terraform.tfstate
│   └── prod/terraform.tfstate
├── iam-roles/
│   └── dev/terraform.tfstate
└── s3-buckets/
    └── prod/terraform.tfstate
```

Each deployment has its own state file, enabling independent management.

---

## 💡 Benefits of This Structure

✅ **Separation of Concerns**: Each deployment is independent
✅ **Scalable**: Easy to add new deployment types
✅ **Isolated State**: Changes in one deployment don't affect others
✅ **Reusable Modules**: Modules can be shared across deployments
✅ **Clear Organization**: Easy to find and manage specific infrastructure

---

## 📝 Example: Multiple Deployments

```bash
# Deploy IAM users
cd deployments/iam_users/
terraform apply -var-file=../../config/dev/terraform.tfvars

# Deploy VPC (future)
cd deployments/vpc/
terraform apply -var-file=../../config/dev/terraform.tfvars

# Deploy S3 buckets (future)
cd deployments/s3_buckets/
terraform apply -var-file=../../config/dev/terraform.tfvars
```

Each deployment is independent but can reference outputs from others if needed!

