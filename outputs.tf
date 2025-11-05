output "john_iam_user_name" {
  description = "The name of the created IAM user"
  value       = module.john_iam_user.user_name
}

output "john_temp_password_ssm_path" {
  description = "The SSM path where the temporary password is stored"
  value       = "/iam/${var.user_name}/temp_password"
}