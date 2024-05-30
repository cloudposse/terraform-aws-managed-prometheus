locals {
  access_role_enabled = local.enabled && length(var.allowed_account_id) > 0
}

module "access_role" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["access"]

  context = module.this.context
}

resource "aws_iam_role" "account_access" {
  count = local.access_role_enabled ? 1 : 0

  name = module.access_role.id

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${var.allowed_account_id}:root"
        }
      },
    ]
  })

  inline_policy {
    name   = module.account_access_policy_label.id
    policy = data.aws_iam_policy_document.aps[0].json
  }
}

# See "Amazon Managed Service for Prometheus"
# https://docs.aws.amazon.com/grafana/latest/userguide/AMG-manage-permissions.html
data "aws_iam_policy_document" "aps" {
  count = local.access_role_enabled ? 1 : 0

  statement {
    actions = [
      "aps:ListWorkspaces",
      "aps:DescribeWorkspace",
      "aps:QueryMetrics",
      "aps:GetLabels",
      "aps:GetSeries",
      "aps:GetMetricMetadata"
    ]
    resources = ["*"]
  }
}

module "account_access_policy_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled = local.prometheus_policy_enabled

  attributes = ["aps"]

  context = module.this.context
}
