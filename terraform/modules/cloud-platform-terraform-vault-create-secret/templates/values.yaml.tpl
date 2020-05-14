# Default values for vault-insert-secret.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: ministryofjustice/cloud-platform-tools
  pullPolicy: IfNotPresent
