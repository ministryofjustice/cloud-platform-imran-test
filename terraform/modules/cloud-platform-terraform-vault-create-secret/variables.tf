
variable "aws_access_key" {
  description = "access to be inserted into vault"
}

variable "aws_secret_id" {
  description = "aws secret id to be inserted into vault"
}

variable "namespace" {
  description = "namespace that is scoped for the above keys"
}

variable "serviceaccount" {
  description = "service account that is scoped for the above keys"
}

