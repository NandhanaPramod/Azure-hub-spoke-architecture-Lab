variable "basename_v1" {
  description = "Prefix used for all resources names"
  default     = "iskan"
  type        = string
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "env" {
  description = "Prefix used for environment name"
  type        = string
}

variable "name" {
  type        = string
  default     = ""
  description = "description"
}

variable "zones" {
  type        = list(string)
  default     = ["1", "2", "3"]
  description = "Availability zones for the APP GW and PublicIp"
}

variable "alerts" {
  description = "List of log based alerts configured for application gateway"
  type = list(object({
    name                    = string,
    evaluation_frequency    = string,
    severity                = number,
    window_duration         = string,
    description             = string,
    operator                = string,
    query                   = string,
    threshold               = number,
    time_aggregation_method = string
  }))
}

variable "non_prod_action_group" {
  description = "Action group for Non-prod alerts"
  type        = string
}

variable "prod_action_group" {
  description = "Action group for Pprod alerts"
  type        = string
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
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