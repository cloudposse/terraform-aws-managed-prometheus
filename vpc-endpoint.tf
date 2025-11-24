locals {
  vpc_endpoint_enabled = local.enabled && try(length(var.vpc_id) > 0, false)
}

data "aws_region" "current" {}

module "vpc_endpoint_policy" {
  source  = "cloudposse/iam-policy/aws"
  version = "2.0.1"

  enabled = local.vpc_endpoint_enabled

  iam_policy = [{
    statements = [
      {
        effect    = "Allow"
        actions   = ["aps:*"]
        resources = ["*"]
        principals = [
          {
            type        = "AWS"
            identifiers = ["*"]
          }
        ]
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
  service_name      = format("com.amazonaws.%s.aps-workspaces", data.aws_region.current.id)
  vpc_endpoint_type = "Interface"

  policy = try(module.vpc_endpoint_policy.json, "")

  tags = module.this.tags
}
