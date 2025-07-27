provider "aws" {
  region = "ap-south-1"
  
}

# Instance Configuration using Variables from variables.tf file 

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
# Here the variables are also in a different manifest file (variables.tf) but we can access those variables from this file
# Since both the files in same folder we can connect both of them Variable file & main.tf file
# variables are created for the Dynamic values like ami , instance type , keys , cidrs etc
