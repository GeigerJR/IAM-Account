# 🚀 AWS IAM User Management with Terraform

This project automates the creation of **multiple IAM users with admin privileges** using Terraform. It includes a modular structure, remote state management with S3, and security best practices.

---

## 📁 Project Structure

```
IAM-Account/
├── backend/                    # Bootstrap infrastructure for remote state
│   ├── main.tf                # S3 bucket and DynamoDB table
│   ├── variables.tf           # Backend configuration variables
│   ├── outputs.tf             # Backend resource outputs
│   ├── README.md              # Detailed backend setup instructions
│   └── terraform.tfvars.example
├── modules/
│   └── iam_user/              # Reusable IAM user module
│       ├── main.tf            # User creation with passwords
│       ├── variables.tf       # Module inputs
│       ├── outputs.tf         # Module outputs
│       └── versions.tf        # Provider requirements
├── main.tf                    # Root module - creates IAM users
├── backend.tf                 # S3 backend configuration
├── outputs.tf                 # Root outputs (user names, passwords)
├── password_policy.tf         # AWS account password policy
└── README.md                  # This file
```

---

## ⚙️ What This Project Does

### Creates IAM Users
- ✅ Multiple IAM users in one run (John, Mary, David)
- ✅ Generates secure random passwords (16 characters)
- ✅ Stores passwords securely in AWS SSM Parameter Store
- ✅ Requires password reset on first login
- ✅ Attaches AdministratorAccess policy to each user

### Enforces Password Policy
- ✅ Minimum 14 characters
- ✅ Requires uppercase, lowercase, numbers, and symbols
- ✅ Prevents password reuse (last 5 passwords)
- ✅ Maximum password age: 90 days

### Remote State Management
- ✅ S3 bucket for state storage with versioning
- ✅ DynamoDB table for state locking
- ✅ Encryption enabled
- ✅ Folder-based state organization

---

## 🚀 Quick Start

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.3.0 installed
- AWS account with permissions to create IAM resources

### Step 1: Create Backend Infrastructure (One-Time Setup)

```bash
cd backend/

# Configure your backend settings
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars  # Update with your unique bucket name

# Create the S3 bucket and DynamoDB table
terraform init
terraform apply

# IMPORTANT: Backup the state file
cp terraform.tfstate terraform.tfstate.backup

cd ..
```

See `backend/README.md` for detailed instructions.

### Step 2: Configure Backend

Edit `backend.tf` to match your backend resources:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-bucket-name"  # From backend output
    key            = "iam-account/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-table-name"   # From backend output
    encrypt        = true
  }
}
```

### Step 3: Customize Users (Optional)

Edit `main.tf` to add/remove users:

```hcl
module "iam_users" {
  source = "./modules/iam_user"

  user_names       = ["John", "Mary", "David"]  # Modify this list
  admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
```

### Step 4: Deploy IAM Users

```bash
# Initialize Terraform (with S3 backend)
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply
```

### Step 5: Retrieve Passwords

```bash
# Get user names
terraform output iam_user_names

# Get SSM paths where passwords are stored
terraform output ssm_parameter_paths

# Retrieve a password from SSM Parameter Store
aws ssm get-parameter \
  --name "/iam/John/temp_password" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text
```

Or view sensitive outputs directly:

```bash
terraform output -json iam_user_temp_passwords
```

---

## 📂 State Management

This project uses **folder-based state separation** in S3:

```
s3://your-bucket/
└── iam-account/
    ├── dev/terraform.tfstate
    ├── staging/terraform.tfstate
    └── prod/terraform.tfstate
```

To use different environments, change the `key` in `backend.tf`:

- Dev: `iam-account/dev/terraform.tfstate`
- Staging: `iam-account/staging/terraform.tfstate`
- Prod: `iam-account/prod/terraform.tfstate`

---

## 🔐 Security Features

1. **Random Passwords**: 16-character passwords with special characters
2. **SSM Parameter Store**: Passwords stored as SecureString (encrypted)
3. **Force Password Reset**: Users must change password on first login
4. **Strong Password Policy**: Account-wide secure password requirements
5. **S3 Encryption**: State files encrypted at rest
6. **Public Access Block**: S3 bucket protected from public access
7. **State Locking**: Prevents concurrent modifications

---

## 🧩 Module Usage

The `iam_user` module is reusable. You can use it in other projects:

```hcl
module "custom_users" {
  source = "./modules/iam_user"

  user_names       = ["Alice", "Bob"]
  admin_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
```

---

## 🔄 Updating Users

### Add a New User

1. Edit `main.tf` and add the name to `user_names` list
2. Run `terraform apply`

### Remove a User

1. Edit `main.tf` and remove the name from `user_names` list
2. Run `terraform apply`

**Note**: The module uses `force_destroy = true`, so users with resources can be deleted.

---

## 🧹 Cleanup

To destroy all IAM users:

```bash
terraform destroy
```

To destroy the backend infrastructure (⚠️ dangerous):

```bash
cd backend/
terraform destroy
```

**Warning**: Destroying the backend will delete all state files!

---

## 📊 Outputs

| Output | Description |
|--------|-------------|
| `iam_user_names` | List of created user names |
| `iam_user_temp_passwords` | Temporary passwords (sensitive) |
| `ssm_parameter_paths` | SSM paths for password retrieval |

---

## 🐛 Troubleshooting

### Backend initialization fails
- Ensure the S3 bucket and DynamoDB table exist
- Check that bucket/table names in `backend.tf` match your backend outputs

### Access denied errors
- Verify your AWS credentials have IAM permissions
- Check that your user can create IAM users, groups, and policies

### Password retrieval fails
- Ensure the user has been created (`terraform apply` successful)
- Check SSM parameter exists: `aws ssm describe-parameters`

---

## 📚 References

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [Terraform S3 Backend](https://www.terraform.io/docs/language/settings/backends/s3.html)

---

## 📝 License

This project is for educational and internal use.
