# 🚀 AWS IAM Account Setup (Terraform-Style Bash Project)

This project automates the creation of a **new IAM user with admin privileges** from your AWS root or IAM account.  
It follows a **Terraform-like modular structure** to keep things clean and maintainable.

---

## 📁 Folder Structure

```
IAM-Account/
├── main.sh                  # Entry point script that sources all modules
├── README.md                # Documentation file (this one)
└── modules/
    └── iam/
        ├── main.sh          # Creates IAM user, group, and attaches policy
        ├── variables.sh     # Holds variables (username, group, etc.)
        └── outputs.sh       # Displays output info like access keys
```

---

## ⚙️ What This Script Does

- ✅ Creates an IAM **group** (e.g., `DevOpsAdmins`)
- ✅ Attaches **AdministratorAccess** policy to the group
- ✅ Creates a **user** (e.g., John) and adds him to that group
- ✅ Generates and displays **access keys** for the user

---

## 🧩 How Each File Works

| File | Purpose |
|------|----------|
| `main.sh` | The entry point; sources and executes module scripts |
| `modules/iam/main.sh` | Contains AWS CLI commands for creating resources |
| `modules/iam/variables.sh` | Stores variable definitions |
| `modules/iam/outputs.sh` | Prints final results and credentials |

---

## 🚀 How to Run

> ⚠️ Make sure your AWS CLI is configured with credentials that can create IAM resources.

```bash
# Step 1: Clone the repository
git clone https://github.com/GeigerJR/IAM-Account.git
cd IAM-Account

# Step 2: Make scripts executable
chmod +x main.sh modules/iam/*.sh

# Step 3: Run the main script
./main.sh
```

---

## 🧠 Example Output

```
✅ Created IAM group: DevOpsAdmins
✅ Attached policy: AdministratorAccess
✅ Created IAM user: John
✅ Added user John to group DevOpsAdmins
✅ Access Key: AKIAIOSFODNN7EXAMPLE
✅ Secret Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```
