variable "basename" {
  type        = string
  description = "Basename of resources"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNet that needs to be linked with private zones"
}

variable "private_zones" {
  type        = map(string)
  description = "key value pair of Private DNS zone and its resource group name to be linked with vnet"
}

variable "arm_client_id" {
  type        = string
  description = "client ID where DNS zone exists"
}

variable "arm_client_secret" {
  type        = string
  description = "client secret where DNS zone exists"
}

variable "arm_subscription_id" {
  type        = string
  description = "subscription ID where DNS zone exists"
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "Region name where resources will be created"
  default     = "uaenorth"
}