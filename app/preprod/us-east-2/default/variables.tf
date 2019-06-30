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