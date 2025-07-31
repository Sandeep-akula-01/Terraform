# 🌐 Terraform Modules — Reusable Infrastructure as Code

This folder demonstrates how to **build and use Terraform modules** to launch AWS resources (e.g., EC2) in a **modular, reusable, and scalable** way.

---

## 📦 What Are Terraform Modules?

Terraform **modules** are containers for multiple resources that are used together. A module is a way to **group related infrastructure** and **reuse it** across environments, regions, or even entire projects.

A module is just a **folder with `.tf` files** (like `main.tf`, `variables.tf`, `outputs.tf`), which you can call from a root configuration using the `module` block.

---

## 🎯 Why Use Modules?

| Benefit                        | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| 🔁 Reusability                 | Define infrastructure once, reuse in multiple places                        |
| 🔧 Better Organization         | Separate logic for compute, networking, security, etc.                      |
| 🔍 Maintainability             | Makes large Terraform codebases easier to manage and scale                  |
| 💡 Best Practice               | Encouraged by Terraform community and used in real-world cloud architectures |

---

## 🏗️ Real-Time Use Cases

1. **Launch EC2 instance in multiple environments** (dev, prod) with the same base module  
2. **Create reusable VPC and subnet modules** for all projects  
3. **Standardize infrastructure components** (like IAM roles, S3 buckets, security groups)  
4. Use with **workspaces + tfvars** for large-scale environment separation  
5. Used in **multi-team organizations** where each team owns one module

---
