resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location


  firewall_policy_id = var.firewall_policy_id
  enable_http2       = var.enable_http2
  zones              = var.zones

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  autoscale_configuration {
    min_capacity = var.autoscale_configuration.min_capacity
    max_capacity = var.autoscale_configuration.max_capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = frontend_ip_configuration.value.subnet_id
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
      public_ip_address_id          = frontend_ip_configuration.value.public_ip_address_id
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses
      fqdns        = backend_address_pool.value.fqdns
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                           = backend_http_settings.value.name
      cookie_based_affinity          = backend_http_settings.value.cookie_based_affinity
      probe_name                     = backend_http_settings.value.probe_name
      affinity_cookie_name           = "ApplicationGatewayAffinity"
      trusted_root_certificate_names = try(backend_http_settings.value.trusted_root_certificate_names, [])
      dynamic "connection_draining" {
        for_each = tolist([backend_http_settings.value.connection_draining])
        content {
          enabled           = connection_draining.value.enabled
          drain_timeout_sec = connection_draining.value.drain_timeout_sec
        }
      }
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      host_name                           = backend_http_settings.value.host_name
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.key_vault_secret_id
      data                = ssl_certificate.value.data
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = { for root_certificate in var.trusted_root_certificates : root_certificate.name => root_certificate }
    content {
      name                = trusted_root_certificate.value.name
      key_vault_secret_id = trusted_root_certificate.value.key_vault_secret_id
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      require_sni                    = http_listener.value.require_sni
      host_names                     = http_listener.value.host_names
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configurations
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.type
      target_url           = redirect_configuration.value.target_url
      target_listener_name = redirect_configuration.value.listener
      include_path         = redirect_configuration.value.include_path
      include_query_string = redirect_configuration.value.include_query_string
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      priority                    = request_routing_rule.value.priority
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_maps
    content {
      name                               = url_path_map.value.name
      default_backend_address_pool_name  = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name
      dynamic "path_rule" {
        for_each =  url_path_map.value["path_rule"]
        content {
          name                       = path_rule.value.name
          paths                      = path_rule.value.paths
          backend_address_pool_name  = path_rule.value.backend_address_pool_name
          backend_http_settings_name = path_rule.value.backend_http_settings_name
        }    
    }
    } 
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_set
    content {
      name = rewrite_rule_set.value.name
      rewrite_rule {
        name          = rewrite_rule_set.value.header_name
        rule_sequence = rewrite_rule_set.value.rule_sequence

        response_header_configuration {
          header_name  = rewrite_rule_set.value.header_name
          header_value = rewrite_rule_set.value.header_value
        }
      }
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      host                                      = probe.value.pick_host_name_from_backend_http_settings ? null : probe.value.host
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      path                                      = probe.value.path
      match {
        status_code = [
          "200-399",
        ]
      }
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  for_each                = { for alert in var.alerts : alert.name => alert }
  name                    = "${azurerm_application_gateway.this.name}-${each.value.name}"
  resource_group_name     = var.resource_group_name
  location                = var.location
  evaluation_frequency    = each.value.evaluation_frequency
  scopes                  = [azurerm_application_gateway.this.id]
  severity                = each.value.severity
  window_duration         = each.value.window_duration
  description             = each.value.description
  display_name            = "${azurerm_application_gateway.this.name}-${each.value.name}"
  auto_mitigation_enabled = true
  action {
    action_groups = [data.azurerm_monitor_action_group.this["${each.value.name}-${each.value.action_group}"].id]
  }
  criteria {
    operator                = each.value.operator
    query                   = each.value.query
    threshold               = each.value.threshold
    time_aggregation_method = each.value.time_aggregation_method
  }
  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${azurerm_application_gateway.this.name}-diagnostic-setting"
  target_resource_id         = azurerm_application_gateway.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "prod" {
  for_each                   = var.prod_diagnostic_settings
  name                       = "${azurerm_application_gateway.this.name}-${each.key}-prod-diagnostic-setting"
  target_resource_id         = azurerm_application_gateway.this.id
  log_analytics_workspace_id = each.value
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
    }
  }  
}

resource "azurerm_monitor_metric_alert" "unhealthy_backend" {
  name                = "${azurerm_application_gateway.this.name}-unhealthy-backend-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "UnhealthyHostCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }
}

resource "azurerm_monitor_metric_alert" "failed_requests" {
  name                = "${azurerm_application_gateway.this.name}-failed-requests-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "FailedRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0
  }
}

resource "azurerm_monitor_metric_alert" "total_time_grater_than_10s" {
  name                = "${azurerm_application_gateway.this.name}-total-time-10s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ApplicationGatewayTotalTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 10000
  }
}

resource "azurerm_monitor_metric_alert" "total_time_grater_than_5s" {
  name                = "${azurerm_application_gateway.this.name}-total-time-5s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ApplicationGatewayTotalTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5000
  }
}

resource "azurerm_monitor_metric_alert" "total_time_grater_than_3s" {
  name                = "${azurerm_application_gateway.this.name}-total-time-3s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 2
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ApplicationGatewayTotalTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 3000
  }
}

resource "azurerm_monitor_metric_alert" "backend_first_byte_greater_than_5s" {
  name                = "${azurerm_application_gateway.this.name}-first-byte-5s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendFirstByteResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5000
  }
}

resource "azurerm_monitor_metric_alert" "backend_first_byte_greater_than_3s" {
  name                = "${azurerm_application_gateway.this.name}-first-byte-3s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendFirstByteResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 3000
  }
}

resource "azurerm_monitor_metric_alert" "backend_last_byte_greater_than_8s" {
  name                = "${azurerm_application_gateway.this.name}-last-byte-8s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendLastByteResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 8000
  }
}

resource "azurerm_monitor_metric_alert" "backend_last_byte_greater_than_5s" {
  name                = "${azurerm_application_gateway.this.name}-last-byte-5s-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendLastByteResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5000
  }
}

resource "azurerm_monitor_metric_alert" "client_rtt_greater_than_500_millisecond" {
  name                = "${azurerm_application_gateway.this.name}-client-rtt-500-millisecond-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ClientRtt"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 500
  }
}

resource "azurerm_monitor_metric_alert" "client_rtt_greater_than_300_millisecond" {
  name                = "${azurerm_application_gateway.this.name}-client-rtt-300-millisecond-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ClientRtt"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 300
  }
}

resource "azurerm_monitor_metric_alert" "client_rtt_greater_than_200_millisecond" {
  name                = "${azurerm_application_gateway.this.name}-client-rtt-200-millisecond-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 2
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ClientRtt"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 200
  }
}

resource "azurerm_monitor_metric_alert" "current_connections" {
  name                = "${azurerm_application_gateway.this.name}-current-connections-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.this.id]
  severity            = 2
  action {
    action_group_id = data.azurerm_monitor_action_group.this["default"].id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Network/applicationGateways"
    metric_name       = "CurrentConnections"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "Medium"
  }
}

