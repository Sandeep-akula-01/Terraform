variable "vpc_cidr" {
  default = "10.81.0.0/16"
}

variable "subnet_cidr" {
  default = "10.81.3.0/24"
  
}

variable "nic_privateip" {
  default = ["10.81.3.33"]
  
}
variable "eip_private" {
  default = "10.81.3.33"
  
}

variable "ami" {
  default = "ami-0b32d400456908bf9"
}

variable "key_name" {
  default = "devops-practice"
  
}
variable "instance_type" {
  default = "t2.micro"
}

variable "Server_name" {
  default = "Test_Server"
  
}

variable "region" {
  default = "ap-south-1"
  
}