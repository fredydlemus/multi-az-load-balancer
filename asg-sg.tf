# Security group for the ASG
resource "aws_security_group" "asg_sg" {
  name        = "${local.name}-asg-sg"
  description = "Security group for the ASG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "HTTP only from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.alb_sg.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_autoscaling_policy" "cpu_tgt" {
  name                   = "${local-name}-cpu50"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name

  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}