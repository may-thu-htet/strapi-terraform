resource "aws_key_pair" "ec2-access-key" {
  key_name   = "${var.prefix}-ec2-access-key"
  public_key = file("${path.module}/keys/public-key.pub")
}
