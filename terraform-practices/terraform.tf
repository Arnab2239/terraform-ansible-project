terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.15.0"
    }
  }

  backend "s3" {
    bucket         = "arnab-lock-bucket"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "arnab-state-table"
  }
}


