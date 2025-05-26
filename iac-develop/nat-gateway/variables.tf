variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where Nat Gateway needs to be deployed"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNet where subnet is deployed"
}

variable "location" {
  type        = string
  description = "Region where NAT gateway needs to be deployed"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for the public IP and NAT gateway"
}

variable "nat_gateway_sku" {
  type        = string
  description = "NAT gateway SKU"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet that needs to be associated with NAT gateway"
}