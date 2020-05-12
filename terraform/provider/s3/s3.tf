
module "webops_vault_s3_bucket" {
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

resource "kubernetes_secret" "vault_webops_s3_bucket" {
  metadata {
    name      = "vault-webops-s3-bucket-output"
    namespace = "webops"
  }

  data = {
    access_key_id     = module.webops_vault_s3_bucket.access_key_id
    secret_access_key = module.webops_vault_s3_bucket.secret_access_key
    bucket_arn        = module.webops_vault_s3_bucket.bucket_arn
    bucket_name       = module.webops_vault_s3_bucket.bucket_name
  }
}

