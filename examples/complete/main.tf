data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  count   = var.enabled ? 1 : 0
  default = true
}

module "managed_prometheus" {
  source = "../.."

  allowed_account_id = data.aws_caller_identity.current.account_id
  scraper_deployed   = true
  vpc_id             = try(data.aws_vpc.default[0].id, "")

  context = module.this.context
}

