resource "aws_lb" "app" {
  name               = "${local.name}-alb"
  load_balancer_type = "application"

  security_groups            = [module.alb_sg.security_group_id]
  subnets                    = module.vpc.public_subnets
  idle_timeout               = 60
  enable_deletion_protection = false

  tags = local.tags
}

resource "aws_lb_target_group" "app_tg" {
  name = "${local.name}-app-tg"
  vpc_id = module.vpc.vpc_id
  port = 80
  protocol = "HTTP"
  target_type = "instance"

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200-302"
    interval = 15
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
  }

  tags = local.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}