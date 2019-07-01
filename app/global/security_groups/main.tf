#########
#########
# Security group for rds
resource "aws_security_group" "sg_rds" {
  name        = "sg.${terraform.workspace}.rds"
  description = "Security group for RDS"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "sg.${terraform.workspace}.rds"
    env  = "${terraform.workspace}"
  }
}

# Access rule for outbound rds
resource "aws_security_group_rule" "allow_outbound_connection_for_rdssg" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_rds.id}"
}

