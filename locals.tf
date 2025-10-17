locals {
  region = "us-east-1"
  name   = "multi-az-load-balancer"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]

  tags = {
    Project   = "multi-az-load-balancer"
    Terraform = true
  }
}