
resource "azurerm_public_ip" "prod_pip" {
  name = local.app_gw_pip_name_prod

  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  allocation_method   = "Static"

  zones = var.zones

  sku      = "Standard"
  sku_tier = "Regional"

  tags = merge(
    local.tags,
    {
      ServiceClass = "prod"
    }
  )
}

module "app-gateway-prodv1" {
  source = "./modules/app-gateway/"
  depends_on = [
    azurerm_role_assignment.prodv1
  ]
  name                = local.app_gw_name_prod
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  basename            = var.basename

  firewall_policy_id = data.azurerm_web_application_firewall_policy.prod.id
  enable_http2       = local.gw_enable_http2
  zones              = var.zones
  trusted_root_certificates = [
    {
      name                = "adha-root-ca"
      key_vault_secret_id = data.azurerm_key_vault_secret.adha-root-ca-public-key.versionless_id
    }
  ]

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.prodv1.id]
  }

  sku = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration = {
    min_capacity = 0
    max_capacity = 10
  }

  gateway_ip_configurations = [
    {
      name      = "gateway_ip_configuration"
      subnet_id = data.azurerm_subnet.gw_subnet.id
    }
  ]

  frontend_ports = [
    {
      name = "port_4433"
      port = 4433
    },
  ]

  frontend_ip_configurations = [
    {
      name                          = join("-", [local.app_gw_name_prod, "public-frontend-ip"])
      public_ip_address_id          = azurerm_public_ip.prod_pip.id
      private_ip_address_allocation = "Dynamic"
    },
    {
      name                          = join("-", [local.app_gw_name_prod, "private-frontend-ip"])
      subnet_id                     = data.azurerm_subnet.gw_subnet.id
      private_ip_address            = "10.50.1.225"
      private_ip_address_allocation = "Static"
    },
  ]

  backend_address_pools = [
    {
      name         = "iskan-prod-apim-backend-pool"
      ip_addresses = ["10.50.16.133"]
    },
    {
      name         = "dhp-prod-nginx-backend-pool"
      ip_addresses = ["10.50.30.217"]
    }
  ]

  backend_http_settings = [
    {
      name                  = "iskan-prod-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "iskan-prod-apim.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-prod-apim-probe"
    },
    {
      name                  = "dhp-prod-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-prod-camunda-probe"
    },
    {
      name                  = "dhp-prod-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-prod-react-probe"
    },
  ]

  ssl_certificates = [
    {
      name = "iskan-api-prod"
      data = data.azurerm_key_vault_secret.prod.value
    },
    {
      name                = "dhp-app-prod-cert"
      key_vault_secret_id = data.azurerm_key_vault_secret.dhp-app-prod-cert.versionless_id
    },
    {
      name                = "camunda-prod-cert"
      key_vault_secret_id = data.azurerm_key_vault_secret.camunda-prod-cert.versionless_id
    }
  ]

  http_listeners = [
    {
      name                           = "iskan-prod-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name_prod, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api.adha.gov.ae",
        "iskan-api.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-prod"
    },
    {
      name                           = "dhp-prod-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name_prod, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda.adha.ae",
        "camunda.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-prod-cert"
    },
    {
      name                           = "dhp-prod-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name_prod, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app.adha.ae",
        "dhp-app.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-prod-cert"
    }

  ]

  redirect_configurations = [
    {
      name                 = "iskan-prod-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-prod-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-prod-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app.adha.gov.ae"
      include_path         = true
      include_query_string = true
    }
  ]

  request_routing_rules = [
    {
      name                       = "iskan-prod-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 300
      http_listener_name         = "iskan-prod-apim-https-private-listener"
      backend_address_pool_name  = "iskan-prod-apim-backend-pool"
      backend_http_settings_name = "iskan-prod-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-prod-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2100
      http_listener_name         = "dhp-prod-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-prod-nginx-backend-pool"
      backend_http_settings_name = "dhp-prod-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-prod-react-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2200
      http_listener_name         = "dhp-prod-react-https-private-listener"
      backend_address_pool_name  = "dhp-prod-nginx-backend-pool"
      backend_http_settings_name = "dhp-prod-react-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    }
  ]

  url_path_maps = []

  probes = [
    {
      name                                      = "iskan-prod-apim-probe"
      protocol                                  = "Http"
      host                                      = "iskan-prod-apim.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "dhp-prod-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-prod-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
  ]

  alerts                      = [for alert in var.alerts : merge(alert, { action_group = var.prod_action_group })]
  default_alerts_action_group = var.prod_action_group

  rewrite_rule_set = [
    {
      name          = "Strict-Transport-Security"
      rule_sequence = 1
      header_name   = "Strict-Transport-Security"
      header_value  = "max-age=31536000"
    }
  ]

  tags = merge(
    local.tags,
    {
      ServiceClass = "prod"
    }
  )
  prod_diagnostic_settings = {
    prod = "${data.azurerm_log_analytics_workspace.prod.id}"
  }
}