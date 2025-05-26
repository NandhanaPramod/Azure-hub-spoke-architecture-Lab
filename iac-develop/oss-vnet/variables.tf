variable "location" {
  description = "Location of cluster, if not defined it will be read from the resource-group"
  type        = string
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
}

variable "security_rules" {
  description = "A list of security rules to be created."
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

  validation {
    condition     = length(var.security_rules) > 0
    error_message = "You must specify at least one security rule."
  }
}

variable "security_group" {
  description = "A list of security group to be created."
  type = list(object({
    name = string
    rule = list(string)
  }))
}

variable "vnet_cidr" {
  description = "The cidr block for the vnet"
  type        = list(string)
}

variable "vnet_subnets" {
  description = "The subnets and their properties"
  default     = []

  type = list(object({
    name              = string
    address_prefixes  = list(string)
    security_group    = string
    service_endpoints = list(string)
    route_table       = string

  }))

  validation {
    condition     = length(var.vnet_subnets) > 0
    error_message = "You must specify at least one subnet."
  }
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = []
}

variable "routes" {
  description = "The subnets and their properties"
  default     = []

  type = list(object({
    name_prefix            = string
    name_postfix           = list(string)
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "create_resource_group" {
  type        = bool
  default     = false
  description = "Create resource group if it's a first use:  <basename>_<tf_workspace>"
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

variable "ddos_name" {
  type        = string
  default     = "iskan-ddos-protection-plan"
  description = "The name of the ddos service"
}


variable "ddos_resource_group" {
  type        = string
  default     = "oss_hub"
  description = "The ddos service resource group name"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

