locals {
  # AWSの名前付きプロファイルがあればプロフィールにする方が安心です。
  # https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-profiles.html
  profile = "default"

  # AWSの名前付きプロファイルがない場合のみアクセスキーを記入してください。
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"

  region = "ap-northeast-1"

  project_name = "strapi"
  environment  = "stage"
}

provider "aws" {
  profile = local.profile
  region  = local.region
}

module "common" {
  source                         = "./modules"
  prefix                         = "${local.project_name}-${local.environment}"
  no_of_availability_zones       = var.no_of_availability_zones
  cidr                           = var.cidr
  services                       = var.services
  instance_type                  = var.instance_type
  rds_instance_type              = var.rds_instance_type
  allow_access_to_ec2_cidr_block = var.allow_access_to_ec2_cidr_block
  allow_access_to_rds_cidr_block = var.allow_access_to_rds_cidr_block

  # @strapi/provider-upload-aws-s3のためS3のみアクセス出来るIAMユーザーのキー
  aws_access_key    = var.aws_access_key
  aws_access_secret = var.aws_access_secret
}
