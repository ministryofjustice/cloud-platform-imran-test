resource "helm_release" "vault_insert_secret" {
  name       = "vaultinsertsecret"
  namespace  = "vault"
  chart      = "/Users/imranawan/projects/moj/helm-charts/vault-insert-secret"
  values = [templatefile("${path.module}/templates/values.yaml.tpl", {})]
}

resource "kubernetes_config_map" "vault_insert_secret" {
  metadata {
    name      = "vault-insert-secret"
    namespace = "vault"
  }

  data = {
    aws_access_key = "*.${var.aws_access_key}"
    aws_secret_id = "*.${var.aws_secret_id}"
    namespace = "*.${var.namespace}"
    serviceaccount = "*.${var.serviceaccount}"
    "create-secret-exec-vault.sh" = "${file("${path.module}/resources/create-secret-exec-vault.sh")}"  
    }
}


