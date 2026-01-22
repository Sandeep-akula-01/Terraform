

module "ec2_module" {

  source = "./ec2_module" # Path Of the Module
  ami= "ami-0b32d400456908bf9" # Ami Type (Linux/Ubuntu/Windows...)
  instance_type = "t2.micro" # Instance Type Declaration 
  server_name = "Module_server" # Name Of EC2 Server (tags)
}


# Here We're Calling the module by giving few required parameters (variables) like Source, AMI , Server_name, etc.   
