terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">=1.4.6"
  backend "s3" {
    bucket         	   = "tf-remote-state20230526152150449800000001"
    key              	   = "terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    kms_key_id = "c3d9f3be-f222-448c-8416-f65bb91f251c"
    dynamodb_table = "nginx-terraform-project-tfstate"
  }


}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
 