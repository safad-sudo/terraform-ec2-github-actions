terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-my-12345"
    key    = "ec2/webapp/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
