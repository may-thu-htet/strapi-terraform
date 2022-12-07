variable "prefix" {
  description = "Prefix for resource name tag"
}
variable "cidr" {
  description = "CIDR range for VPC"
}

variable "instance_type" {
  description = "ec2 instance type"
}
variable "rds_instance_type" {
  description = "rds instance type"
}

variable "no_of_availability_zones" {
  description = "Desire number of availability zones"
}
variable "services" {
  description = "AWS Services"
}

variable "allow_access_to_ec2_cidr_block" {
  description = "IPs to allow ssh into ec2"
}

variable "allow_access_to_rds_cidr_block" {
  description = "IPs to allow access to pgadmin on ec2"
}

variable "aws_access_key" {
  sensitive = true
}
variable "aws_access_secret" {
  sensitive = true
}

