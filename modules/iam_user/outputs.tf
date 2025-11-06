output "group_name" {
  description = "Name of the IAM group"
  value       = aws_iam_group.this.name
}

output "user_names" {
  description = "List of created IAM user names"
  value       = [for user in aws_iam_user.user : user.name]
}

output "user_temp_passwords" {
  description = "Temporary passwords for users"
  value       = { for k, v in random_password.temp_password : k => v.result }
  sensitive   = true
}
