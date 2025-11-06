# IAM User Module

Creates IAM users, groups, and manages group membership with policies.

## Table of Contents

- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [What It Creates](#what-it-creates)

---

## Usage

```hcl
module "iam_users" {
  source = "./modules/iam_user"

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
}
```

[↑ Back to top](#table-of-contents)

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `groups` | Map of IAM groups with policies, roles, and users | `map(object({ policy_arn = string, role = string, users = list(string) }))` | Yes |

[↑ Back to top](#table-of-contents)

## Outputs

| Name | Description |
|------|-------------|
| `group_names` | Map of created IAM group names |
| `user_names` | List of created IAM user names |
| `user_groups` | Map of users to their assigned groups |
| `user_roles` | Map of users to their roles |

[↑ Back to top](#table-of-contents)

## What It Creates

- IAM users with login profiles
- IAM groups
- Group policy attachments
- Group memberships
- Random passwords (16 chars)
- SSM parameters for passwords (`/iam/<env>/<user>/temp_password`)

[↑ Back to top](#table-of-contents)

