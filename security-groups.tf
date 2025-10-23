# Security group for the Application Load Balancer
# allows inbound HTTP traffic on port 80 from any source
module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-alb-sg"
  description = "Security group for the ALB"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      description = "All ingress HTTP traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      description = "All egress HTTP traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Security group for the ASG
# allows inbound HTTP traffic on port 80 only from the ALB security group
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