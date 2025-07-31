#Provider = AWS , Region = Mumbai
provider "aws" {
  region = "ap-south-1"
  alias = "Mum"     #alias = Mum (Used to deploy resources at that particular region)
  
}

#Provider = AWS , Region = NV
provider "aws" {
  region = "us-east-1"
  alias = "NV"     #alias = Mum (Used to deploy resources at that particular region)

}

#resource Configuration --> EC2 in Mumbai Region 
resource "aws_instance" "Prod-Mum" {
  ami = "ami-0b32d400456908bf9"
  instance_type = "t2.micro"
  key_name = "devops-practice"
  security_groups = ["devops_practice_SG"]
  tags = {
    Name = "Prod-MUM-Server"
  }
  provider = aws.Mum  #Alias is used here to mention the provider and region 
}

#resource Configuration --> EC2 in NV Region 

resource "aws_instance" "Prod-NV" {
  ami = "ami-0cbbe2c6a1bb2ad63"
  key_name = "ebs-key"
  instance_type = "t2.micro"
  security_groups = ["EBS-SG"]
  tags = {
    Name="Prod-NV-Server"
  }
  provider = aws.NV #Alias is used here to mention the provider and region
  
}


# Here we have deployed two EC2 linux Servers in two different regions using Terraform Script