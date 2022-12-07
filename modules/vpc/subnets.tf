resource "aws_subnet" "subnets" {
  # We need a map to use for_each, so we convert our list into a map by adding a unique key:
  for_each          = { for entry in local.services_per_az : "${entry.service}.${entry.availability_zone}" => entry }
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr

  tags = {
    Name = "${var.prefix}-${each.value.service}-subnet-${each.value.availability_zone}"
  }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.prefix}-database-subnet-group"
  description = "Allowed subnets for RDS DB cluster instances"
  subnet_ids  = [local.private_subnets[0].id, local.private_subnets[1].id]
}
