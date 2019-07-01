variable "env" {}

variable "client_name" {}

variable "subnet_ids" {}

variable "sg_id_rds" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "db_size" {}

variable "db_engine" {}

variable "db_engine_version" {}

variable "db_instance_type" {}

variable "port" {
  default = "3306"
}

variable "db_parameter_group_name" {
  default = ""
}

variable "db_license_model" {
  default = "general-public-license"
}

variable "db_storage_type" {
  default = "standard"
}

variable "db_multiAZ" {
  default = "1"
}

variable "db_public_accessible" {
  default = "true"
}

variable "db_backup_period" {
  default = "15"
}

variable "new_parameter_group_name" {
  default = ""
}

variable "new_parameter_group_family" {
  default = ""
}

variable "tags" {
  default = {}

  type = "map"
}

variable "storage_encrypted" {
  default = "false"
}

variable "kms_key_arn" {
  default = ""
}
