output "db_endpoint" {
  value = module.db.db_instance_endpoint
}
output "db_name" {
  value = module.db.db_instance_name
}
output "db_password" {
  value     = module.db.db_instance_password
  sensitive = true
}
output "db_username" {
  value = module.db.db_instance_username
}
output "db_port" {
  value = module.db.db_instance_port
}
