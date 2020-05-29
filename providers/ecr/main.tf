terraform {
  backend "s3" {
    bucket  = "cloud-platform-terraform-state"
    region  = "eu-west-1"
    profile = "moj-cp"
    workspace_key_prefix = "cloud-platform-components/imran-test2"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-2"
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

