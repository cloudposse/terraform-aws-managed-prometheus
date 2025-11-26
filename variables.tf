variable "alert_manager_definition" {
  type        = string
  description = "The alert manager definition that you want to be applied."
  default     = ""
}

variable "rule_group_namespaces" {
  type = list(object({
    name = string
    data = string
  }))
  description = "A list of name, data objects for each Amazon Managed Service for Prometheus (AMP) Rule Group Namespace"
  default     = []
}

variable "scraper_deployed" {
  type        = bool
  description = "When connecting an Amazon Managed Collector, also known as a scraper, Amazon will add a tag to this AMP workspace. Set this value to `true` to resolve Terraform drift."
  default     = false
}

variable "allowed_account_id" {
  type        = string
  description = "The Account ID of another AWS account allowed to access Amazon Managed Prometheus in this account. If defined, this module will create a cross-account IAM role for accessing APS. Use this for cross-account Grafana. If not defined, no roles will be created."
  default     = ""
}

variable "vpc_endpoint_enabled" {
  type        = bool
  description = "Set to true to create a VPC endpoint for Amazon Managed Prometheus. Requires vpc_id to be set."
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "If `var.vpc_endpoint_enabled` is true, the ID of the VPC in which the endpoint will be used."
  default     = ""
}
