
# Variable Declaration in separate file 
# we can change the values here and launch a new instance according to it if needed
# No need of changing the hard code again
# We can just change these values and launch the servers 

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
