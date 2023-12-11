provider "aws" {
  region = "us-west-2"
}

module "github_aws_federation" {
  source = "./tf_github_aws_federation"
  organization = "observeinc"
  repository   = "github-action-dce.git"
}
