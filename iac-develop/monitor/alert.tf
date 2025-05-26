resource "azurerm_monitor_metric_alert" "availability" {   
  count               = var.availability_tests ? 1 : 0 
  name                = local.app_insights_name_availability
  description         = "Availability alert of application insights when 3rd PARTY DOWN"
  resource_group_name =var.create_resource_group  ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  scopes              = [azurerm_application_insights.this.id]
  severity            = 0
  window_size         = "PT30M"
  frequency           = "PT5M"

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        =  100
      dimension {
      name     = "availabilityResult/name"
      operator = "Include"
      values   = ["*"]
    } 
  }
  action {
    action_group_id = azurerm_monitor_action_group.this["infra-alerts"].id
  }
}
