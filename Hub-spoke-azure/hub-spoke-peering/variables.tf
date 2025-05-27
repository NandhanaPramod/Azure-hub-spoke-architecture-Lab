variable "hub_resource_group_name" {
  description = "Name of the resource group containing the hub VNet"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "hub_vnet_id" {
  description = "Resource ID of the hub VNet"
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Name of the resource group containing the spoke VNet"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the spoke VNet"
  type        = string
}

variable "spoke_vnet_id" {
  description = "Resource ID of the spoke VNet"
  type        = string
} 