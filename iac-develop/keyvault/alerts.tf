resource "azurerm_monitor_metric_alert" "keyvault_availability_alert" {
  name                = "${var.basename}-${terraform.workspace}-keyvault-availability-alert"
  resource_group_name = azurerm_key_vault.this.resource_group_name
  scopes              = [azurerm_key_vault.this.id]
  severity            = 0
  window_size         = "PT15M"
  frequency           = "PT15M"

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  } 
}


resource "azurerm_monitor_metric_alert" "keyvault_saturation_alert" {
  name                = "${var.basename}-${terraform.workspace}-keyvault-saturation-alert"
  resource_group_name = azurerm_key_vault.this.resource_group_name
  scopes              = [azurerm_key_vault.this.id]
  severity            = 2
  window_size         = "PT15M"
  frequency           = "PT15M"

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "SaturationShoebox"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  } 
}


resource "azurerm_monitor_metric_alert" "api_latency_alert" {
  name                = "${var.basename}-${terraform.workspace}-keyvault-api-latency-alert"
  resource_group_name = azurerm_key_vault.this.resource_group_name
  scopes              = [azurerm_key_vault.this.id]
  severity            = 2
  window_size         = "PT15M"
  frequency           = "PT15M"
 
  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "ServiceApiLatency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1000
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  } 
}


resource "azurerm_monitor_metric_alert" "service_api_hit_alert" {
  name                = "${var.basename}-${terraform.workspace}-keyvault-service-api-hit-alert"
  resource_group_name = azurerm_key_vault.this.resource_group_name
  scopes              = [azurerm_key_vault.this.id]
  severity            = 3
  window_size         = "PT15M"
  frequency           = "PT15M"

  dynamic_criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "ServiceApiHit"
    aggregation      = "Total"
    operator         = "GreaterThan"
    alert_sensitivity = "High"
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  } 
}



  
