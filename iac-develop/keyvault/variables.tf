variable "location" {
  type        = string
  description = "Region name where resources will be created"
}

variable "basename" {
  type        = string
  description = "Prefix used for all resources names"
  default     = "oss"
}

variable "keyvault_sku" {
  type        = string
  description = "The Name of the SKU used for this Key Vault"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted"
}

variable "allow_azure_services_bypass_firewall" {
  type        = bool
  description = "Specifies which traffic can bypass the network rules"
}

variable "default_action" {
  type        = string
  description = "The Default Action to use when no rules match. Possible values are Allow and Deny"
}

variable "virtual_network_name" {
  type        = string
  description = "VNet name from which traffic should be allowed"
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names from which traffic should be allowed"
}

variable "virtual_network_resource_group" {
  type        = string
  description = "The name of the resource group the Virtual Network is located in"
}

variable "allowed_ips" {
  type        = list(string)
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault"
}

variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "create_resource_group" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "Enable RBAC access to KV"
}

variable "key_vault_admin" {
  type        = string
  default     = "2ec87220-2efc-46e0-9d5f-545cff9b07a4"
  description = "The admin user OBJECT_ID for the KV. Defaults to `sa_terraform@adhaauh.onmicrosoft.com` object id"
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Enable purge protection for kv."
}

variable "private_dns_zone" {
  type        = string
  description = "Name of the private dns zone for private endpoint"
}

variable "private_dns_zone_rg" {
  type        = string
  description = "Name of the private dns zone resource group for private endpoint"
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

variable "private_link_subnet_name" {
  type        = string
  description = "Name of the subnet where private endpoint should be created"
}

variable "sas_rotation_function" {
  type        = string
  description = "Name of the SAS rotation function"
}

variable "sas_rotation_function_rg" {
  type        = string
  description = "SAS rotation function's resource group"
}

variable "sas_rotation_function_app" {
  type        = string
  description = "Name of the Function App containing SAS rotation function"
}

variable "sas_token_secret" {
  type        = string
  description = "Name of the Key Vault secret containing SAS token for Media storage account"
}

variable "managed_identity_with_secrets_permission" {
  type        = map(string)
  description = "Key value pair of managed identity and its principal ID which need Key Vault Secrets Officer role"
  default     = {}
}

variable "managed_identity_with_certs_permission" {
  type        = map(string)
  description = "Key value pair of managed identity and its principal ID which need Key Vault Certificates Officer role"
  default     = {}
}

variable "action_group" {
  type        = string
  description = "Name of action group that should be triggered in case of any alert"
}

variable "prod_diagnostic_settings" {
  type = bool
  default=false
  description = "Additional diagnostic settings for sending logs to other log analytics workspaces"
}

variable "prod_client_id" {
  type        = string 
  description = "Client id of production environment"
}

variable "prod_client_secret" {
  type        = string
  description = "Client secret of production environment"
}

variable "prod_subscription_id" {
  type        = string
  description = "Subscription id of production environment"
}