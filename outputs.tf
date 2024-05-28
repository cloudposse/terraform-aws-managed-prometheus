output "workspace_id" {
  description = "The ID of this Amazon Managed Prometheus workspace"
  value       = aws_prometheus_workspace.this[0].id
}

output "workspace_arn" {
  description = "The ARN of this Amazon Managed Prometheus workspace"
  value       = aws_prometheus_workspace.this[0].arn
}

output "workspace_endpoint" {
  description = "The endpoint URL of this Amazon Managed Prometheus workspace"
  value       = aws_prometheus_workspace.this[0].prometheus_endpoint
}

output "access_role_arn" {
  description = "If enabled with `var.allowed_account_id`, the Role ARN used for accessing Amazon Managed Prometheus in this account"
  value       = local.access_role_enabled ? aws_iam_role.account_access[0].arn : ""
}

