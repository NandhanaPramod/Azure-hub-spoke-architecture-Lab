variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
  default     = "oss"
}

variable "hub_vnet_name" {
  type        = string
  description = "HUB VNet resource name"
}

variable "hub_peer_name" {
  type        = string
  description = "Name of the VNET peering between HUB and <ENV>"
}

variable "hub_resource_group" {
  type        = string
  description = "Resource group name for HUB VNet"
}

variable "arm_client_id" {
  type        = string
  description = "Hub client ID"
}

variable "arm_client_secret" {
  type        = string
  description = "Hub client Secret"
}

variable "arm_subscription_id" {
  type        = string
  description = "Hub subscription ID"
}

variable "spoke_peer_name" {
  type        = string
  description = "Name of the VNET peering between <ENV> and HUB"
}

variable "spoke_vnet_name" {
  type        = string
  description = "The <ENV> VNet resource name"
}

variable "spoke_resource_group" {
  type        = string
  description = "Resource group name for <ENV> VNet"
}

variable "allow_virtual_network_access" {
  type        = bool
  default     = false
  description = "description"
}

variable "allow_forwarded_traffic" {
  type        = string
  default     = false
  description = "description"
}

variable "allow_gateway_transit" {
  type        = string
  default     = false
  description = "description"
}
  