output "iam_group_names" {
  description = "Map of created IAM groups"
  value       = module.iam_users.group_names
}

output "iam_user_names" {
  description = "Names of all created IAM users"
  value       = module.iam_users.user_names
}

output "iam_user_groups" {
  description = "Map of users to their groups"
  value       = module.iam_users.user_groups
}

output "iam_user_roles" {
  description = "Map of users to their roles"
  value       = module.iam_users.user_roles
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