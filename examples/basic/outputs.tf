output "workspace_arn" {
  description = "The ARN of this Amazon Managed Prometheus workspace"
  value       = module.managed_prometheus.workspace_arn
}

output "workspace_id" {
  description = "The ID of this Amazon Managed Prometheus workspace"
  value       = module.managed_prometheus.workspace_id
}

output "access_role_arn" {
  description = "If enabled with `var.allowed_account_id`, the Role ARN used for accessing Amazon Managed Prometheus in this account"
  value       = module.managed_prometheus.access_role_arn
}

