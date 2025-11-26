locals {
  # Deploy the VPC endpoint if explicitly enabled
  vpc_endpoint_enabled = local.enabled && var.vpc_endpoint_enabled
}

data "aws_region" "current" {
  count = local.vpc_endpoint_enabled ? 1 : 0
}

data "aws_iam_policy_document" "vpc_endpoint_policy" {
  count = local.vpc_endpoint_enabled ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["aps:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpc"
      values   = [var.vpc_id]
    }
  }
}

resource "aws_vpc_endpoint" "prometheus" {
  count = local.vpc_endpoint_enabled ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = format("com.amazonaws.%s.aps-workspaces", one(data.aws_region.current[*].id))
  vpc_endpoint_type = "Interface"

  policy = one(data.aws_iam_policy_document.vpc_endpoint_policy[*].json)

  tags = module.this.tags
}
