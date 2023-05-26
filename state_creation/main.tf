terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= v1.4.6"


}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
 
module "remote-state-s3-backend" {
  source  = "nozaq/remote-state-s3-backend/aws"
  version = "1.5.0"

  enable_replication = false
  dynamodb_table_name = "nginx-terraform-project-tfstate"
  s3_bucket_name = "nginx-terraform-project-tfstate"

  providers = {
    aws = aws
    aws.replica = aws
  }
}