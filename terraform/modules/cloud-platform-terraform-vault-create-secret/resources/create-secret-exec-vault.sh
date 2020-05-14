#!/bin/sh

cat <<EOF > /home/vault/aws_s3_webops_pol.hcl
path "secret*" {
  capabilities = ["read"]
}
EOF

vault policy write aws_s3_webops_pol /home/vault/aws_s3_webops_pol.hcl

vault write auth/kubernetes/role/webops-role \
   bound_service_account_names="${serviceaccount}" \
   bound_service_account_namespaces="${namespace}" \
   policies=aws_s3_webops_pol \
   ttl=1h

vault kv put secret/s3-webops aws_access_key="${aws_access_key}" aws_secret_id="${aws_secret_id}"