
/*
terraform {
  backend "s3" {
    bucket  = "cloud-platform-terraform-state"
    region  = "eu-west-1"
    profile = "moj-cp"
    workspace_key_prefix = "cloud-platform-components/imran-test2"
    key = "terraform.tfstate"
  }
}
*/

terraform {
  backend "s3" {
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

/*
 * When using this module through the cloud-platform-environments, the following
 * two variables are automatically supplied by the pipeline.
 *
 */

variable "cluster_name" {
}

variable "cluster_state_bucket" {
}


