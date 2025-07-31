

resource "aws_instance" "server_1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  tags = {
    Name= var.server_name
  }
}
