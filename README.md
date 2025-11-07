# IAM Account

Terraform project for managing IAM users with group-based permissions across dev/prod environments.

## Table of Contents

- [LocalStack Setup](#localstack-setup)
- [Quick Start](#quick-start)
- [Structure](#structure)
- [Result](#result)
- [Usage](#usage)
  - [Configure Users](#configure-users)
  - [Deploy](#deploy)

---

## LocalStack Setup

This project uses LocalStack to save on AWS costs. Start LocalStack before running Terraform:

```bash
# Start LocalStack (Docker must be running)
localstack start -d

# Verify it's running
localstack status
```

[↑ Back to top](#table-of-contents)

## Quick Start

```bash
# 1. Setup backend (once)
cd backend
terraform init
terraform apply
cd ..

# 2. Deploy IAM users to dev
cd deployments/dev
terraform init
terraform apply

# 3. Get user passwords (from LocalStack)
aws --endpoint-url=http://localhost:4566 ssm get-parameter --name "/iam/John-Dev/temp_password" --with-decryption --query "Parameter.Value" --output text
```

[↑ Back to top](#table-of-contents)

## Structure

```
backend/          # S3 + DynamoDB (see backend/README.md)
modules/iam_user/ # IAM user module (see modules/iam_user/README.md)
deployments/dev/  # Dev environment
deployments/prod/ # Prod environment
```

[↑ Back to top](#table-of-contents)

## Result

After deployment, you'll have IAM users created across environments:

![IAM Users](docs/images/iam-users.png)

Passwords are securely stored in AWS Systems Manager Parameter Store:

![SSM Parameters](docs/images/ssm-parameters.png)

[↑ Back to top](#table-of-contents)

## Usage

### Configure Users

Edit `deployments/dev/terraform.tfvars`:

```hcl
environment = "dev"

groups = {
  "Admins" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = "Administrator"
    users      = ["John-Dev", "Mary-Dev"]
  }
  "PowerUsers" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    role       = "Power User"
    users      = ["David-Dev"]
  }
}
```

### Deploy

```bash
# Dev
cd deployments/dev
terraform apply

# Prod
cd deployments/prod
terraform apply
```

[↑ Back to top](#table-of-contents)
