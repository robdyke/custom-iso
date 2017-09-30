terraform {
  required_version = "~> 0.10"

  backend "s3" {
    bucket = "atkinchris-terraform"
    key    = "custom-iso"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}
