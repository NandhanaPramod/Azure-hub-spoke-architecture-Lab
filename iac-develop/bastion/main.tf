resource "azurerm_public_ip" "this" {
  name                = local.ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "this" {
  name                = local.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.this.id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name = "${local.ip_name}-pip-diagnostic-setting"
  target_resource_id = azurerm_public_ip.this.id
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
