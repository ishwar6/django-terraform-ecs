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
  region = "ap-south-1"
  version = "~> 4.41.0"
  shared_config_files      = ["/Users/ishwarjangid/.aws/conf"]
  shared_credentials_files = ["/Users/ishwarjangid/.aws/creds"]
   profile                  = "default"
}
    