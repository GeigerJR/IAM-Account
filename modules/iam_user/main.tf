locals {
  all_users = toset(flatten([
    for group_name, group_data in var.groups : group_data.users
  ]))
}

resource "aws_iam_user" "user" {
  for_each      = local.all_users
  name          = each.value
  force_destroy = true

  tags = {
    CreatedBy = "Terraform"
    Role      = join(", ", [for g, d in var.groups : g if contains(d.users, each.value)])
  }
}


resource "random_password" "temp_password" {
  for_each = local.all_users
  length   = 16
  special  = true
}

resource "aws_iam_user_login_profile" "login_profile" {
  for_each                = local.all_users
  user                    = aws_iam_user.user[each.key].name
  password_reset_required = true
}


resource "aws_ssm_parameter" "user_temp_password" {
  for_each = local.all_users
  name     = "/iam/${each.value}/temp_password"
  type     = "SecureString"
  value    = random_password.temp_password[each.key].result

  tags = {
    CreatedBy = "Terraform"
  }
}