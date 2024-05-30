module "managed_prometheus" {
  source = "../.."

  context = module.this.context
}

