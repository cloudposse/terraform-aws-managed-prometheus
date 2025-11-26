locals {
  enabled = module.this.enabled

  workspace_tags = var.scraper_deployed ? merge(module.this.tags, {
    "AMPAgentlessScraper" = ""
  }) : module.this.tags
}

resource "aws_prometheus_alert_manager_definition" "this" {
  count = local.enabled && length(var.alert_manager_definition) > 0 ? 1 : 0

  workspace_id = aws_prometheus_workspace.this[0].id
  definition   = var.alert_manager_definition
}

resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = local.enabled ? { for idx, namespace in var.rule_group_namespaces : namespace.name => namespace } : {}

  name = each.value.name
  data = each.value.data

  workspace_id = aws_prometheus_workspace.this[0].id
}

resource "aws_prometheus_workspace" "this" {
  count = local.enabled ? 1 : 0

  alias = module.this.id

  tags = local.workspace_tags
}
