resource "aws_instance" "ec2" {
  # count                       = length(var.availability_zones)
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.ec2_sg_id]
  availability_zone           = var.ec2_subnets[0].availability_zone //for multiple ec2->use count.index instead of 0
  subnet_id                   = var.ec2_subnets[0].id
  iam_instance_profile        = aws_iam_instance_profile.this.name
  key_name                    = aws_key_pair.ec2-access-key.key_name
  associate_public_ip_address = true
  user_data_base64 = base64encode("${templatefile("${path.module}/init/script.sh", {
    app_name          = var.prefix,
    cwd               = "/home/ubuntu/strapi-test/my-project"
    host              = var.db_endpoint,
    port              = var.db_port,
    db_name           = var.db_name
    db_username       = var.db_username,
    db_password       = var.db_password
    s3_bucket         = var.s3_bucket,
    aws_access_key    = var.aws_access_key,
    aws_access_secret = var.aws_access_secret
  })}")
  tags = {
    Name = "${var.prefix}"
  }

  depends_on = [
    var.db_endpoint
  ]
}

resource "aws_eip" "this" {
  instance = aws_instance.ec2.id
  vpc      = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
