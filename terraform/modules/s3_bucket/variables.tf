variable "aws_account_id" {
  type        = "string"
  description = "account id used as the s3's bucket prinicpal"
  default     = "754256621582"
}

variable "project_name" {
  description = "name of the project"
}

variable "environment" {
  description = "the environment this bucket is used for"
  default = "dev-"
}

variable "namespace_prefix" {
  type        = "string"
  description = "a prefix for the namespace"
  default     = ""
}

locals {
  namespace = "${
    var.namespace_prefix == "" ?
    format("%s%s", var.environment, var.project_name) :
    format("%s-%s-%s", var.namespace_prefix, var.environment, var.project_name)
  }"
}

variable "bucket_purpose" {
  type        = "string"
  description = "purpose for the bucket"
}


variable "force_destroy_s3_bucket" {
  type        = "string"
  description = "Flag that marks the bucket as destroy-able for terraform, even if the bucket is not empty."
  default     = false
}
