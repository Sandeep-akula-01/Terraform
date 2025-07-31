# 🌐 Terraform Provisioners

Terraform **provisioners** allow you to execute actions on local or remote machines as part of resource creation or destruction. They are useful for bootstrapping, software installation, configuration, and notifications.

> ⚠️ Note: Provisioners should be used only when no other option (like user data or configuration tools) is available.

---

## 📚 Types of Provisioners

### 1️⃣ file Provisioner

**🔹 Description:**  
Transfers files from your **local machine** to a **remote resource** (like an EC2 instance) after it's created.

**🛠 Real-Time Use Cases:**
- Copying shell scripts to a server
- Uploading application files (e.g., `.war`, `.zip`, config files)
- Deploying binaries or packages to VM

**✅ Example:**
```hcl
provisioner "file" {
  source      = "scripts/setup.sh"
  destination = "/tmp/setup.sh"
}

connection {
  type        = "ssh"
  user        = "ec2-user"
  private_key = file("~/.ssh/my-key.pem")
  host        = self.public_ip
}


2️⃣ remote-exec Provisioner
🔹 Description:
Executes commands on the remote resource (e.g., EC2 instance) via SSH or WinRM.

🛠 Real-Time Use Cases:

Installing packages (e.g., apt, yum)

Running custom setup or bootstrap scripts

Starting/stopping services like nginx, Jenkins, etc.

✅ Example:

provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/setup.sh",
    "sudo /tmp/setup.sh"
  ]
}


3️⃣ local-exec Provisioner
🔹 Description:
Runs commands on your local machine (where Terraform is executed), not on the remote instance.

🛠 Real-Time Use Cases:

Sending notifications (e.g., Slack, Email)

Running local scripts or CLI tools (e.g., aws, curl, jq)

Logging provision status to local file

✅ Example:

provisioner "local-exec" {
  command = "echo EC2 instance provisioned successfully >> logs.txt"
}
🧠 When to Use Provisioners
Provisioners are helpful:

When automating simple post-deployment tasks

When no user-data or AMI customization options are available

In dev/test environments where speed and simplicity matter
