provider "aws" {
  region = "ap-south-1"
  
}


# Variable Declaration 

variable "linux_ami" {
  default = "ami-0b32d400456908bf9"
}

variable "devops_pvt_key" {
  default = "devops-practice"  
}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_groups" {
  default = ["devops_practice_SG"]
}

variable "tags" {
  default="Prod_server"
}


# Instance Configuration using Variables 

resource "aws_instance" "prod_server" {
  ami = var.linux_ami
  key_name = var.devops_pvt_key
  instance_type = var.instance_type
  security_groups = var.security_groups
  count = 1
  tags = {
    Name="prod-server"
  }
}

# We have created a EC2 instance in mumbai region using Variables 
# Here the variables are also in the same manifest file (main.tf) but we can also create a new .tf file  all the variables to seperate them from main code
# variables are created for the Dynamic values like ami , instance type , keys , cidrs etc
