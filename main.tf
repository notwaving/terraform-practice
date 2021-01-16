terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

# Set up Terraform backend
terraform {
  backend "s3" {
    bucket         = "terraform-dynamodb-bucket"
    key            = "terraform/state.tfstate"
    dynamodb_table = "hoist-terraform"
    region         = "eu-west-2"
  }
}

module "blog" {
  source = "./blog"
}

module "devInstances" {
  source = "./devInstances"
}

output "real_test" {
  value = module.devInstances.test_var
}

