output "workspace_arn" {
  description = "The ARN of this Amazon Managed Prometheus workspace"
  value       = module.managed_prometheus.workspace_arn
}

output "workspace_id" {
  description = "The ID of this Amazon Managed Prometheus workspace"
  value       = module.managed_prometheus.workspace_id
}

