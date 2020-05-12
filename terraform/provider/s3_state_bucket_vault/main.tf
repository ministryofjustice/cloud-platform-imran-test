provider "aws" {
  region  = "eu-west-2"
}

module "s3_state_bucket" {
  source = "../../modules/s3_bucket"
  project_name = "imran-1"
  bucket_purpose = "tfstate-vault"
}
