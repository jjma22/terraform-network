terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">=1.4.6"
  backend "s3" {
    bucket         	   = "nc-cloud-project-bucket"
    key              	   = "terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table = "basic-dynamodb-table"
  }


}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
 