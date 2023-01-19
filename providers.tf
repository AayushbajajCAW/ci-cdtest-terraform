terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45.0"
    }
  }
}
provider "aws" {
  region     = var.aws_region
  access_key = "abc"
  secret_key = "abc"
}