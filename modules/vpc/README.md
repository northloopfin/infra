# Description

Template to create:

* VPC
* Internet Gateway
* DHCP Option Set

Support VPC Flow Logs.

# Requierements

Terraform version >= 0.7

# main.tf configuration example
    module "vpc"{ 
       source = "git::ssh://git@bitbucket.org/claranet-es/terraform.template.vpc.git" 
       env = "${var.general.["env"]}" 
       client_name = "${var.general.["client_name"]}" 
       domain_name = "${var.general.["domain_name"]}" 
       domain_name_servers = "${var.general.["domain_name_servers"]}" 
       aws_region = "${var.aws_region}" 
       cidr = "${var.network.["cidr_vpc"]}" 
    }
       
# variables.tf configuration example

    provider "aws" {
      region = "${var.aws_region}" 
      }
      
    variable "general" { 
      description = "General variables" 
      default { 
         env = "prod"
         client_name = "client1" 
         domain_name = "client1.com" 
         domain_name_servers = "127.0.0.1,AmazonProvidedDNS" 
         } 
    }
    variable "network" { 
      description = "Network variables"
      default { 
        cidr_vpc = "10.200.0.0/16" 
        } 
    }

# Additional available parameters

There are more available parameters which are pre defined in this template, but if you want you can change them by passing the new value in the main.tf.

* "vpc_flow_logs": Boolean to activate the VPC Flow Logs feature. Set the value to "1" to activate it(default value: "0").
* "flow_log_traffic_type": Define the type of traffic to capture when the vpc_flow_logs variable is set to "true". Possible values are "ALL"/"REJECT"/"ACCEPT"(default value: "ALL")


# Output variables

* vpc_id = XXXXX     The VPC ID created
* gw_id = XXXXXX     The Gateway ID created
