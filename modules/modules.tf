module "vpc" {
  source                         = "./vpc"
  prefix                         = var.prefix
  cidr                           = var.cidr
  no_of_availability_zones       = var.no_of_availability_zones
  services                       = var.services
  allow_access_to_rds_cidr_block = var.allow_access_to_rds_cidr_block
  allow_access_to_ec2_cidr_block = var.allow_access_to_ec2_cidr_block
}

module "ec2" {
  source             = "./ec2"
  prefix             = var.prefix
  availability_zones = module.vpc.availability_zones
  vpc_id             = module.vpc.vpc_id
  elb_sg_id          = module.vpc.elb_sg_id
  ec2_sg_id          = module.vpc.ec2_sg_id
  ec2_subnets        = module.vpc.ec2_subnets
  instance_type      = var.instance_type
  db_endpoint        = trimsuffix(module.rds.db_endpoint, ":${module.rds.db_port}")
  db_port            = module.rds.db_port
  db_name            = module.rds.db_name
  db_username        = module.rds.db_username
  db_password        = module.rds.db_password
  s3_bucket          = module.s3.s3_bucket
  aws_access_key     = var.aws_access_key
  aws_access_secret  = var.aws_access_secret
}

module "rds" {
  source               = "./rds"
  prefix               = var.prefix
  rds_instance_type    = var.rds_instance_type
  db_subnet_group_name = module.vpc.db_subnet_group_name
  rds_sg_id            = module.vpc.rds_sg_id
}

module "s3" {
  source = "./s3"
  prefix = var.prefix
}
