variable "aws_region" {
  description = "AWS region for the global root state."
}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "s3.terraform.root-state.us-east-2"
    key = "terraform"
    region = "us-east-2"
  }
}

module "root_state" {
  source      = "./.root_state"
  aws_region  = "${var.aws_region}"
}

module "app" {
  source      = "./app/preprod/us-east-2/default"
  aws_region  = "${var.aws_region}"
}