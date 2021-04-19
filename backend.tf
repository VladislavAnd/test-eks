provider "aws" {
  version = "~> 3.22.0"
  region  = "eu-west-1"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
