
/*
terraform {
  backend "s3" {
  }
}
*/

terraform {
  backend "s3" {
    bucket  = "cloud-platform-491790a26ee9d2082cd2c58d90b180da"
    region  = "eu-west-2"
    profile = "moj-cp"
    key = "team1/terraform.tfstate"
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


