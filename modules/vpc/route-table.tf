resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.main.main_route_table_id

  tags = {
    Name = "${var.prefix}-public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-private-route-table"
  }
}

resource "aws_route_table_association" "public_subnets_association" {
  count          = length(local.public_subnets)
  subnet_id      = local.public_subnets[count.index].id
  route_table_id = aws_default_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnets_association" {
  count          = length(local.private_subnets)
  subnet_id      = local.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
