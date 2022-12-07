resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}"
  }
}
