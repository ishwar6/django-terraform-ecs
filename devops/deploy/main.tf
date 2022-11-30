terraform {
  backend "s3" {
    bucket         = "vision-backend-api-tfstate"
    key            = "app.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "vision-backend-api-tfstate-lock"
  }
}

provider "aws" {
  region  = "ap-south-1"
  version = "~> 4.41.0"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }

}

data "aws_region" "current" {}




