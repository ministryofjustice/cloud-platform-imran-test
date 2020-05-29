
module "opa" {
  source = "/Users/imranawan/projects/moj/modules/cloud-platform-terraform-opa"
  cluster_domain_name = "*.test.rancher-eks.cloud-platform.service.justice.gov.uk"
  enable_invalid_hostname_policy = terraform.workspace == local.live_workspace ? false : true
}



