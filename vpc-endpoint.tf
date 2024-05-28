locals {
  vpc_endpoint_enabled = local.enabled && length(var.vpc_id) > 0
}

data "aws_region" "current" {}

data "aws_iam_policy_document" "vpc_endpoint_access" {
  count = local.vpc_endpoint_enabled ? 1 : 0

  statement {
    actions   = ["aps:*"]
    effect    = "Allow"
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
  service_name      = format("com.amazonaws.%s.aps-workspaces", data.aws_region.current.name)
  vpc_endpoint_type = "Interface"

  policy = data.aws_iam_policy_document.vpc_endpoint_access[0].json

  tags = module.this.tags
}
