variable "cidr" {
  description = "CIDR range for VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "ec2 instance type"
  default     = "t3.small"
}

variable "rds_instance_type" {
  description = "rds instance type"
  default     = "db.t4g.micro"
}

variable "no_of_availability_zones" {
  description = "Desire number of availability zones"
  default     = 2
}
variable "services" {
  description = "AWS Services"
  default     = ["ec2-pub", "rds"]
}

variable "allow_access_to_elb_cidr_block" {
  description = "IPs to allow access to elb"
  default     = ["0.0.0.0/32"]
}

variable "allow_access_to_ec2_cidr_block" {
  description = "IPs to allow ssh into ec2"
  default     = ["133.32.133.111/32", "134.238.5.161/32"]
}

variable "allow_access_to_rds_cidr_block" {
  description = "IPs to allow access to pgadmin on ec2"
  default     = ["133.32.133.111/32", "134.238.5.161/32"]
}

variable "aws_access_key" {
  #   sensitive = true
}
variable "aws_access_secret" {
  #   sensitive = true
}
