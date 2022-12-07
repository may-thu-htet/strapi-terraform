resource "aws_security_group" "elb_sg" {
  name        = "${var.prefix}-elb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  # ingress {
  #   description = "Allow TLS from specified IPs"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   # cidr_blocks = var.allow_access_to_ec2_cidr_block
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "PgAdmin Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allow_access_to_ec2_cidr_block
    # cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Strapi Test Port"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = var.allow_access_to_ec2_cidr_block
    # cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # egress {
  #   from_port   = 1337
  #   to_port     = 1337
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "${var.prefix}"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.prefix}-ec2-sg"
  description = "Allow traffic from ELB and outbound access to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_access_to_ec2_cidr_block
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # cidr_blocks = var.allow_access_to_ec2_cidr_block
    security_groups = [
      aws_security_group.elb_sg.id
    ]
  }
  ingress {
    from_port = 1337
    to_port   = 1337
    protocol  = "tcp"
    # cidr_blocks = var.allow_access_to_ec2_cidr_block
    security_groups = [
      aws_security_group.elb_sg.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # egress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # egress {
  #   from_port   = 1337
  #   to_port     = 1337
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # egress {
  #   from_port   = 5432
  #   to_port     = 5432
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "${var.prefix}"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "${var.prefix}-rds-sg"
  description = "Allow access from ec2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ec2_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}"
  }
}
