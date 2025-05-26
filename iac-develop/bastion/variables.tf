variable "location" {
  type        = string
  description = "Region where Azure Bastion needs to be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where Bastion needs to be deployed"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNet where Bastion needs to be deployed"
}

variable "log_analytics_workspace_name" {
  type = string
  description = "Name of the log analytics workspace"
}

variable "monitor_resource_group_name" {
  type = string
  description = "Name of the log analytics workspace"
}
