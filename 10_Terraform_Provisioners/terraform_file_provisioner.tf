provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_vpc" "Google_vpc" {
  cidr_block = "10.81.0.0/16"
  tags = {
    Name="Google_vpc"
  }
  
}

resource "aws_subnet" "Google_sn" {
  cidr_block = "10.81.1.0/24"
  vpc_id = aws_vpc.Google_vpc.id
  tags = {
    Name="Google_sn"
  }
}

resource "aws_internet_gateway" "Google_IGW" {
  vpc_id = aws_vpc.Google_vpc.id
  tags = {
    Name="Google_IGW"
  }
  
}

resource "aws_route_table" "Google_rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Google_IGW.id
  }
  tags = {
    Name="Google_rt"
  }
  vpc_id = aws_vpc.Google_vpc.id
  
}

resource "aws_route_table_association" "Google_rta" {
  subnet_id = aws_subnet.Google_sn.id
  route_table_id = aws_route_table.Google_rt.id
  
}

resource "aws_security_group" "Google_SG" {
  vpc_id = aws_vpc.Google_vpc.id
  
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
  tags = {
    Name="Google_SG"
  }

}

resource "aws_instance" "Google_server" {
  ami = "ami-0b32d400456908bf9"
  instance_type = "t2.micro"
  key_name = "devops-practice"
  vpc_security_group_ids = [aws_security_group.Google_SG.id]
  subnet_id = aws_subnet.Google_sn.id
  associate_public_ip_address = true
  tags ={
    Name="Google_server"
  }
   connection {
    type = "ssh"                                      # Specifies SSH as the connection type
    user = "ec2-user"                                 # Default username for Amazon Linux 2 AMIs
    private_key = file("C:/Users/sande/OneDrive/Desktop/keypairs/devops-practice.pem")  # Path to your private key for SSH authentication
    host = aws_instance.Google_server.public_ip     # Public IP of the EC2 instance to connect via SSH
  }

  provisioner "file" {    #File Provisioner
    source = "index.html"
    destination = "/tmp/index.html"
    
  }

  provisioner "remote-exec" {  #Remote Provisioner to install httpd Services 
    inline = [ 
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
     ]
  }


}


output "public_ip" {
  value = aws_instance.Google_server.public_ip
  
}

output "instance_id" {
  value = aws_instance.Google_server.id
  
}

# Here we have implemented provisioner (remote-exec) and File Provisioner to install httpd Service on the EC2 instance after it is created and displayed Instance Public IP and Instance ID