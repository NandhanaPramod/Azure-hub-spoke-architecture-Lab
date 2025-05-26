variable "resource_group_name" {
  type        = string
  description = "Resource group name where the service bus will be deployed/associated with."
}

variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
}

variable "location" {
  type        = string
  description = "Location where your exisiting services are running or you would like to deploy this service bus"
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
  default     = ""
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "servicebus_namespaces_queues_data" {
  type        = any
  description = "Complete Service bus namespace and Queues data per environment"
}

variable "servicebus_whitelist_ip" {
  type        = list(string)
  description = "List of IP/CIDR to be whistlisted, to access the service bus."
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID of the respective environment"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "default_tags" {
  type    = map(string)
  default = {}
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

variable "action_group" {
  type        = string
  description = "Name of the action group that should be triggered in case of an alert"
}
