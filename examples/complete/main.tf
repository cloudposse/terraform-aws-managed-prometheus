# For testing, use the current account
data "aws_caller_identity" "current" {}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.0.0"

  ipv4_primary_cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "managed_prometheus" {
  source = "../.."

  allowed_account_id = data.aws_caller_identity.current.account_id
  scraper_deployed   = true
  vpc_id             = module.vpc.vpc_id

  context = module.this.context
}

