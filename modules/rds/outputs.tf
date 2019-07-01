output "rds-simple-address" {
  value = "${aws_db_instance.new_rds.address}"
}

output "rds-simple-id" {
  value = "${aws_db_instance.new_rds.id}"
}

output "rds-simple-kms-address" {
  value = "${aws_db_instance.new_rds_with_kms.address}"
}

output "rds-simple-kms-id" {
  value = "${aws_db_instance.new_rds_with_kms.id}"
}

output "rds-with-new-pg-address" {
  value = "${aws_db_instance.new_rds_pg.address}"
}

output "rds-with-new-pg-id" {
  value = "${aws_db_instance.new_rds_pg.id}"
}

output "rds-with-new-pg-kms-address" {
  value = "${aws_db_instance.new_rds_pg_with_kms.address}"
}

output "rds-with-new-pg-kms-id" {
  value = "${aws_db_instance.new_rds_pg_with_kms.id}"
}
