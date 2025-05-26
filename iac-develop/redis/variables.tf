variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "location" {
  description = "Location of cluster"
  type        = string
}

variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "enable_non_ssl_port" {
  type        = bool
  description = "Enable the non-SSL port (6379)"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this Redis Cache"
}

variable "enable_authentication" {
  type        = bool
  description = "If set to false, the Redis instance will be accessible without authentication"
}

variable "patch_schedule" {
  type = object({
    day_of_week    = string,
    start_hour_utc = number
  })
}

variable "virtual_network_name" {
  type        = string
  description = "The name of VNet under which the subnet exists"
}

variable "subnet_name" {
  type        = string
  description = "The name of Subnet from which Private IP address will be allocated to Private endpoint"
}

variable "capacity" {
  type        = number
  description = "The size of the Redis cache to deploy"
}

variable "family" {
  type        = string
  description = "The SKU family/pricing group to use"
}

variable "sku_name" {
  type        = string
  description = "The SKU of Redis to use"
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

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "action_group" {
  type        = string
  description = "Name of the action group that should be triggered in case of an alert"
}

variable "redis_version" {
  type        = number
  default     = 4
  description = "The version of Redis to use"
}