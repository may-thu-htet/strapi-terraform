module "elb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${var.prefix}-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = [var.ec2_subnets[0].id, var.ec2_subnets[1].id]
  security_groups = [var.elb_sg_id]

  target_groups = [
    {
      name_prefix      = "strap-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "${aws_instance.ec2.id}"
          port      = 1337
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name = "${var.prefix}"
  }
}
