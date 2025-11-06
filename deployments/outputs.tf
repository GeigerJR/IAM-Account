output "iam_group_name" {
  description = "Name of the IAM group"
  value       = module.iam_users.group_name
}

output "iam_user_names" {
  description = "Names of all created IAM users"
  value       = module.iam_users.user_names
}

output "iam_user_temp_passwords" {
  description = "Temporary passwords for all created users (retrieve from SSM Parameter Store)"
  value       = module.iam_users.user_temp_passwords
  sensitive   = true
}

output "ssm_parameter_paths" {
  description = "SSM Parameter Store paths where passwords are stored"
  value       = [for user in module.iam_users.user_names : "/iam/${user}/temp_password"]
}