/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */

module "webops_imran_ecr_credentials" {
  #source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=4.0"
  source = "/Users/imranawan/projects/moj/cloud-platform-terraform-ecr-credentials"
  repo_name = "webops-imran-${terraform.workspace}"
  team_name = "webops-imran"
  # aws_region = "eu-west-2"     # This input is deprecated from version 3.2 of this module

  providers = {
    aws = aws.london
  }
}
 
resource "kubernetes_secret" "webops_imran_ecr_credentials" {
  metadata {
    name      = "webops-imran-ecr-credentials-output-${terraform.workspace}"
    namespace = "ecr"
  }

  data = {
    access_key_id     = module.webops_imran_ecr_credentials.access_key_id
    secret_access_key = module.webops_imran_ecr_credentials.secret_access_key
    repo_arn          = module.webops_imran_ecr_credentials.repo_arn
    repo_url          = module.webops_imran_ecr_credentials.repo_url
  }
}


module "webops_ecr_scan_slack_lambda" {

  source                     = "/Users/imranawan/projects/moj/modules/cloud-platform-terraform-lambda"
  policy_file                = file("resources/policy-lambda-ecr-scan-slack.json")
  function_name              = "ecr-scan-results-to-slack-${terraform.workspace}"
  handler                    = "lambda_ecr-scan-slack.lambda_handler"
  lambda_role_name           = "lambda-role-ecr-scan-slack-${terraform.workspace}"
  lambda_policy_name         = "lambda-pol-ecr-scan-slack-${terraform.workspace}"
  lambda_zip_source_location = "resources/lambda-ecr-scan-slack/lambda-function"
  lambda_zip_output_location = "resources/lambda-ecr-scan-slack/lambda-function-ecr-scan-slack.zip"
  slack_token                = var.slack_token
  ecr_repo                   = var.ecr_repo
  
  
  providers = {
    aws = aws.london
  }
}



