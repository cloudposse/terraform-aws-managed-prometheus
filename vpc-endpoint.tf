locals {
  vpc_endpoint_enabled = local.enabled && length(var.vpc_id) > 0
}

data "aws_region" "current" {}

module "vpc_endpoint_policy" {
  source  = "cloudposse/iam-policy/aws"
  version = "v2.0.1"

  enabled = local.vpc_endpoint_enabled

  iam_policy = [{
    statements = [
      {
        effect    = "Allow"
        actions   = ["aps:*"]
        resources = ["*"]
        conditions = [
          {
            test     = "StringEquals"
            variable = "aws:SourceVpc"
            values   = [var.vpc_id]
          }
        ]
      }
    ]
  }]

  context = module.this.context
}

resource "aws_vpc_endpoint" "prometheus" {
  count = local.vpc_endpoint_enabled ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = format("com.amazonaws.%s.aps-workspaces", data.aws_region.current.name)
  vpc_endpoint_type = "Interface"

  policy = module.vpc_endpoint_policy.json

  tags = module.this.tags
}
