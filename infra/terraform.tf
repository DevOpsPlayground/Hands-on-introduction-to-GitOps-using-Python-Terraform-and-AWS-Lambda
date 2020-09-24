
/* TODO: change this */

terraform {
  backend "s3" {
    bucket = "dpg-gitops-state"
    region = "eu-west-1"
  }
}
