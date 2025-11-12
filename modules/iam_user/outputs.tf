output "groups_created" {
  description = "List of IAM groups created"
  value       = keys(var.groups)
}

output "user_login_profiles" {
  description = "Login profile details for each user"
  value = {
    for username, profile in aws_iam_user_login_profile.login_profile :
    username => {
      password_reset_required = profile.password_reset_required
      user_name               = profile.user
    }
  }
}