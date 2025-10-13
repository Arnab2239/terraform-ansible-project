terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = "~> 3.0"   # optionally pin provider version
    }
  }
 backend "s3" {
    bucket = "arnab-lock-bucket" 
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "arnab-state-table"
  }

}
