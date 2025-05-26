variable "basename" {
  description = "Prefix used for all resources names"
  default     = "iskan"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for app-gateway."
  type        = string
}

variable "location" {
  description = "Location for app-gateway."
  type        = string
}

variable "name" {
  description = "gw name"
  type        = string
}

variable "firewall_policy_id" {
  description = "fw policy"
  type        = string
}

variable "postfix" {
  description = "Postfix used for resource name"
  type        = list(string)
  default     = ["app", "gw"]
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })

  description = "The managed identity for the app gw. needed for KV access"
}

variable "sku" {
  type = object({
    name     = string
    tier     = string
    capacity = optional(number)
  })

  validation {
    condition     = contains(["Standard_Small", "Standard_Medium", "Standard_Large", "Standard_v2", "WAF_Medium", "WAF_Large", "WAF_v2"], var.sku.name)
    error_message = "Tier must be one of: `Standard_Small`, `Standard_Medium V2`,`Standard_Large`, `Standard_v2`, `WAF_Medium`, `WAF_Large`, `WAF_v2`."
  }

  validation {
    condition     = contains(["Standard", "Standard V2", "WAF", "WAF_v2"], var.sku.tier)
    error_message = "Tier must be one of: `Standard`, `Standard_v2`,`WAF`, `WAF_v2`."
  }
}

variable "autoscale_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })

  default = null

  validation {
    condition     = (var.autoscale_configuration.min_capacity >= 0 && var.autoscale_configuration.min_capacity <= 100) || var.autoscale_configuration == null
    error_message = "Autoscale min_capacity should be in 0 - 100 range"
  }
  validation {
    condition     = (var.autoscale_configuration.max_capacity >= 2 && var.autoscale_configuration.max_capacity <= 125) || var.autoscale_configuration == null
    error_message = "Autoscale max_capacity should be in 2 - 125 range"
  }
}

variable "gateway_ip_configurations" {
  type = list(object({
    name      = string
    subnet_id = string
  }))

  # carrefull with default. here tempporary. please remomve
}

variable "zones" {
  type        = list(string)
  default     = ["1", "2", "3"]
  description = "Availability zones for the APP GW"
}

variable "enable_http2" {
  description = "Enable HTTP2 on the application gateway resource."
  type        = bool
  default     = false
}

# more info on experimental feature: https://github.com/hashicorp/terraform/issues/30750#issuecomment-1150475431
variable "frontend_ip_configurations" {
  type = list(object({
    name                          = optional(string)
    subnet_id                     = optional(string)
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    private_ip_address_allocation = optional(string)
  }))

  # validation {
  #   condition     = var.frontend_ip_configuration.private_ip_address_allocation == null ? true : contains(["Dynamic", "Static"], var.frontend_ip_configuration.private_ip_address_allocation)
  #   error_message = "Private IP Address can be one of `Dynamic`, `Static`, `null`."
  # }
}

variable "frontend_ports" {
  type = list(object({
    name = optional(string)
    port = optional(number)
  }))

  validation {
    condition     = length(var.frontend_ports) > 0
    error_message = "You must specify at least one `frontend_port`"
  }

  # validation {
  #   condition     = alltrue([for p in var.frontend_ports : p.port > 79])
  #   error_message = "All ports need to be greater than 100"
  # }
}

# variable "backend_address_pools" {
#   type = list(object({
#     name         = optional(string)
#     fqdns        = optional(list(string))
#     ip_addresses = optional(list(string))
#   }))
# }


