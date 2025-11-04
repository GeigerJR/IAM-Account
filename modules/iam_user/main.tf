# Create IAM User
resource "aws_iam_user" "this" {
  name = var.user_name
  tags = {
    ManagedBy = "Terraform"
  }
}

# Create IAM Group for Admins
resource "aws_iam_group" "admins" {
  name = "AdminGroup"
}

# Attach the AdministratorAccess policy to the group
resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Add the user to the Admin group
resource "aws_iam_user_group_membership" "membership" {
  user   = aws_iam_user.this.name
  groups = [aws_iam_group.admins.name]
}

# Optional: Create an access key for CLI/SDK usage
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.this.name
}