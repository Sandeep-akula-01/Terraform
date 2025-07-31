provider "aws" {
  region = "ap-south-1"
  
}

# Creating a S3 Bucket
resource "aws_s3_bucket" "sandeep_ace_buck" { 
  bucket = "sandeep-ace-buck" 
  tags = {
    Name="sandeep-ace-buck"  
  }
  
}

#resource "aws_s3_bucket" "sandeep_ace_buck": Defines a new S3 bucket resource and gives it a local name sandeep_ace_buck within Terraform.
#bucket = "sandeep_ace_buck": Sets the actual S3 bucket name. Must be globally unique across all AWS accounts.
#tags = {...}: Adds metadata tags to the bucket for identification and organization in AWS console.

#=======================================================================================================================



# Creating DynamoDB Table 

resource "aws_dynamodb_table" "terraform_lock" {
  name = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID" 
  attribute {
    name = "LockID"
    type = "S"
  }
}

# #resource "aws_dynamodb_table" "terraform_lock": Declares a new DynamoDB table with the local Terraform name terraform_lock.
# #name = "terraform_lock": Sets the table name as shown in the AWS console.
# billing_mode = "PAY_PER_REQUEST":
# This means you pay per read/write request instead of provisioning capacity (PROVISIONED mode).
# Easier and more cost-effective for low-usage cases like state locking.
# hash_key = "LockID": Sets the primary key of the table (partition key).
# attribute {...}:
# Defines the key schema for the table.
# name = "LockID": Name of the attribute used as the hash key.
# type = "s": The attribute is a String type.
