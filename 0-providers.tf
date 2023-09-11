terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "eks-cluster-main-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-cluster-main-dynamolock"
  }
}

#resource "aws_s3_bucket" "my_bucket" {
  #bucket = "my_s3bucket_for_demo"  # Replace with your desired bucket name
  #acl    = "private"  # Set the access control list (ACL) as needed

  #tags = {
   # Name = "My_s3bucket_for_demo"
    #Environment = "Development"
  #}
#}
