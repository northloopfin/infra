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


resource "aws_security_group" "sg_frontend" {
  name        = "sg.${terraform.workspace}.${var.frontend}"
  description = "Security group for ${var.frontend}"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "sg.${var.env}.${var.frontend}"
    env  = "${var.env}"
  }
}

##################
## ALB
##################
# Security group for alb frontend
resource "aws_security_group" "sg_alb_frontend" {
  name        = "sg.${terraform.workspace}.alb_${var.frontend}"
  description = "Security group for ALB ${var.frontend}"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "sg.${terraform.workspace}.alb_${var.frontend}"
    env  = "${terraform.workspace}"
  }
}

# Access rule for outbound alb 
resource "aws_security_group_rule" "allow_outbound_connection_for_albfrontendsg" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_alb_frontend.id}"
}

resource "aws_security_group_rule" "allow_connection_on_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_alb_frontend.id}"
}

resource "aws_security_group_rule" "allow_connection_on_alb_https_frontend" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg_alb_frontend.id}"
}

