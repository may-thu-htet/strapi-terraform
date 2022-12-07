output "availability_zones" {
  value = var.availability_zones
}

output "public_dns" {
  value = aws_instance.ec2.public_dns
}
