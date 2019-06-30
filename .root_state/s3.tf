resource "aws_s3_bucket" "terraform_root_state_bucket" {
  bucket = "s3.terraform.root-state.${var.aws_region}"
  acl    = "private"
  policy = "${var.bucket_policy}"

  versioning {
    enabled = true
  }

  tags = {
    Name  = "root-state"
    env   = "prod"
    Stack = "terraform"
  }
}
