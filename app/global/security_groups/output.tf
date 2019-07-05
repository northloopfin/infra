output "sg_rds_id" {
  value = "${aws_security_group.sg_rds.id}"
}

output "sg_alb_id" {
  value = "${aws_security_group.sg_alb_frontend.id}"
}

output "sg_frontend_id" {
  value = "${aws_security_group.sg_frontend.id}"
}