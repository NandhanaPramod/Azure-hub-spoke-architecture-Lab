variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
  default     = "iskan_firewall"
}

variable "location" {
  description = "Location of services"
  default     = "uaenorth"
}

variable "basename" {
  description = "Name of project"
  default     = "oss"
}

variable "client" {
  description = "Name of client"
  default     = "adha"
}

variable "environment" {
  description = "Prefix used for environment type (hub/dev/qa/non-prod/prod)"
  default     = "qa"
}

variable "serviceclass" {
  description = "Environment classification (non-prod/prod)"
  default     = "non-prod"
}

variable "businessowner" {
  description = "Environment owner (it/business unit/etc)"
  default     = "it"
}
