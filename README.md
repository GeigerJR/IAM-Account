#!/bin/bash
# ==========================================
# AWS IAM ACCOUNT SETUP — DevOpsAdmin Script
# ==========================================

# Exit on error
set -e

# Variables (edit these before running)
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
GROUP_NAME="Admins"
POLICY_NAME="FullAdminAccess"
USER_NAME="DevOpsAdmin"
LOGIN_PASSWORD="StrongPassword#2025"

echo "=== Creating IAM group: $GROUP_NAME ==="
aws iam create-group --group-name $GROUP_NAME || echo "Group already exists"

echo "=== Creating IAM admin policy ==="
cat > AdminPolicy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF

aws iam create-policy \
  --policy-name $POLICY_NAME \
  --policy-document file://AdminPolicy.json || echo "Policy already exists"

echo "=== Attaching policy to group ==="
aws iam attach-group-policy \
  --group-name $GROUP_NAME \
  --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/$POLICY_NAME

echo "=== Creating user: $USER_NAME ==="
aws iam create-user --user-name $USER_NAME || echo "User already exists"

echo "=== Adding user to group ==="
aws iam add-user-to-group \
  --user-name $USER_NAME \
  --group-name $GROUP_NAME

echo "=== Creating console password ==="
aws iam create-login-profile \
  --user-name $USER_NAME \
  --password "$LOGIN_PASSWORD" \
  --password-reset-required || echo "Login profile already exists"

echo "=== Generating access keys for CLI ==="
aws iam create-access-key --user-name $USER_NAME > AccessKeys.json || echo "Access keys already exist"

echo "=== Setup Complete ==="
echo "--------------------------------------"
echo "User: $USER_NAME"
echo "Group: $GROUP_NAME"
echo "Policy: $POLICY_NAME"
echo "Account ID: $ACCOUNT_ID"
echo "--------------------------------------"
echo "Access Keys saved to AccessKeys.json"
echo "Login password: $LOGIN_PASSWORD"
