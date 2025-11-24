output "created_users" {
  description = "List of users created by the module"
  value       = module.iam_users.user_names
}

output "initial_passwords" {
  description = "Temporary passwords for the new users"
  value       = module.iam_users.user_passwords
  sensitive   = true
}