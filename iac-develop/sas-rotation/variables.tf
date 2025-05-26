variable "function_name" {
  type        = string
  description = "Name of the Function"
}

variable "location" {
  type        = string
  description = "Location of Function"
}

variable "os_type" {
  type        = string
  description = "OS type for service plan"
}

variable "sku_name" {
  type        = string
  description = "The SKU for the plan"
}

variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Function App"
}

variable "app_insights_name" {
  type        = string
  description = "Name of App Insights for monitoring the function"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of VNet under which the subnet exists"
}

variable "subnet_name" {
  type        = string
  description = "The name of Subnet for VNet integration"
}

variable "file_share_name" {
  type        = string
  description = "Name of the file share in Storage account"
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "app_insights_rg" {
  type        = string
  description = "Resource group containing Application Insights"
}

variable "allowed_ips" {
  type        = map(string)
  description = "Map of allowed IPs on function app"
}

variable "log_analytics_workspace" {
  type        = string
  description = "Name of the Log Analytics workspace"
}

variable "monitored_strings" {
  type        = map(string)
  description = "Map of strings to be monitored and alerted for"
}

variable "action_group" {
  type        = string
  description = "Name of action group that should be triggered in case of any alert"
}