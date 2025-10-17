resource "aws_lb" "app" {
  name               = "${local.name}-alb"
  load_balancer_type = "application"

  security_groups            = [module.alb_sg.security_group_id]
  subnets                    = module.vpc.public_subnets
  idle_timeout               = 60
  enable_deletion_protection = false

  tags = local.tags
}