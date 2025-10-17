terraform {
  backend "s3" {
    bucket = ""
    key    = "terraform.tfstate"
    region = local.region
  }
}