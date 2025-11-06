output "group_names" {
  description = "Map of created IAM groups"
  value       = { for k, v in aws_iam_group.this : k => v.name }
}

output "user_names" {
  description = "List of created IAM user names"
  value       = [for user in aws_iam_user.user : user.name]
}

output "user_groups" {
  description = "Map of users to their groups"
  value       = local.user_groups
}

output "user_temp_passwords" {
  description = "Temporary passwords for users"
  value       = { for k, v in random_password.temp_password : k => v.result }
  sensitive   = true
}
