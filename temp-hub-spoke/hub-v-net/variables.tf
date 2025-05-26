variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod, non-prod)"
  type        = string
}

variable "basename" {
  description = "Base name for all resources"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    nsg_name         = string
    service_endpoints = list(string)
  }))
}

variable "security_rules" {
  description = "List of security rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "security_group" {
  description = "List of security groups"
  type = list(object({
    name = string
    rule = list(string)
  }))
}

variable "firewall_policy" {
  description = "Azure Firewall policy configuration"
  type = object({
    name                = string
    sku                 = string
    threat_intel_mode   = string
    dns_servers         = list(string)
    private_ip_ranges   = list(string)
  })
}

variable "bastion_config" {
  description = "Azure Bastion configuration"
  type = object({
    name = string
    sku  = string
  })
}

variable "vpn_gateway_config" {
  description = "VPN Gateway configuration"
  type = object({
    name = string
    sku  = string
    type = string
  })
}

variable "private_dns_zones" {
  description = "List of private DNS zones to create"
  type        = list(string)
  default     = []
}

variable "key_vault_config" {
  description = "Key Vault configuration"
  type = object({
    name                = string
    sku                 = string
    enabled_for_disk_encryption = bool
    purge_protection_enabled    = bool
  })
}

variable "container_registry_config" {
  description = "Container Registry configuration"
  type = object({
    name = string
    sku  = string
  })
}

variable "storage_account_config" {
  description = "Storage Account configuration"
  type = object({
    name                     = string
    account_tier             = string
    account_replication_type = string
  })
}

variable "log_analytics_config" {
  description = "Log Analytics Workspace configuration"
  type = object({
    name              = string
    sku               = string
    retention_in_days = number
  })
}

variable "create_resource_group" {
  description = "Whether to create a new resource group"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Name of the existing resource group (if create_resource_group is false)"
  type        = string
  default     = null
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "The subscription ID to use for the Azure provider"
  type        = string
  default     = null
} 