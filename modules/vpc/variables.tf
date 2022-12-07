variable "prefix" {
  description = "Prefix for resource name tag"
}
variable "cidr" {
  description = "CIDR range for VPC"
}

variable "allow_access_to_ec2_cidr_block" {
  description = "IPs to allow ssh into ec2"
}

variable "allow_access_to_rds_cidr_block" {
  description = "IPs to allow access to pgadmin on ec2"
}

variable "no_of_availability_zones" {

}

variable "services" {
  description = "AWS Services"
}
