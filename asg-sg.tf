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