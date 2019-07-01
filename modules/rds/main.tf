# DB Subnet group
resource "aws_db_subnet_group" "rds-subgroup" {
  name        = "subnet-group-${terraform.workspace}-${var.db_name}"
  description = "Subnet Group for ${var.db_name} RDS in ${terraform.workspace} env"
  subnet_ids  = "${split(",", var.subnet_ids)}"
}

# RDS with existing db parameter group
resource "aws_db_instance" "new_rds" {
  count                   = "${length(compact(split(",", var.db_parameter_group_name))) * signum(length(compact(split(",", var.kms_key_arn))) - 1) * - 1}"
  identifier              = "rds-${terraform.workspace}-${var.client_name}-${var.db_name}"
  allocated_storage       = "${var.db_size}"
  engine                  = "${var.db_engine}"
  engine_version          = "${var.db_engine_version}"
  license_model           = "${var.db_license_model}"
  instance_class          = "${var.db_instance_type}"
  storage_type            = "${var.db_storage_type}"
  name                    = "${element(split("-",var.db_engine),0) == "sqlserver" ? "" : upper(var.db_name)}"
  username                = "${var.db_username}"
  password                = "${var.db_password}"
  multi_az                = "${var.db_multiAZ}"
  apply_immediately       = true
  backup_retention_period = "${var.db_backup_period}"
  vpc_security_group_ids  = ["${var.sg_id_rds}"]
  publicly_accessible     = "${var.db_public_accessible}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds-subgroup.name}"
  parameter_group_name    = "${var.db_parameter_group_name}"
  storage_encrypted       = "${var.storage_encrypted}"
  tags                    = "${merge(map("env", var.env), var.tags)}"
}

#DB Parameter Group
resource "aws_db_parameter_group" "new_parameter_group" {
  count  = "${length(compact(split(",", var.new_parameter_group_name)))}"
  name   = "${var.new_parameter_group_name}"
  family = "${var.new_parameter_group_family}"
   
  #If you configure variable parameter like a list: parameter.0: expected object, got string. Ignoring variable:
  lifecycle {
    ignore_changes = ["parameter"]
  }
}
