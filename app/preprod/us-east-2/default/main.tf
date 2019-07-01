provider "aws" {
  region = "${var.aws_region}"
}

module "vpc" {
  source              = "../../../../modules/vpc"
  env                 = "${var.general.env}"
  client_name         = "${var.general.client_name}"
  domain_name         = "${var.general.domain_name}"
  domain_name_servers = "${var.general.domain_name_servers}"
  aws_region          = "${var.aws_region}"
  cidr                = "${var.network.cidr_vpc}"
}

module "security_groups" {
  source       = "../../../global/security_groups"
  env          = "${terraform.workspace}"
  client_name  = "${var.general.client_name}"
  aws_region   = "${var.aws_region}"
  vpc_id       = "${module.vpc.vpc_id}"
}

