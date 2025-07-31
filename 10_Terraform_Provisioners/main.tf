provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = "10.81.0.0/16"
  tags = {
    Name="jenkins_vpc"
  }
  
}

resource "aws_subnet" "jenkins_sn" {
  cidr_block = "10.81.1.0/24"
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name="jenkins_sn"
  }
}

resource "aws_internet_gateway" "jenkins_IGW" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name="Jenkins_IGW"
  }
  
}

resource "aws_route_table" "jenkins_rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_IGW.id 
  }
  tags = {
    Name="jenkins_rt"
  }
  vpc_id = aws_vpc.jenkins_vpc.id
  
}

resource "aws_route_table_association" "jenkins_rta" {
  subnet_id = aws_subnet.jenkins_sn.id
  route_table_id = aws_route_table.jenkins_rt.id
  
}

resource "aws_security_group" "jenkins_SG" {
  vpc_id = aws_vpc.jenkins_vpc.id
  
  ingress  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
    from_port =0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins_server" {
  ami = "ami-0b32d400456908bf9"
  instance_type = "t2.micro"
  key_name = "devops-practice"
  vpc_security_group_ids = [aws_security_group.jenkins_SG.id]
  subnet_id = aws_subnet.jenkins_sn.id
  associate_public_ip_address = true
  tags ={
    Name="jenkins_server"
  }
   connection {
    type = "ssh"                                      # Specifies SSH as the connection type
    user = "ec2-user"                                 # Default username for Amazon Linux 2 AMIs
    private_key = file("C:/Users/sande/OneDrive/Desktop/keypairs/devops-practice.pem")  # Path to your private key for SSH authentication
    host = aws_instance.jenkins_server.public_ip      # Public IP of the EC2 instance to connect via SSH
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo yum update -y",                                                            # Update all packages
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",  # Add Jenkins repo
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",   # Import Jenkins GPG key
      "sudo yum upgrade",                                                              # Upgrade any outdated packages
      "sudo yum install java-17-amazon-corretto -y",                                   # Install Java 17 (required for Jenkins)
      "sudo yum install jenkins -y",                                                   # Install Jenkins
      "sudo systemctl enable jenkins",                                                 # Enable Jenkins to start on boot
      "sudo systemctl start jenkins",                                                  # Start Jenkins service
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",                        # Output the initial Jenkins admin password
     ]
  }


}


output "public_ip" {
  value = aws_instance.jenkins_server.public_ip
  
}

output "instance_id" {
  value = aws_instance.jenkins_server.id
  
}

# Here we have implemented provisioner (remote-exec) to configure Jenkins on the EC2 instance after it is created and displayed Instance Public IP and Instance ID