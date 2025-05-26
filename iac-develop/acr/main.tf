resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_container_registry" "this" {
  name                = var.registry_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.sku
  admin_enabled       = true
  georeplications {
    location                  = var.replication_location
    zone_redundancy_enabled   = false
    regional_endpoint_enabled = true
    tags                      = local.tags
  }
  dynamic "network_rule_set" {
    for_each = length(toset(var.allowed_ips)) == 0 ? [] : [1]
    content {
      default_action = "Deny"
      dynamic "ip_rule" {
        for_each = toset(var.allowed_ips)
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.registry_name}-diagnostic-setting"
  target_resource_id         = azurerm_container_registry.this.id
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

resource "azurerm_private_endpoint" "this" {
  name                = "${azurerm_container_registry.this.name}-private-endpoint"
  location            = var.location
  resource_group_name = var.virtual_network_resource_group
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = "${azurerm_container_registry.this.name}-service-connection"
    private_connection_resource_id = azurerm_container_registry.this.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }

  tags = local.tags
}