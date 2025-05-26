variable "location" {
  type        = string
  description = "Region name where resources will be created"
}

variable "sku" {
  type        = string
  description = "The SKU name of the container registry"
}

variable "registry_name" {
  type        = string
  description = "Specifies the name of the Container Registry"
}

variable "basename" {
  type        = string
  description = "Prefix used for all resources names"
  default     = "oss"
}

variable "virtual_network_name" {
  type        = string
  description = "VNet name where private link needs to be created"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name where private link needs to be created"
}

variable "virtual_network_resource_group" {
  type        = string
  description = "The name of the resource group the Virtual Network is located in"
}

variable "private_dns_zone" {
  type        = string
  description = "Name of the private dns zone for private endpoint"
}

variable "private_dns_zone_rg" {
  type        = string
  description = "Name of the private dns zone resource group for private endpoint"
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of Allowed CIDR blocks allowed on ACR"
}

variable "replication_location" {
  type        = string
  description = "A location where the container registry should be geo-replicated."
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}