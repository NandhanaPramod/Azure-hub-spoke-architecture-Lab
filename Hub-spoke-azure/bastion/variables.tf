variable "bastion_name" {
  description = "Name of the Bastion Host"
  type        = string
}

variable "bastion_ip_name" {
  description = "Name of the Bastion Public IP"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID of the AzureBastionSubnet"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
} 