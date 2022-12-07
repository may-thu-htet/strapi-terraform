output "availability_zones" {
  value = local.availability_zones
}

output "elb_sg_id" {
  value = aws_security_group.elb_sg.id
}
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "ec2_subnets" {
  value = [
    for subnet in aws_subnet.subnets :
    subnet if length(regexall("ec2", subnet.tags.Name)) > 0
  ]
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "rds_subnets" {
  value = [
    for subnet in aws_subnet.subnets :
    subnet if length(regexall("rds-subnet", subnet.tags.Name)) > 0
  ]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.database_subnet_group.name
}

output "vpc_id" {
  value = aws_vpc.main.id
}
