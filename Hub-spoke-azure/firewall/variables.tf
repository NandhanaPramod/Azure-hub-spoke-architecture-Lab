variable "firewall_name" {
  description = "Name of the Azure Firewall"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU name of the Azure Firewall"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier of the Azure Firewall"
  type        = string
}

variable "threat_intel_mode" {
  description = "Threat intelligence mode for the Azure Firewall"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 