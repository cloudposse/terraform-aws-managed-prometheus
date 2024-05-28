data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

module "managed_prometheus" {
  source = "../.."

  allowed_account_id = data.aws_caller_identity.current.account_id
  scraper_deployed   = true
  vpc_id             = data.aws_vpc.default.id

  context = module.this.context
}

