
module "webops_ecr_scan_repos_s3_bucket" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.1"

  team_name              = "cloudplatform"
  business-unit          = "webops"
  application            = "cloud-platform-terraform-s3-bucket"
  is-production          = "false"
  environment-name       = "development"
  infrastructure-support = "platform@digtal.justice.gov.uk"

  providers = {
    aws = aws.london
  }
}
