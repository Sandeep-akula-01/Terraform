#Selecting the Cloud Provider and Region 
provider "aws" {
  region = "ap-south-1"
  
}

#Resource Selection : EC2 
resource "aws_instance" "prod-server" {
  ami = "ami-0b32d400456908bf9" #Region Specific
  instance_type = "t2.micro"  #Global
  key_name = "devops-practice" #Region Specific
  tags = {
    Name = "prod-server"
  }
  
}


# Here we've created a EC2 instance in Mumbai Region using Terraform Script 
