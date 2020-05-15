
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
    namespace = "vault"
  }

  data = {
    access_key_id     = module.webops_vault_s3_bucket.access_key_id
    secret_access_key = module.webops_vault_s3_bucket.secret_access_key
    bucket_arn        = module.webops_vault_s3_bucket.bucket_arn
    bucket_name       = module.webops_vault_s3_bucket.bucket_name
  }
}

provider "vault" {
 address = "https://vault.apps.imran-v.cloud-platform.service.justice.gov.uk"
 token = var.vault_token
}

resource "vault_generic_secret" "s3-webops" {
  path = "secret/s3-webops"

  data_json = <<EOT
{
  "aws_access_key": "${module.webops_vault_s3_bucket.access_key_id}",
  "aws_secret_id": "${module.webops_vault_s3_bucket.secret_access_key}"
}
EOT
}

resource "vault_policy" "s3-webops-pol" {
  name = "s3-webops-pol"

  policy = <<EOT
    path "secret*" {
     capabilities = ["read"]
    }
EOT
}


resource "vault_kubernetes_auth_backend_role" "webops-role" {
  backend                          = "kubernetes"
  role_name                        = "webops-role"
  bound_service_account_names      = ["aws-s3-webops"]
  bound_service_account_namespaces = ["webops"]
  token_ttl                        = 3600
  policies                         = ["s3-webops-pol"]
  audience                         = "vault"
}

