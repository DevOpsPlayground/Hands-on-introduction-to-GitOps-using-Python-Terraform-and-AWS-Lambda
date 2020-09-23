variable "environment" {
  description = "The environment which we are deploying to TEST|PROD"
}

variable "username" {
  description = "Your unique username provided with your Playground details."
}

variable "project" {
  default = "dpg-gitops"
}

variable "aws_region" {
  default = "eu-west-1"
}
