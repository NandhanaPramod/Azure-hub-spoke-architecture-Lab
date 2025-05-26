variable "resource_group_name" {
  type        = string
  description = "Resource group name where DDoS protection plan will be deployed"
}

variable "location" {
  type        = string
  description = "Region name where resources will be created"
}

variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources."
}

variable "environment" {
  type        = string
  description = "Environment name i.e. hub/dev/qa/pp/prod"
}