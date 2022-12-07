variable "prefix" {
  description = "Prefix for resource name tag"
}

variable "rds_instance_type" {
  description = "rds instance type"
}
variable "db_subnet_group_name" {
  description = "database subnet group name"
}
variable "rds_sg_id" {
  description = "database security group id"
}

# variable "secrets" {
#   default = {
#     username : "postgres",
#     password : module.db.db_instance_password,
#     engine : "postgres",
#     host : module.db.db_instance_endpoint,
#     port : module.db.db_instance_port,
#     dbname : module.db.db_instance_name
#   }
#   type      = map(string)
#   sensitive = true
# }


