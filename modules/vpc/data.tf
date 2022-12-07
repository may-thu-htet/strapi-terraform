data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_iam_policy" "ec2_ssm" {
  name = "AmazonEC2RoleforSSM"
}
