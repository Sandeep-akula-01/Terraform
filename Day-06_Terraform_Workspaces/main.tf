provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_instance" "prod_server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name

  tags = {
    Name=var.Instance_name
  }
}