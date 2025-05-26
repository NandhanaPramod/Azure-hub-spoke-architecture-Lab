resource "azurerm_monitor_metric_alert" "capacity_usage_sev0" {
  name                = join("-", [var.project, var.environment, var.apim_name, "capacity-usage-sev0"])
  description         = "Alert Whenever the average Capacity Usage is greater"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 0
  window_size         = "PT15M"
  frequency           = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ApiManagement/service"
    metric_name      = "Capacity"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = 95
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}


resource "azurerm_monitor_metric_alert" "capacity_usage_sev1" {
  name                = join("-", [var.project, var.environment, var.apim_name, "capacity-usage-sev1"])
  description         = "Alert Whenever the average Capacity Usage is greater"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 1
  window_size         = "PT15M"
  frequency           = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ApiManagement/service"
    metric_name      = "Capacity"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = 80
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_metric_alert" "backend_request_sev0" {
  name                = join("-", [var.project, var.environment, var.apim_name, "backend-request-sev0"])
  description         = "Alert Whenever the average Duration of Backend Requests is greater"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 0
  window_size         = "PT15M"
  frequency           = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ApiManagement/service"
    metric_name      = "BackendDuration"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 6000
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}


resource "azurerm_monitor_metric_alert" "backend_request_sev1" {
  name                = join("-", [var.project, var.environment, var.apim_name, "backend-request-sev1"])
  description         = "Alert Whenever the average Duration of Backend Requests is greater"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 1
  window_size         = "PT15M"
  frequency           = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ApiManagement/service"
    metric_name      = "BackendDuration"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 3000
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_metric_alert" "request_sev1" {
  name                = join("-", [var.project, var.environment, var.apim_name, "total-request-sev1"])
  description         = "Alert Whenever the Request is greater than threshold"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 1
  window_size         = "PT15M"
  frequency           = "PT5M"
  dynamic_criteria {
    metric_namespace  = "Microsoft.ApiManagement/service"
    metric_name       = "Requests"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_metric_alert" "request_sev2" {
  name                = join("-", [var.project, var.environment, var.apim_name, "total-request-sev2"])
  description         = "Alert Whenever the Request is greater than threshold"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [azurerm_api_management.apim.id]
  severity            = 2
  window_size         = "PT30M"
  frequency           = "PT15M"
  dynamic_criteria {
    metric_namespace  = "Microsoft.ApiManagement/service"
    metric_name       = "Requests"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

