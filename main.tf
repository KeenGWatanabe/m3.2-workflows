provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ce9g4.tfstate-backend.com" #s3 bucket name
    key    = "terraform-state-locks"  #s3 dynamodb table name
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${split("/", "${data.aws_caller_identity.current.arn}")[1]}"
  account_id  = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}