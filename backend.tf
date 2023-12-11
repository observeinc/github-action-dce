terraform {
  backend "s3" {
    bucket = "observe-github-dce-federation-tf-state"
    region = "us-west-2"
    key    = "github.com/observeinc/github-action-dce"
  }
}
