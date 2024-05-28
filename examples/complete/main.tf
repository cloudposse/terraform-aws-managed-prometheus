locals {
  grafana_account_id = "1234567890"
}

module "managed_prometheus" {
  source = "../.."

  allowed_account_id       = local.grafana_account_id
  scraper_deployed         = true
  vpc_id = var.vpc_id

  context = module.this.context
}

