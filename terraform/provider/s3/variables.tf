variable "vault_addr" {
  description = "vault address"
  default = "https://vault.apps.imran-v.cloud-platform.service.justice.gov.uk"
}


variable "vault_token" {
  description = "token to access vault"
}

variable "region" {
  description = "aws region"
  default = "eu-west-2"
}