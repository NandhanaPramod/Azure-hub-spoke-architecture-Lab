variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
}

variable "environment" {
  type        = string
  description = "Environment name i.e. hub/dev/qa/pp/prod"
}

variable "location" {
  type        = string
  description = "Location where Notification Hub will be running on"
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}