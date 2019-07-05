resource "aws_alb" "new_alb" {
  name            = "alb-${terraform.workspace}-${var.alb_name}"
  internal        = "${var.internal}"
  subnets         = "${var.subnet_ids}"
  security_groups = "${var.sg_ids}"

  idle_timeout = "${var.idle_timeout}"

  /*access_logs {
    bucket   = "${var.alb_access_logs_bucket}"
    prefix   = "${var.alb_access_logs_prefix}"
    enabled  = "${var.alb_access_logs_enabled}"
  }*/

  tags = "${merge(map("env", var.env), var.tags)}"
}

resource "aws_alb_target_group" "new_target_group" {
  name     = "alb-tg-${var.env}-${var.alb_name}"
  port     = "${var.alb_tg_port}"
  protocol = "${upper(var.alb_tg_protocol)}"
  vpc_id   = "${var.vpc_id}"

  health_check  {
    interval            = "${var.alb_tg_hc_interval}"
    path                = "${var.alb_tg_hc_path}"
    port                = "${var.alb_tg_hc_port}"
    protocol            = "${upper(var.alb_tg_hc_protocol)}"
    timeout             = "${var.alb_tg_hc_timeout}"
    healthy_threshold   = "${var.alb_tg_hc_healthy}"
    unhealthy_threshold = "${var.alb_tg_hc_unhealthy}"
    matcher             = "${var.healthy_status_code}"
  }
}

resource "aws_alb_listener" "new_listener_secure" {
  count             = "${length(var.secure_listeners_port)}"
  load_balancer_arn = "${aws_alb.new_alb.arn}"
  port              = "${element(var.secure_listeners_port, count.index)}"
  protocol          = "${upper(element(var.secure_listeners_protocol, count.index))}"
  ssl_policy        = "${var.listener_ssl_policy}"
  certificate_arn   = "${var.listener_ssl_certificate}"

  default_action {
    target_group_arn = "${aws_alb_target_group.new_target_group.arn}"
    type             = "${var.secure_listener_action_type}"
  }
}

resource "aws_alb_listener" "new_listener" {
  count             = "${length(var.normal_listeners_port)}"
  load_balancer_arn = "${aws_alb.new_alb.arn}"
  port              = "${element(var.normal_listeners_port, count.index)}"
  protocol          = "${upper(element(var.normal_listeners_protocol, count.index))}"

  default_action {
    target_group_arn = "${aws_alb_target_group.new_target_group.arn}"
    type             = "${var.normal_listener_action_type}"
  }
}