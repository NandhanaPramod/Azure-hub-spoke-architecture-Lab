resource "azurerm_public_ip" "pip" {
  name                = local.app_gw_pip_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  allocation_method   = "Static"

  zones = var.zones

  sku      = "Standard"
  sku_tier = "Regional"

  tags = merge(
    local.tags,
    {
      ServiceClass = "non-prod"
    }
  )
}

module "app-gateway-non-prod" {
  source = "./modules/app-gateway/"

  name                = local.app_gw_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  basename            = var.basename

  firewall_policy_id = data.azurerm_web_application_firewall_policy.this.id
  enable_http2       = local.gw_enable_http2
  zones              = var.zones

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }

  trusted_root_certificates = [
    {
      name                = "adha-root-ca"
      key_vault_secret_id = data.azurerm_key_vault_secret.adha-root-ca-public-key.versionless_id
    }
  ]

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
      name                          = join("-", [local.app_gw_name, "public-frontend-ip"])
      public_ip_address_id          = azurerm_public_ip.pip.id
      private_ip_address_allocation = "Dynamic"
    },
    {
      name      = join("-", [local.app_gw_name, "private-frontend-ip"])
      subnet_id = data.azurerm_subnet.gw_subnet.id
      # should be in subnet range
      private_ip_address            = "10.50.1.230"
      private_ip_address_allocation = "Static"
    },
  ]

  backend_address_pools = [
    {
      name         = "iskan-dev-apim-backend-pool"
      ip_addresses = ["10.50.4.136"]

    },
    {
      name         = "iskan-qa-apim-backend-pool"
      ip_addresses = ["10.50.8.133"]
    },
    {
      name         = "iskan-pp-apim-backend-pool"
      ip_addresses = ["10.50.12.133"]
    },
    {
      name         = "iskan-qa2-apim-backend-pool"
      ip_addresses = ["10.50.20.133"]
    },
    {
      name         = "iskan-qa3-apim-backend-pool"
      ip_addresses = ["10.50.24.133"]
    },
    {
      name         = "dhp-dev-nginx-backend-pool"
      ip_addresses = ["10.50.6.153"]
    },
    {
      name  = "dhp-dev-storybook-backend-pool"
      fqdns = ["ossdevstorybook.z1.web.core.windows.net"]
    },
    {
      name         = "dhp-qa-nginx-backend-pool"
      ip_addresses = ["10.50.32.121"]
    },
    {
      name         = "dhp-pp-nginx-backend-pool"
      ip_addresses = ["10.50.28.217"]
    },
    {
      name         = "dhp-qa2-nginx-backend-pool"
      ip_addresses = ["10.50.22.189"]
    },
    {
      name         = "dhp-qa3-nginx-backend-pool"
      ip_addresses = ["10.50.34.217"]
    }
  ]

  backend_http_settings = [
    {
      name                  = "iskan-dev-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "oss-dev-apim-bt.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-dev-apim-probe"
    },
    {
      name                  = "iskan-qa-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "iskan-qa-apim.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-qa-apim-probe"
    },
    {
      name                  = "iskan-pp-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "iskan-pp-apim.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-pp-apim-probe"
    },
    {
      name                  = "iskan-qa2-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "iskan-qa2-apim.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-qa2-apim-probe"
    },
    {
      name                  = "iskan-qa3-apim-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "iskan-qa3-apim.azure-api.net"
      protocol                            = "Http"
      port                                = 80
      request_timeout                     = 300

      probe_name = "iskan-qa3-apim-probe"
    },
    {
      name                  = "dhp-dev-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda-dev.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-dev-camunda-probe"
    },
    {
      name                  = "dhp-qa-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda-qa.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa-camunda-probe"
    },
    {
      name                  = "dhp-pp-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda-pp.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-pp-camunda-probe"
    },
    {
      name                  = "dhp-qa2-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda-qa2.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa2-camunda-probe"
    },
    {
      name                  = "dhp-qa3-camunda-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "camunda-qa3.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa3-camunda-probe"
    },
    {
      name                  = "dhp-dev-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app-dev.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-dev-react-probe"
    },
    {
      name                  = "dhp-qa-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app-qa.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa-react-probe"
    },
    {
      name                  = "dhp-pp-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app-pp.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-pp-react-probe"
    },
    {
      name                  = "dhp-qa2-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app-qa2.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa2-react-probe"
    },
    {
      name                  = "dhp-qa3-react-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      trusted_root_certificate_names      = ["adha-root-ca"]
      pick_host_name_from_backend_address = false
      host_name                           = "dhp-app-qa3.adha.gov.ae"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-qa3-react-probe"
    },
    {
      name                  = "dhp-dev-storybook-backend-setting"
      cookie_based_affinity = "Disabled"
      connection_draining = {
        enabled           = true
        drain_timeout_sec = 60
      }
      pick_host_name_from_backend_address = false
      host_name                           = "ossdevstorybook.z1.web.core.windows.net"
      protocol                            = "Https"
      port                                = 443
      request_timeout                     = 300

      probe_name = "dhp-dev-storybook-probe"
    }
  ]

  ssl_certificates = [
    {
      name = "iskan-api-dev"
      data = data.azurerm_key_vault_secret.dev.value
    },
    {
      name = "iskan-api-uat"
      data = data.azurerm_key_vault_secret.this.value
    },
    {
      name = "iskan-api-pp"
      data = data.azurerm_key_vault_secret.pp.value
    },
    {
      name = "iskan-api-uat2"
      data = data.azurerm_key_vault_secret.uat2.value
    },
    {
      name = "iskan-api-uat3"
      data = data.azurerm_key_vault_secret.uat3.value
    },
    {
      name = "dhp-app-non-prod-cert"
      data = data.azurerm_key_vault_secret.dhp-app-non-prod-cert.value
    },
    {
      name = "camunda-non-prod-cert"
      data = data.azurerm_key_vault_secret.camunda-non-prod-cert.value
    },
    {
      name = "iskan-api-stage"
      data = data.azurerm_key_vault_secret.stage.value
    }
  ]

  http_listeners = [
    {
      name                           = "iskan-dev-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-dev.adha.gov.ae",
        "iskan-api-dev.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-dev"
    },
    {
      name                           = "iskan-qa-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-uat.adha.gov.ae",
        "iskan-api-uat.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-uat"
    },
    {
      name                           = "iskan-pp-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-nonprod.adha.gov.ae",
        "iskan-api-nonprod.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-pp"
    },
    {
      name                           = "iskan-qa2-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-uat2.adha.gov.ae",
        "iskan-api-uat2.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-uat2"
    },
    {
      name                           = "iskan-qa3-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-uat3.adha.gov.ae",
        "iskan-api-uat3.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-uat3"
    },
    {
      name                           = "dhp-dev-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda-dev.adha.ae",
        "camunda-dev.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-non-prod-cert"
    },
    {
      name                           = "dhp-qa2-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda-qa2.adha.ae",
        "camunda-qa2.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-non-prod-cert"
    },
    {
      name                           = "dhp-qa-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda-qa.adha.ae",
        "camunda-qa.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-non-prod-cert"
    },
    {
      name                           = "dhp-pp-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda-pp.adha.ae",
        "camunda-pp.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-non-prod-cert"
    },
    {
      name                           = "dhp-qa3-camunda-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "camunda-qa3.adha.ae",
        "camunda-qa3.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "camunda-non-prod-cert"
    },
    {
      name                           = "dhp-dev-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app-dev.adha.ae",
        "dhp-app-dev.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-non-prod-cert"
    },
    {
      name                           = "dhp-qa2-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app-qa2.adha.ae",
        "dhp-app-qa2.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-non-prod-cert"
    },
    {
      name                           = "dhp-qa-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app-qa.adha.ae",
        "dhp-app-qa.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-non-prod-cert"
    },
    {
      name                           = "dhp-pp-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app-pp.adha.ae",
        "dhp-app-pp.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-non-prod-cert"
    },
    {
      name                           = "dhp-qa3-react-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "dhp-app-qa3.adha.ae",
        "dhp-app-qa3.adha.gov.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "dhp-app-non-prod-cert"
    },
    {
      name                           = "iskan-stage-apim-https-private-listener"
      frontend_ip_configuration_name = join("-", [local.app_gw_name, "private-frontend-ip"])
      frontend_port_name             = "port_4433"
      protocol                       = "Https"
      host_names = [
        "iskan-api-stage.adha.gov.ae",
        "iskan-api-stage.adha.ae"
      ]
      require_sni          = false
      ssl_certificate_name = "iskan-api-stage"
    }

  ]

  redirect_configurations = [
    {
      name                 = "iskan-dev-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api-dev.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "iskan-qa-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api-uat.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "iskan-pp-redirect_configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api-nonprod.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "iskan-qa2-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api-uat2.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "iskan-qa3-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://iskan-api-uat3.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-dev-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda-dev.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa2-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda-qa2.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda-qa.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-pp-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda-pp.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa3-camunda-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://camunda-qa3.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-dev-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app-dev.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa2-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app-qa2.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app-qa.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-pp-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app-pp.adha.gov.ae"
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "dhp-qa3-react-redirect-configuration"
      type                 = "Permanent"
      target_url           = "https://dhp-app-qa3.adha.gov.ae"
      include_path         = true
      include_query_string = true
    }
  ]

  request_routing_rules = [
    {
      name                       = "iskan-qa-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 300
      http_listener_name         = "iskan-qa-apim-https-private-listener"
      backend_address_pool_name  = "iskan-qa-apim-backend-pool"
      backend_http_settings_name = "iskan-qa-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "iskan-pp-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 600
      http_listener_name         = "iskan-pp-apim-https-private-listener"
      backend_address_pool_name  = "iskan-pp-apim-backend-pool"
      backend_http_settings_name = "iskan-pp-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "iskan-qa2-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 900
      http_listener_name         = "iskan-qa2-apim-https-private-listener"
      backend_address_pool_name  = "iskan-qa2-apim-backend-pool"
      backend_http_settings_name = "iskan-qa2-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "iskan-dev-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1200
      http_listener_name         = "iskan-dev-apim-https-private-listener"
      backend_address_pool_name  = "iskan-dev-apim-backend-pool"
      backend_http_settings_name = "iskan-dev-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "iskan-qa3-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1500
      http_listener_name         = "iskan-qa3-apim-https-private-listener"
      backend_address_pool_name  = "iskan-qa3-apim-backend-pool"
      backend_http_settings_name = "iskan-qa3-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-dev-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1600
      http_listener_name         = "dhp-dev-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-dev-nginx-backend-pool"
      backend_http_settings_name = "dhp-dev-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa2-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1800
      http_listener_name         = "dhp-qa2-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-qa2-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa2-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1700
      http_listener_name         = "dhp-qa-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-qa-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa-react-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 1900
      http_listener_name         = "dhp-qa-react-https-private-listener"
      backend_address_pool_name  = "dhp-qa-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa-react-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                  = "dhp-dev-react-https-private-routing-rule"
      rule_type             = "PathBasedRouting"
      priority              = 2000
      http_listener_name    = "dhp-dev-react-https-private-listener"
      url_path_map_name     = "dhp-dev-storybook-url-path"
      rewrite_rule_set_name = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa2-react-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2400
      http_listener_name         = "dhp-qa2-react-https-private-listener"
      backend_address_pool_name  = "dhp-qa2-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa2-react-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-pp-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2100
      http_listener_name         = "dhp-pp-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-pp-nginx-backend-pool"
      backend_http_settings_name = "dhp-pp-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa3-camunda-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2500
      http_listener_name         = "dhp-qa3-camunda-https-private-listener"
      backend_address_pool_name  = "dhp-qa3-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa3-camunda-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-pp-react-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2200
      http_listener_name         = "dhp-pp-react-https-private-listener"
      backend_address_pool_name  = "dhp-pp-nginx-backend-pool"
      backend_http_settings_name = "dhp-pp-react-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "dhp-qa3-react-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2600
      http_listener_name         = "dhp-qa3-react-https-private-listener"
      backend_address_pool_name  = "dhp-qa3-nginx-backend-pool"
      backend_http_settings_name = "dhp-qa3-react-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    },
    {
      name                       = "iskan-stage-apim-https-private-routing-rule"
      rule_type                  = "Basic"
      priority                   = 2300
      http_listener_name         = "iskan-stage-apim-https-private-listener"
      backend_address_pool_name  = "iskan-pp-apim-backend-pool"
      backend_http_settings_name = "iskan-pp-apim-backend-setting"
      rewrite_rule_set_name      = "Strict-Transport-Security"
    }
  ]

  url_path_maps = [
    {
      name                               = "dhp-dev-storybook-url-path"
      default_backend_address_pool_name  = "dhp-dev-nginx-backend-pool"
      default_backend_http_settings_name = "dhp-dev-react-backend-setting"
      path_rule = [
        {
          name                       = "storybook"
          paths                      = ["/storybook/*"]
          backend_address_pool_name  = "dhp-dev-storybook-backend-pool"
          backend_http_settings_name = "dhp-dev-storybook-backend-setting"
        }
      ]
    }
  ]

  probes = [
    {
      name                                      = "iskan-dev-apim-probe"
      protocol                                  = "Http"
      host                                      = "oss-dev-apim-bt.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "iskan-qa-apim-probe"
      protocol                                  = "Http"
      host                                      = "iskan-qa-apim.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "iskan-pp-apim-probe"
      protocol                                  = "Http"
      host                                      = "iskan-pp-apim.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "iskan-qa2-apim-probe"
      protocol                                  = "Http"
      host                                      = "iskan-qa2-apim.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "iskan-qa3-apim-probe"
      protocol                                  = "Http"
      host                                      = "iskan-qa3-apim.azure-api.net"
      pick_host_name_from_backend_http_settings = false
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/status-0123456789abcdef"
    },
    {
      name                                      = "dhp-dev-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-qa2-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-qa-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-pp-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-qa3-camunda-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/healthz"
    },
    {
      name                                      = "dhp-dev-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
    {
      name                                      = "dhp-qa2-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
    {
      name                                      = "dhp-qa-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
    {
      name                                      = "dhp-pp-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
    {
      name                                      = "dhp-qa3-react-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/"
    },
    {
      name                                      = "dhp-dev-storybook-probe"
      protocol                                  = "Https"
      host                                      = ""
      pick_host_name_from_backend_http_settings = true
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      path                                      = "/storybook/index.html"
    }
  ]

  alerts                      = [for alert in var.alerts : merge(alert, { action_group = var.non_prod_action_group })]
  default_alerts_action_group = var.non_prod_action_group

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
      ServiceClass = "non-prod"
    }
  )
}
