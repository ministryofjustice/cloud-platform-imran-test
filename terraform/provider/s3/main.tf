terraform {
  backend "s3" {
    bucket = "dev-imran-1-tfstate-vault"
    key    = "dev-imran-1-tfstate-vault/terraform-demo.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-1"
}

# To be use in case the resources need to be created in London
provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

# To be use in case the resources need to be created in Ireland
provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

