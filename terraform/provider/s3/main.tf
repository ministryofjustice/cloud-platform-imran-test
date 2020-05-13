terraform {
  backend "s3" {
    bucket = "dev-imran-1-tfstate-vault"
    key    = "dev-imran-1-tfstate-vault/terraform-demo.tfstate"
    region = "eu-west-2"
  }
}

provider "vault" {
 address = "${var.vault_addr}"
 token = "${var.vault_token}"
}

data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "vault-role"
}

provider "aws" {
  region = "eu-west-1"
}

# To be use in case the resources need to be created in London
provider "aws" {
  access_key = "${data.vault_aws_access_credentials.creds.access_key}"
  secret_key = "${data.vault_aws_access_credentials.creds.secret_key}"
  alias  = "london"
  region = "${var.region}"
}

# To be use in case the resources need to be created in Ireland
provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

