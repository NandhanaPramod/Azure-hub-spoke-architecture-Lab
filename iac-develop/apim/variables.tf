variable "environment" {
  description = "Prefix used for environment type (hub/dev/qa/pp/prod)"
}

variable "location" {
  description = "Location of resources"
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "project" {
  description = "Name of project"
}

variable "client" {
  description = "Name of client"
}

variable "serviceclass" {
  description = "Environment classification (non-prod/prod)"
}

variable "businessowner" {
  description = "Environment owner (it/business unit/etc)"
}

variable "apim_name" {
  type = string
}

variable "sku_name" {
  type        = string
  description = "api management sku"
  default     = "Developer_1"
}

variable "managed_by_terraform" {
  description = "Managed Resource by Terraform"
  default     = "This resource is managed by terraform, do not make any changes direct to the console as they will be removed and or lost"
}

variable "publisher_name" {
  type        = string
  description = "api management publisher name"
}

variable "publisher_email" {
  type        = string
  description = "api management publisher email"
}

variable "virtual_network_type" {
  type        = string
  description = "api management virtual network type"
  default     = "Internal"
}

variable "tags" {
  description = "api management resource tags"

  default = {
    "Data_Classification" = "Standard"
  }
}

variable "needsSubscription" {
  description = "Is API Key needed to invoke the API ?"
  type        = bool
}

variable "named_values" {
  description = "Map of named values to be added to APIM"
  type        = map(string)
}

variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "apim_product" {
  type = list(object({
    product_id             = string
    display_name           = string
    subscriptions_limit    = string
    subscription_required  = bool
    approval_required      = bool
    published              = bool
    product_policy_content = string
  }))
}

variable "ratelimit" {
  type        = string
  description = "Maximum number call rate limit per key"
}

variable "ratelimitrenewal" {
  type        = string
  description = "Renewal time interval in seconds for the call rate limit per key"
}

variable "allowedIPs" {
  type        = list(string)
  description = "List of IPs for which Introspection GraphQL query is allowed"
}


variable "action_group" {
  type        = string
  description = "Name of action group that should be triggered in case of any alert"
}

variable "subscriptions" {
  type = list(object({
    name          = string,
    product_id    = string,
    allow_tracing = bool
  }))
  description = "List of product subscriptions that need to be created"
}

variable "private_dns_zone" {
  type        = string
  description = "Private DNS zone name for registering APIM's private DNS record"
}

variable "private_dns_zone_rg" {
  type        = string
  description = "Resource group where Private DNS zone lies"
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