terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45.0"
    }
  }
}
provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key_id
  secret_key = var.access_key_secret
  default_tags {
    tags = {
      org             = "CAW Studios"
      org-cost-center = "CAW Studios"
      org-team        = "devops"
      org-owner       = "aayushbajaj505@gmail.com"
      app-environment = "Dev"
      info-terraform  = "yes"
      info-created_by = "Aayush" // username
      info-purpose    = "Development"
    }
  }
}