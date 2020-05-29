module "webops_ecr_scan_repos_s3_bucket" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.1"
    
  team_name              = "cloudplatform"
  business-unit          = "webops"
  application            = "cloud-platform-terraform-s3-bucket-ecr-scan-slack"
  is-production          = "false"
  environment-name       = "development"
  infrastructure-support = "platform@digtal.justice.gov.uk"

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_namespace" "ecr_slack_token" {
  metadata {
    annotations = {
      name = "webops-ecr-scan-slack"
    }
    name = "ecr-slack-token"
  }
}


resource "kubernetes_secret" "webops_ecr_scan_repos_s3_bucket" {
  metadata {
    name      = "ecr-slack-token-s3-bucket-output"
    namespace = "ecr-slack-token"
  }

  data = {
    access_key_id     = module.webops_ecr_scan_repos_s3_bucket.access_key_id
    secret_access_key = module.webops_ecr_scan_repos_s3_bucket.secret_access_key
    bucket_arn        = module.webops_ecr_scan_repos_s3_bucket.bucket_arn
    bucket_name       = module.webops_ecr_scan_repos_s3_bucket.bucket_name
  }
}

module "webops_ecr_scan_slack_lambda" {

  source = "/Users/imranawan/projects/moj/modules/cloud-platform-terraform-lambda"
  policy_file              = file("policy-lambda.json")
  function_name            = "ecr-lambda-function"
  handler                  = "lambda_ecr-scan-slack.lambda_handler"
  lambda_role_name         = "lambda-role-ecr"
  lambda_policy_name       = "lambda-pol-ecr"
  lambda_zip_source_location = "resources/ecr/lambda-zip"
  lambda_zip_output_location = "resources/ecr/lambda-function.zip"

  providers = {
    aws = aws.london
  }
}
