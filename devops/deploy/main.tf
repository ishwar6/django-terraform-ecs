terraform {
  backend "s3" {
    bucket         = "ij-tfstate"
    key            = "app.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "ij-tfstate-lock"
  }
}

provider "aws" {
  region  = "ap-south-1"
  version = "~> 4.41.0"
}
provider "snowflake" {
  account= var.snowflake_account 
  username = var. snowflake_user
  region = var. snowflake_region
  private_key_path role = var.snowflake_private_key_path
  role = var.snowflake_role}}
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




