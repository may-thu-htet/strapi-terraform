module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.prefix}-rds-instance"

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "14.5"
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"         # DB option group
  instance_class       = var.rds_instance_type

  allocated_storage     = 10
  max_allocated_storage = 40

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name                = "strapi"
  username               = "postgres"
  create_random_password = true
  port                   = 5432

  multi_az               = false
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.rds_sg_id]

  deletion_protection = false

  parameters = [
    {
      name  = "timezone"
      value = "Asia/Tokyo"
    }
  ]

  tags = {
    Name = "${var.prefix}"
  }
}

# locals {
#   secrets = {
#     username : "postgres",
#     password : module.db.db_instance_password,
#     engine : "postgres",
#     host : module.db.db_instance_endpoint,
#     port : module.db.db_instance_port,
#     dbname : module.db.db_instance_name
#   }
# }

# resource "aws_secretsmanager_secret" "secret" {
#   description = "${var.prefix}-secretsmanager-secret-database"
#   name        = "${var.prefix}-secretsmanager-secret-database-2022-12-04-1211"
# }

# resource "aws_secretsmanager_secret_version" "secret" {
#   secret_id     = aws_secretsmanager_secret.secret.id
#   secret_string = jsonencode(local.secrets)
# }
