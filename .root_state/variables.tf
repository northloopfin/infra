variable "aws_region" {
  description = "AWS region for the global root state."
}

variable "bucket_policy" {
  description = "Optional bucket policy (required to store state in cross account usecases)."
  default     = ""
}