
/* TODO: change this */

terraform {
  backend "s3" {
    bucket = "dpg-gitops-state"
    key    = "gitops_<USERNAME>.tfstate"
    region = "eu-west-1"
  }
}
