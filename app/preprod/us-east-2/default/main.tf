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

module "subnets" {
  source               = "../../../../modules/subnets"
  env                  = "${terraform.workspace}"
  client_name          = "${var.general.client_name}"
  aws_region           = "${var.aws_region}"
  vpc_id               = "${module.vpc.vpc_id}"
  gw_id                = "${module.vpc.gw_id}"
  availablity_zones    = "${var.network.availablity_zones}"
  public_subnets_cidr  = "${var.network.public_subnets_cidr}"
  private_subnets_cidr = "${var.network.private_subnets_cidr}"
  nat_gateway_enabled  = "1"                                                                       # If you dont need to create a Managed Nat Gateway. Set this value to 0
}

module "security_groups" {
  source       = "../../../global/security_groups"
  env          = "${terraform.workspace}"
  client_name  = "${var.general.client_name}"
  aws_region   = "${var.aws_region}"
  vpc_id       = "${module.vpc.vpc_id}"
}

module "rds" {
  source                  = "../../../../modules/rds"
  env                     = "${terraform.workspace}"
  client_name             = "${var.general.client_name}"
  subnet_ids              = "${module.subnets.public_ids}"
  db_name                 = "${var.rds.db_name}"
  db_username             = "${var.rds.db_login}"
  db_password             = "${var.rds.db_password}"
  db_size                 = "${var.rds.db_size}"
  db_engine               = "${var.rds.db_engine}"
  db_engine_version       = "${var.rds.db_engine_version}"
  db_instance_type        = "${var.rds.db_instance_type}"
  db_license_model        = "${var.rds.db_license_model}"
  sg_id_rds               = "${module.security_groups.sg_rds_id}"
  db_parameter_group_name = "${var.rds.db_parameter_group_name}"
  db_multiAZ		  = "0"
  db_public_accessible    = "true"
}