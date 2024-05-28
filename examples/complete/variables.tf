variable "vpc_id" {
  type        = string
  description = "If set, the ID of the VPC in which the endpoint will be used. If not set, no VPC endpoint will be created."
  default     = ""
}
