variable "private_zones" {
  type        = list(string)
  description = "List of Private DNS zone names to be created"
}

variable "basename" {
  type        = string
  description = "Basename of resources"
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "Region name where resources will be created"
  default     = "uaenorth"
}
