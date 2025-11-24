output "user_names" {
  description = "List of IAM users created"
  value       = [for user in aws_iam_user.user : user.name]
}

output "user_passwords" {
  description = "Map of users to their temporary passwords (from SSM)"
  value = {
    for user in aws_iam_user.user :
    user.name => aws_ssm_parameter.user_temp_password[user.name].value
  }
  sensitive = true
}