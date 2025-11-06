resource "aws_iam_user" "user" {
  for_each = toset(var.user_names)
vscode-remote://codespaces%2Bideal-couscous-jjqx5x6gj96c5qr7/workspaces/IAM-Account/modules  name     = each.value
  force_destroy = true
  tags = {
    CreatedBy = "Terraform"
    Role      = "DevOps Engineer"
  }
}

resource "random_password" "temp_password" {
  for_each = toset(var.user_names)
  length           = 16
  special          = true
  override_characters = "!@#$%^&*()-_=+"
}

resource "aws_iam_user_login_profile" "login_profile" {
  for_each = toset(var.user_names)
  user                    = aws_iam_user.user[each.key].name
  password                = random_password.temp_password[each.key].result
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
  for_each   = toset(var.user_names)
  user       = aws_iam_user.user[each.key].name
  policy_arn = var.admin_policy_arn
}

resource "aws_ssm_parameter" "user_temp_password" {
  for_each = toset(var.user_names)
  name     = "/iam/${each.value}/temp_password"
  type     = "SecureString"
  value    = random_password.temp_password[each.key].result
  tags = {
    CreatedBy = "Terraform"
  }
}