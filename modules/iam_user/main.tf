# Flatten the groups structure to get all unique users
locals {
  all_users = toset(flatten([for group_name, config in var.groups : config.users]))

  # Create a map of user to their groups
  user_groups = {
    for user in local.all_users : user => [
      for group_name, config in var.groups : group_name
      if contains(config.users, user)
    ]
  }

  # Create a map of user to their roles (derived from their groups)
  user_roles = {
    for user in local.all_users : user => [
      for group_name, config in var.groups : config.role
      if contains(config.users, user)
    ]
  }
}

# Create IAM Groups
resource "aws_iam_group" "this" {
  for_each = var.groups
  name     = each.key
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each   = var.groups
  group      = aws_iam_group.this[each.key].name
  policy_arn = each.value.policy_arn
}

# Create IAM Users (only once per unique user)
resource "aws_iam_user" "user" {
  for_each      = local.all_users
  name          = each.value
  force_destroy = true
  tags = {
    CreatedBy = "Terraform"
    Role      = join(", ", local.user_roles[each.value])
    Groups    = join(", ", local.user_groups[each.value])
  }
}

# Add users to their respective groups
resource "aws_iam_user_group_membership" "group_membership" {
  for_each = local.all_users
  user     = aws_iam_user.user[each.key].name
  groups   = [for group in local.user_groups[each.key] : aws_iam_group.this[group].name]
}

# Generate random passwords for each user
resource "random_password" "temp_password" {
  for_each         = local.all_users
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+"
}

# Create login profiles with temporary passwords
resource "aws_iam_user_login_profile" "login_profile" {
  for_each                = local.all_users
  user                    = aws_iam_user.user[each.key].name
  password                = random_password.temp_password[each.key].result
  password_reset_required = true
}

# Store passwords in SSM Parameter Store
resource "aws_ssm_parameter" "user_temp_password" {
  for_each = local.all_users
  name     = "/iam/${each.value}/temp_password"
  type     = "SecureString"
  value    = random_password.temp_password[each.key].result
  tags = {
    CreatedBy = "Terraform"
    Role      = join(", ", local.user_roles[each.value])
    Groups    = join(", ", local.user_groups[each.value])
  }
}