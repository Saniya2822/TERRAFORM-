resource "aws_lb" "this_aws_alb" {
  name               = var.alb.name
  load_balancer_type = var.alb.load_balancer_type
  security_groups    = [var.alb_security_group]
  subnets            = var.alb_public_subnet
}