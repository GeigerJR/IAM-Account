# Create IAM Group
resource "aws_iam_group" "this" {
  name = var.group_name
}

# Attach policy to the group (not directly to users)
resource "aws_iam_group_policy_attachment" "group_policy" {
  group      = aws_iam_group.this.name
  policy_arn = var.admin_policy_arn
}

# Create IAM Users
resource "aws_iam_user" "user" {
  for_each      = toset(var.user_names)
  name          = each.value
  force_destroy = true
  tags = {
    CreatedBy = "Terraform"
    Role      = "DevOps Engineer"
    Group     = var.group_name
  }
}

# Add users to the group
resource "aws_iam_user_group_membership" "group_membership" {
  for_each = toset(var.user_names)
  user     = aws_iam_user.user[each.key].name
  groups   = [aws_iam_group.this.name]
}

# Generate random passwords for each user
resource "random_password" "temp_password" {
  for_each            = toset(var.user_names)
  length              = 16
  special             = true
  override_characters = "!@#$%^&*()-_=+"
}

# Create login profiles with temporary passwords
resource "aws_iam_user_login_profile" "login_profile" {
  for_each                = toset(var.user_names)
  user                    = aws_iam_user.user[each.key].name
  password                = random_password.temp_password[each.key].result
  password_reset_required = true
}

# Store passwords in SSM Parameter Store
resource "aws_ssm_parameter" "user_temp_password" {
  for_each = toset(var.user_names)
  name     = "/iam/${each.value}/temp_password"
  type     = "SecureString"
  value    = random_password.temp_password[each.key].result
  tags = {
    CreatedBy = "Terraform"
    Group     = var.group_name
  }
}
}