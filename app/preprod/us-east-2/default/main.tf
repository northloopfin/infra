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

module "alb" {
  source                    = "../../../../modules/alb"
  vpc_id                    = "${module.vpc.vpc_id}"
  env                       = "${var.general.env}"
  alb_name                  = "${var.alb.alb_name}"
  subnet_ids                = "${split(",", module.subnets.public_ids)}"
  sg_ids                    = "${split(",", module.security_groups.sg_alb_id)}"
  alb_tg_protocol           = "${var.alb.alb_target_group_protocol}"
  alb_tg_port               = "${var.alb.alb_target_group_port}"
  normal_listeners_port     = "${split(",", var.alb.normal_listeners_port)}"
  normal_listeners_protocol = "${split(",", var.alb.normal_listeners_protocol)}"
//  listener_ssl_certificate  = "${var.alb.alb_ssl_certificate}"
//  secure_listeners_port     = "${split(",", var.alb.secure_listeners_port)}"  
//  secure_listeners_protocol = "${split(",", var.alb.secure_listeners_protocol)}" 
//  listener_ssl_policy       = "${var.alb.ssl_policy}" 
  alb_tg_hc_path            = "${var.alb.health_check_path}"
}


/*module "autoscaling" {
  source      		= ""
  ami         		= "${var.autoscaling.ami}"
  app_name    		= "${var.autoscaling.app_name}"
  env         		= "${var.general.env}"
  aws_keypair 		= "${var.general.key_pair}"
  sg_app      		= "${module.securitygroups.sg_frontend_id}"
  #alb_target_group 	= "${module.alb.alb_target_group_arn}"    #Issue Terraform related to the variables passed between two modules with count
  alb_target_group 	= "arn:aws:elasticloadbalancing:ap-northeast-1:403437318421:targetgroup/alb-tg-prod-magento-frontend/35842ad0cfd01d8d"
  subnet_ids 		= "${module.subnets.public_ids}"
  instance_app_iam 	= "${module.iam.iam_instance_frontend_name}"
  instance_type    	= "${var.autoscaling.instance_type}"
  scaling_adjustment_scaleup = "${var.autoscaling.scaling_adjustment_scaleup}"
  period		= "${var.autoscaling.period}"
  evaluation_periods	= "${var.autoscaling.evaluation_periods}"
}*/