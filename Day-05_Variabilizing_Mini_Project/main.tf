#Declaring Provider and Region 
provider "aws" {
  region = var.region
  
}

# VPC Creation , CIDR Range = 10.81.0.0/16
resource "aws_vpc" "Prod_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name="Prod-vpc"
  }
}

# IGW Created and Attached to VPC
resource "aws_internet_gateway" "Prod_IGW" {
  vpc_id = aws_vpc.Prod_vpc.id
  tags = {
    Name="Prod-IGW"
  }
}

# Custom Route_Table Creation and adding public Route 
resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.Prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Prod_IGW.id
  }
  tags = {
    Name="Prod_rt"
  }

}

# Subnet Creation in ap-south-1a AZ , Subnet CIDR Range = 10.81.3.0/24
resource "aws_subnet" "prod_sn" {
  vpc_id = aws_vpc.Prod_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = "ap-south-1a"
  tags={
    Name="prod_sn"
  }
  
}

# Subnet Association with the Custom Route_Table
resource "aws_route_table_association" "prod-rta" {
  subnet_id = aws_subnet.prod_sn.id
  route_table_id = aws_route_table.prod_rt.id
  
  
}

# Security Group Creation , Inbound = ssh --> 22  Http & https --> 80 & 443 , Outbound --> All traffic
resource "aws_security_group" "prod_SG" {
  vpc_id = aws_vpc.Prod_vpc.id
  #Inbound Rules
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Outbound_Rules
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name="prod_SG"
  }

}

# Custom Network_interface and Private IP 
resource "aws_network_interface" "prod_nic" {
  subnet_id = aws_subnet.prod_sn.id
  private_ips = var.nic_privateip
  security_groups = [aws_security_group.prod_SG.id]
  tags = {
    Name="prod-nic"
  }
  
}

# Elastic IP Address
resource "aws_eip" "prod_eip" {
  domain = "vpc"
  network_interface = aws_network_interface.prod_nic.id
  associate_with_private_ip = var.eip_private
  tags = {
    Name="prod_eip"
  }
}

#Instance Creation with User data -->facebookpage.sh 

resource "aws_instance" "prod_server" {
  ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  user_data = "${file("boot.sh")}"
  network_interface {
    network_interface_id = aws_network_interface.prod_nic.id
    device_index = 0
  }
  tags = {
    Name="Prod_FB_Server"
  }
}

# Giving the Public IP of the server as output to access the server
output "ec2_pub_ip" {
  value = aws_instance.prod_server.public_ip
  
}