# TODO add validation
variable "backend_address_pools" {
  type = list(object({
    name         = optional(string)
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))

  default = [{}]
}

variable "backend_http_settings" {
  type = list(object({
    affinity_cookie_name = optional(string)

    # authentication_certificate = object({
    #   name = optional(string)
    #   data = optional(string)
    # })

    connection_draining = optional(object({
      enabled           = optional(bool)
      drain_timeout_sec = optional(number)
    }))

    cookie_based_affinity               = optional(string)
    host_name                           = optional(string)
    name                                = optional(string)
    path                                = optional(string)
    pick_host_name_from_backend_address = optional(bool)
    port                                = optional(number)
    probe_name                          = optional(string)
    protocol                            = optional(string)
    request_timeout                     = optional(number)
    trusted_root_certificate_names      = optional(list(string))

    # trusted_root_certificate = object({
    #   name                = optional(string)
    #   data                = optional(string)
    #   key_vault_secret_id = optional(string)
    # })
  }))

  # validation {
  #   condition     = var.backend_http_settings.affinity_cookie_name == null && contains(["Disabled"], var.backend_http_settings.cookie_based_affinity)
  #   error_message = "If `cookie_based_affinity` is Enabled, `affinity_cookie_name` is required. Omit otherwise."
  # }

  # # TODO split validation rule 
  # validation {
  #   condition     = var.backend_http_settings.connection_draining == null ? true : (var.backend_http_settings.connection_draining.enabled && var.backend_http_settings.connection_draining.drain_timeout_sec != null)
  #   error_message = "`connection_draining block` can be null. Otherwise if `connection_draining` is  true, `drain_timeout_sec` is required."
  # }

  # validation {
  #   condition     = contains(["Enabled", "Disabled"], var.backend_http_settings.cookie_based_affinity)
  #   error_message = " Is Cookie-Based Affinity enabled?"
  # }

  # validation {
  #   condition     = var.backend_http_settings.name != null
  #   error_message = "Please set the name for the backend security setting. It will not be computed automatically!"
  # }

  # validation {
  #   condition     = var.backend_http_settings.pick_host_name_from_backend_address == null ? true : ((var.backend_http_settings.pick_host_name_from_backend_address && var.backend_http_settings.host_name == null) || (var.backend_http_settings.pick_host_name_from_backend_address == false && var.backend_http_settings.host_name != null))
  #   error_message = "`pick_host_name_from_backend_address` defaults to false. If true `host_name` should not be set!"
  # }
}

variable "ssl_certificates" {
  type = list(object({
    name                = optional(string)
    key_vault_secret_id = optional(string)
    data                = optional(string)
  }))

  default = []
}

variable "ssl_profiles" {
  type = list(object({
    name                             = string
    trusted_client_certificate_names = optional(string)
    verify_client_cert_issuer_dn     = optional(string)
    ssl_policy = optional(object({
      policy_name          = optional(string)
      policy_type          = optional(string)
      cipher_suites        = optional(list(string))
      min_protocol_version = optional(string)
    }))
  }))
  default     = []
  description = "SSL profiles"
}

# TODO check listener assiciated rule in portal.azure.com
variable "http_listeners" {
  type = list(object({
    name                           = optional(string)
    frontend_ip_configuration_name = optional(string)
    frontend_port_name             = optional(string)
    protocol                       = optional(string)
    host_names                     = optional(list(string))
    require_sni                    = optional(bool)

    # # Don't use for now
    # host_name                      = optional(string)
    ssl_certificate_name = optional(string)
    # custom_error_configuration     = optional(string)
    # firewall_policy_id             = optional(string)
    # ssl_profile_name               = optional(string)
  }))
}

variable "redirect_configurations" {
  type = list(object({
    name                 = optional(string)
    type                 = optional(string)
    listener             = optional(string)
    target_url           = optional(string)
    include_path         = optional(bool)
    include_query_string = optional(bool)
  }))
}

variable "url_path_maps" {
  type = list(object({
    name                                              = optional(string)
    default_backend_address_pool_name                 = optional(string)
    default_backend_http_settings_name                = optional(string)
    path_rule                                         = optional(list(object({ 
    name                       = optional(string)
    paths                      = optional(list(string))
    backend_address_pool_name  = optional(string)
    backend_http_settings_name = optional(string)    
  })))
  }))
}

variable "request_routing_rules" {
  type = list(object({
    name                        = optional(string)
    rule_type                   = optional(string)
    priority                    = optional(number)
    http_listener_name          = optional(string)
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    url_path_map_name           = optional(string)

    # # Don't use for now
    # redirect_configuration_name = optional(string)
    # rewrite_rule_set_name       = optional(string)
    # url_path_map_name           = optional(string)
  }))
}

variable "probes" {
  type = list(object({
    name                                      = optional(string)
    protocol                                  = optional(string)
    host                                      = optional(string)
    pick_host_name_from_backend_http_settings = optional(string)
    interval                                  = optional(number)
    timeout                                   = optional(number)
    unhealthy_threshold                       = optional(number)
    path                                      = optional(string)

    # minimum_servers                           = optional(string)
    # match                                     = optional(string)
    # port                                      = optional(string)
  }))
}

variable "alerts" {
  description = "List of log based alerts configured for application gateway"
  type = list(object({
    name                    = string,
    evaluation_frequency    = string,
    severity                = number,
    window_duration         = string,
    description             = string,
    action_group            = string,
    operator                = string,
    query                   = string,
    threshold               = number,
    time_aggregation_method = string
  }))
}

variable "default_alerts_action_group" {
  type = string
  description = "Name of action group used for sending all default alerts" 
}

variable "rewrite_rule_set" {
  description = "List to add the Headers for all microservices"
  default     = []
  type = list(object({
    name          = string
    header_name   = string
    rule_sequence = number
    header_value  = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "trusted_root_certificates" {
  type = list(object({
    name                = string,
    key_vault_secret_id = optional(string)
  }))
  description = "Lit of Trusted Root Certificate"
}

variable "prod_diagnostic_settings" {
  type        = map(string)
  default     = {} 
  description = "Additional diagnostic settings for sending logs to other log analytics workspaces"
}