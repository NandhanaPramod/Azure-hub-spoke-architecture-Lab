variable "location" {
  type        = string
  description = "Location where dashboard will be created"
}

variable "hub_dashboards" {
  description = "List of hub dashboards"
  type = list(object({
    name                     = string,
    dashboard_config_file    = string,
    application_gateway_name = string,
    service_class            = string
  }))
  default = []
}

variable "basename" {
  type        = string
  description = "Basename of the resources"
}

variable "spoke_dashboards" {
  description = "List of spoke dashboards"
  type = list(object({
    name                  = string,
    dashboard_config_file = string,
    aks_name              = string,
    aks_namespace         = string,
  }))
  default = []
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}