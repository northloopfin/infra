variable "aws_region" {
  description = "AWS region"
}

variable "general" {
  description = "General variables"

  default = {
    env                 = "preprod"
    client_name         = "northloop"
    domain_name         = "preproduction.northloop.internal"
    domain_name_servers = "127.0.0.1,AmazonProvidedDNS"
    account_id          = "596317856130"
    key_pair            = "aws_northloop"
    key_pair_path       = "/home/raul/Documents/Claranet/aws_asv_prod.pem"
  }
}

variable "network" {
  description = "Network variables"

  default = {
    cidr_vpc             = "10.60.0.0/16"
    availablity_zones    = "a,b,c"
    public_subnets_cidr  = "10.60.0.0/24,10.60.1.0/24,10.60.2.0/24"
    private_subnets_cidr = "10.60.100.0/24,10.60.101.0/24,10.60.110.0/24"
  }
}

variable "rds" {
  description = "RDS variables"

  default = {
    db_name           = "test"
    db_login          = "test"
    db_password       = "zu4eSuT!" #8 characters minimum!
    db_size           = "20"           #Dabase size in GB
    db_engine         = "postgres"
    db_engine_version = "10.6"
    db_license_model  = "postgresql-license"
    db_parameter_group_name = "default.postgres10" #Name of the existing parameter group
    db_instance_type = "db.t2.micro"
  }
}

variable "alb" {
  description = "ALB "

  default = {
    alb_name                  = "northloop"
    alb_target_group_port     = "80"                                             #Port on which the instances will received the traffic
    alb_target_group_protocol = "HTTP"                                           #Protocol associate to the alb target group protocol
    normal_listeners_port     = "80"                                             #ALB listener(s) port. You can add multiple NO secure port listeners.
    normal_listeners_protocol = "http"
//    secure_listeners_port     = "443"                                            #ALB listener(s) port. You can add multiple secure port listeners. 
//    secure_listeners_protocol = "HTTPS"
//    alb_ssl_certificate       = "arn:aws:acm:ap-northeast-1:403437318421:certificate/0b79933b-d05d-4e03-b4d4-26f6599be7da"
    health_check_path         = "/favicon.ico"
//    ssl_policy		      = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}

