variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "Region name where resources will be created"
  default     = "uaenorth"
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
  default     = "hub"
}

variable "vnet_name" {
  description = "Name of the VNet where Firewall needs to be deployed"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace to store the Logs"
  type        = string
}

variable "monitor_resource_group_name" {
  description = "Name of the resource group where Log Analytics Workspace exists"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP that needs to be created and attached to Firewall"
  type        = string
}

variable "resource_group" {
  description = "Resource group where Firewall needs to be created"
  type        = string
}

variable "firewall_name" {
  description = "Name of the Firewall that needs to be created"
  type        = string
}

variable "sku_name" {
  description = "SKU name for Azure Firewall"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for Azure Firewall"
  type        = string
}

variable "threat_intel_mode" {
  description = "The operation mode for threat intelligence-based filtering."
  type        = string
}