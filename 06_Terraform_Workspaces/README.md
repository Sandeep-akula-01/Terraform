# Terraform Workspaces & Variabilizing Concepts

This folder demonstrates how to use **Terraform Workspaces** with environment-specific `.tfvars` files to manage multiple environments (like `dev`, `test`, `prod`) using the same Terraform codebase.

---

## 📌 What Are Terraform Workspaces?

Terraform Workspaces provide a way to manage **multiple state files** for the same configuration. Each workspace has its **own isolated state**, which makes it perfect for managing different environments (dev, prod, etc.) without duplicating code.

---

## 🎯 Why Use Workspaces + tfvars?

- ✅ **Single codebase** for all environments
- ✅ **Environment-specific variables** using `.tfvars` files
- ✅ **Clean separation** of state using workspaces
- ✅ Helps in organizing infrastructure in a scalable way

---

## ⚙️ Workspace Commands

| Command | Description |
|--------|-------------|
| `terraform workspace list`        | List all available workspaces |
| `terraform workspace new <name>` | Create a new workspace |
| `terraform workspace select <name>` | Switch to an existing workspace |
| `terraform workspace show`       | Show the current active workspace |

---
