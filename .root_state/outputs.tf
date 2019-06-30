output "root_state_bucket_arn" {
  value = "${aws_s3_bucket.terraform_root_state_bucket.arn}"
}

output "root_state_bucket_id" {
  value = "${aws_s3_bucket.terraform_root_state_bucket.id}"
}