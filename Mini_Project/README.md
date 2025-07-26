# 🛠️ AWS EC2 Web Server Deployment using Terraform

This project automates the provisioning of a web server on AWS using Terraform. It sets up a VPC-based network architecture with internet connectivity, security configurations, and an EC2 instance running Apache HTTP Server with custom user data.

---

## 🚀 What This Project Does

1. **Defines AWS as the cloud provider** and sets the region to `ap-south-1` (Mumbai).
2. **Creates a custom VPC** with the CIDR range `10.81.0.0/16`.
3. **Launches a public subnet** in the availability zone `ap-south-1a` with CIDR `10.81.3.0/24`.
4. **Creates an Internet Gateway (IGW)** and attaches it to the VPC to allow internet access.
5. **Creates a custom Route Table**, adds a default route (`0.0.0.0/0`) pointing to the IGW.
6. **Associates the public subnet** with the custom route table to enable internet access from the subnet.
7. **Creates a Security Group** allowing inbound traffic for:
   - SSH (Port 22)
   - HTTP (Port 80)
   - HTTPS (Port 443)
   - All outbound traffic is allowed.
8. **Creates a custom Elastic Network Interface (ENI)** with:
   - A fixed private IP: `10.81.3.33`
   - The above security group attached
9. **Allocates and associates an Elastic IP** (EIP) with the ENI to provide a public IP for external access.
10. **Launches an EC2 instance** (`t2.micro`) using:
    - A predefined AMI (`ami-0b32d400456908bf9`)
    - The custom ENI with the assigned private IP
    - A user data script (`boot.sh`) to install and start an Apache web server
11. **Bootstraps the instance** with a custom homepage message:  
    `"This is Sandeep From Facebook Webpage Created using Terraform script"`
12. **Outputs the public IP address** of the EC2 instance after deployment.

---


