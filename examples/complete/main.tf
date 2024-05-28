module "managed_prometheus" {
  source = "../.."

  scraper_deployed   = true
  vpc_id             = var.vpc_id
  allowed_account_id = var.grafana_account_id

  context = module.this.context
}

