provider "aws" {
  region = "ap-south-1"
  
}

# Launching an instance but the state file will be stored in Amazon S3 (Centrally)
resource "aws_instance" "server_1" {
  ami = "ami-0b32d400456908bf9"
  instance_type = "t2.micro"
  key_name = "devops-practice"
  
}