resource "azurerm_service_plan" "this" {
  name                         = "${var.function_name}-asp"
  location                     = var.location
  resource_group_name          = local.resource_group_name
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  maximum_elastic_worker_count = 3
  zone_balancing_enabled       = false
}

resource "azurerm_linux_function_app" "this" {
  location                   = var.location
  name                       = "${var.function_name}-func-app"
  resource_group_name        = local.resource_group_name
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.azurerm_storage_account.this.name
  storage_account_access_key = data.azurerm_storage_account.this.primary_access_key
  virtual_network_subnet_id  = data.azurerm_subnet.this.id
  app_settings = {
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = data.azurerm_storage_account.this.primary_connection_string
    WEBSITE_CONTENTSHARE                     = var.file_share_name
    WEBSITE_CONTENTOVERVNET                  = "1"
  }
  site_config {
    application_stack {
      powershell_core_version = "7.2"
    }

    ip_restriction {
      action      = "Allow"
      service_tag = "AzureEventGrid"
    }

    ip_restriction {
      action     = "Deny"
      ip_address = "0.0.0.0/0"
      priority   = 66000
    }

    dynamic "ip_restriction" {
      for_each = var.allowed_ips
      content {
        action     = "Allow"
        ip_address = ip_restriction.value
        priority   = ip_restriction.key
      }
    }

    application_insights_connection_string = data.azurerm_application_insights.this.connection_string
    scm_use_main_ip_restriction            = true
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.function_name}-diagnostic-setting"
  target_resource_id         = azurerm_linux_function_app.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  for_each                = var.monitored_strings
  name                    = "${var.basename}-hub-sas-rotation-${each.key}"
  resource_group_name     = local.resource_group_name
  location                = var.location
  evaluation_frequency    = "PT15M"
  scopes                  = [data.azurerm_application_insights.this.id]
  severity                = 2
  window_duration         = "PT15M"
  description             = "Alert if SAS Rotation function logs contain ${each.value}"
  display_name            = "${var.basename}-hub-sas-rotation-${each.key}"
  auto_mitigation_enabled = true
  action {
    action_groups = [data.azurerm_monitor_action_group.this.id]
  }
  criteria {
    operator                = "GreaterThanOrEqual"
    query                   = <<-QUERY
    traces | where message contains "${each.value}" and cloud_RoleName == "${azurerm_linux_function_app.this.name}"
    QUERY
    threshold               = 1
    time_aggregation_method = "Count"
  }
}