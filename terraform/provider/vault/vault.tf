provider "vault" {
 address = "https://vault.apps.imran-v.cloud-platform.service.justice.gov.uk"
 token = ""
}

resource "vault_generic_secret" "s3-webops" {
  path = "secret/s3-webops"

  data_json = <<EOT
{
  "access_key":   "sad422",
  "secrert_key": "23q42q"
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
