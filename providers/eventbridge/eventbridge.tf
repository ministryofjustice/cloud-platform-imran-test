  
module "example_team_eventbridge" {
  
  source = "git::ssh://git@github.com/ministryofjustice/cloud-platform-terraform-eventbridge?ref=v1.4"
  team_name                = "example-repo"
  business-unit            = "example-bu"
  application              = "example-app"
  is-production            = "false"
  environment-name         = "development"
  infrastructure-support   = "example-team@digtal.justice.gov.uk"
  event_name               = "ecr-event-test1"
  target_id                = "lambda"
  target_arn               = "arn:aws:lambda:eu-west-2:754256621582:function:ecr-scan-slack"
  event_pattern            = file("event-pattern.json")

  providers = {
    aws = aws.london
  }
}
