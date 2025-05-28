variable "basename" {
  description = "Base name for the DDoS Protection Plan"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "DNS servers for the virtual network"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 