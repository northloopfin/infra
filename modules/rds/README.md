# Description

Template to create an RDS Database with a new RDS subnet group.
Support also the creation of a parameter group.

# Requierements

Terraform version >= 0.7

# main.tf configuration example
    module "rds"{ 
       source = "git::ssh://git@bitbucket.org/claranet-es/terraform.template.rds.git" 
       env = "${var.general.["env"]}" 
       client_name = "${var.general.["client_name"]}" 
       subnet_ids = "${module.subnets.private_ids}"
       db_name = "${var.rds.["db_name"]}"
       db_username = "${var.rds.["db_login"]}"
       db_password = "${var.rds.["db_password"]}"
       db_size = "${var.rds.["db_size"]}"
       db_engine = "${var.rds.["db_engine"]}"
       db_engine_version = "${var.rds.["db_engine_version"]}"
       db_instance_type = "${var.rds.["db_instance_type"]}"
       db_parameter_group_name = "${var.rds.["db_parameter_group_name"]}"       #Only if you want to utilize an existing parameter group. Cannot be used with new_parameter_group_name and new_parameter_group_family
       sg_id_rds = "${module.securitygroups.sg_rds}"
       new_parameter_group_name = "${var.rds.["new_pg_name"]}"   #Only if you want to create a new db parameter group. Cannot be used with db_parameter_group_name
       new_parameter_group_family = "${var.rds.["new_pg_family"]}"  #Only if you want to create a new db parameter group. Cannot be used with db_parameter_group_name
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
         } 
    }

    #Example for a creation with an existing parameter group
    variable "rds" { 
      description = "RDS variables"
      default { 
        db_name = "testDB" 
        db_login = "test"
        db_password = "azazsfdsdeze"  #8 characters minimum!
        db_size = "10"    #Dabase size in GB
        db_engine = "mysql"
        db_engine_version = "5.6.27"
        db_parameter_group_name = "default.mysql5.6"   #Name of the existing parameter group
        db_instance_type = "db.t1.micro"
	new_pg_name = "rds-mysql"            #Only if you want to create a new db parameter group
	new_pg_family = "mysql5.6"           #Only if you want to create a new db parameter group
        } 
    }



# Additional available parameters

There are more available parameters which are pre defined in this template, but if you want you can change them by passing the new value in the main.tf.

* "db_parameter_group_name": The name of a database parameter group which already exists.Cannot be used with new_parameter_group_name and new_parameter_group_family (default value: "")
* "db_license_model": The license model for this new database(default value: "general-public-license")
* "db_storage_type": The type of storage. Available values are "standard"/"io1"/"gp2"(default value: "standard")
* "db_multiAZ": Boolean to define if the new DB is multiAZ(default value: "1" (activate))
* "db_backup_period": Retention time of each backup(default value: "15")
* "new_parameter_group_name": The name of a new parameter group if you want to create one and assign it to the new DB. Cannot be used with db_parameter_group_name(default value: "")
* "new_parameter_group_family": The family(ex: mysql56) of the new parameter group. Cannot be used with db_parameter_group_name(default value: "")
* "storage_encrypted": Boolean to define if you wan't to encrypt the database disks(default value:"false")
* "kms_key_arn": ARN of the KMS to use to encrypt the database disks. Requiered to set storage_encrypted to true(default value: "") . Be careful there is an open issue on Terraform(https://github.com/hashicorp/terraform/issues/8259) if you are using a kms alias! To avoid terraform to recreate every time the database, pass the key arn after the initial DB creation.
* "tags": A map of tags to set on the resource more the default tags which is "env"
* "parameter": In new_parameter_group resource this variable is ignored. Issue: https://github.com/hashicorp/terraform/issues/7705.


# Output variables

* rds-simple-address = XXXXX     The endpoint of the new rds database. Only available if the created database was without KMS and with a default parameter group
* rds-simple-id = XXXXX     The endpoint of the new rds database. Only available if the created database was without KMS and with a default parameter group
* rds-simple-kms-address = XXXXX     The endpoint of the new rds database. Only available if the created database was with KMS and with a default parameter group
* rds-simple-kms-id = XXXXX     The endpoint of the new rds database. Only available if the created database was with KMS and with a default parameter group
* rds-with-new-pg-address = XXXXX     The endpoint of the new rds database. Only available if the created database was without KMS and with a custom parameter group
* rds-with-new-pg-id = XXXXX     The endpoint of the new rds database. Only available if the created database was without KMS and with a custom parameter group
* rds-with-new-pg-kms-address = XXXXX     The endpoint of the new rds database. Only available if the created database was with KMS and with a custom parameter group
* rds-with-new-pg-kms-id = XXXXX     The endpoint of the new rds database. Only available if the created database was with KMS and with a custom parameter group
