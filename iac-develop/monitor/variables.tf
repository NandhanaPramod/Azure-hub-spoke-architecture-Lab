variable "location" {
  type        = string
  description = "Region name where resources will be created"
}

variable "basename" {
  type        = string
  description = "Prefix used for all resources names"
  default     = "oss"
}

variable "log_analytics_sku" {
  type        = string
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018"
}

variable "log_analytics_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
}

variable "audit_log_analytics_retention_in_days" {
  type        = number
  description = "The workspace data retention in days for audit logs"
}

variable "app_insights_retention_in_days" {
  type        = number
  description = "Specifies the retention period in days for App Insights"
}

 variable "log_analytics_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB"
} 

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "create_resource_group" {
  type        = bool
  default     = false
  description = "Create resource group if it's a first use:  <basename>_<tf_workspace>"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "action_groups" {
  type = list(object({
    name           = string,
    email_adresses = list(string)
  }))
}

variable "availability_tests" {
  type = bool
  default= false
  description = "Percentage of successfully completed availability tests"
}