
variable "environment" {
  description = "Prefix used for environment type (hub/dev/qa/pp/prod)"
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "The location of resources"
}

variable "action_group" {
  type        = string
  description = "Name of action group that should be triggered in case of any alert"
}
