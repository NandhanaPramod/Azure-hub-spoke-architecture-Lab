resource "azurerm_monitor_activity_log_alert" "p1" {
  name                = "${var.basename}-${var.environment}-service-health-P1-alert"
  resource_group_name = local.resource_group_name
  scopes              = ["/subscriptions/${data.azurerm_subscription.current.subscription_id}"]

  tags = local.tags
  criteria {
    category = "ServiceHealth"
    service_health {
      events    = ["Incident", "Security"]
      locations = ["UAE North", "UAE Central"]
    }
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_activity_log_alert" "p2" {
  name                = "${var.basename}-${var.environment}-service-health-P2-alert"
  resource_group_name = local.resource_group_name
  scopes              = ["/subscriptions/${data.azurerm_subscription.current.subscription_id}"]

  tags = local.tags
  criteria {
    category = "ServiceHealth"
    service_health {
      events    = ["Maintenance", "ActionRequired"]
      locations = ["UAE North", "UAE Central"]
    }
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_activity_log_alert" "p3" {
  name                = "${var.basename}-${var.environment}-service-health-P3-alert"
  resource_group_name = local.resource_group_name
  scopes              = ["/subscriptions/${data.azurerm_subscription.current.subscription_id}"]

  tags = local.tags
  criteria {
    category = "ServiceHealth"
    service_health {
      events    = ["Informational"]
      locations = ["UAE North", "UAE Central"]
    }
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
}
