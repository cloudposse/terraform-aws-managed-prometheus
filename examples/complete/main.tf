data "aws_caller_identity" "current" {}

module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.2.0"
  ipv4_primary_cidr_block = "172.16.0.0/20"
  context                 = module.this.context
}

module "managed_prometheus" {
  source = "../.."

  allowed_account_id = data.aws_caller_identity.current.account_id
  scraper_deployed   = true
  vpc_id             = module.vpc.vpc_id

  context = module.this.context
}

