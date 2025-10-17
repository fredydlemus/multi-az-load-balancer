module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-alb-sg"
  description = "Security group for the ALB"

  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      description = "All ingress HTTP traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      description = "All egress HTTP traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}