variable "prefix" {
  description = "Prefix for resource name tag"
}

variable "availability_zones" {
}

variable "vpc_id" {
  description = "vpc id"
}

variable "elb_sg_id" {
  description = "elb security group id"
}

variable "ec2_sg_id" {
  description = "ec2 security group id"
}

variable "ec2_subnets" {
  description = "ec2 subnet for various AZs"
}

variable "instance_type" {
  description = "ec2 instance type"
}

variable "db_endpoint" {
}
variable "db_port" {
}
variable "db_name" {
}
variable "db_username" {
}
variable "db_password" {
  sensitive = true
}
variable "s3_bucket" {
}
variable "aws_access_key" {
  sensitive = true
}
variable "aws_access_secret" {
  sensitive = true
}
