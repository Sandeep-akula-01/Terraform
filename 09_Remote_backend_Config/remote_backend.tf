

terraform {
  backend "s3" {
    bucket = "sandeep-ace-buck"                      # S3 bucket to store the remote Terraform state file
    key    = "Terraform_State_Files/terraform.tfstate"  # Path inside the bucket where the state file will be saved
    region = "ap-south-1"                            # AWS region where the S3 bucket and DynamoDB table are created
    dynamodb_table = "terraform_lock"                # DynamoDB table used to enable state locking
  }
}
