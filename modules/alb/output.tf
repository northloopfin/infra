output "alb_endpoint" {
  value = "${aws_alb.new_alb.dns_name}"
}

output "alb_arn" {
  value = "${aws_alb.new_alb.arn}"
}

output "alb_arn_suffix" {
  value = "${aws_alb.new_alb.arn_suffix}"
}

output "alb_id" {
  value = "${aws_alb.new_alb.id}"
}

output "alb_zone_id" {
  value = "${aws_alb.new_alb.zone_id}"
}


output "alb_target_group_id" {
  value = "${aws_alb_target_group.new_target_group.id}"
}

output "alb_target_group_arn" {
  value = "${aws_alb_target_group.new_target_group.arn}"
}

output "alb_target_group_arn_suffix" {
  value = "${aws_alb_target_group.new_target_group.arn_suffix}"
}