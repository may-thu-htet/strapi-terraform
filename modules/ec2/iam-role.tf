# Create the AWS IAM role. 
resource "aws_iam_role" "this" {
  name               = local.ec2_iam_role_name
  description        = data.aws_iam_policy.ec2_ssm.description
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

# Attaches the policy to the IAM role
resource "aws_iam_policy_attachment" "this" {
  name       = local.ec2_iam_role_name
  roles      = [aws_iam_role.this.name]
  policy_arn = data.aws_iam_policy.ec2_ssm.arn
}

# Create AWS IAM instance profile
# Attach the role to the instance profile
resource "aws_iam_instance_profile" "this" {
  name = local.ec2_iam_role_name
  role = aws_iam_role.this.name
}

locals {
  ec2_iam_role_name = "ec2-ssm-s3-role"
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ec2_ssm" {
  name = "AmazonEC2RoleforSSM"
}
