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
  access_key = "AKIAZKRR5PF64TH6LCQ4"
  secret_key = "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"
}