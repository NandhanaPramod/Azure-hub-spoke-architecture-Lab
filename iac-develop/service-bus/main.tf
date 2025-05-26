module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "v6.0.0"

  azure_region = var.location
}

module "servicebus" {
  source  = "claranet/service-bus/azurerm"
  version = "v6.1.0"

  location                     = data.azurerm_resource_group.this.location
  location_short               = module.azure_region.location_short
  client_name                  = var.client_name
  environment                  = var.environment
  stack                        = var.stack
  use_caf_naming               = false
  resource_group_name          = data.azurerm_resource_group.this.name
  servicebus_namespaces_queues = var.servicebus_namespaces_queues_data
  logs_destinations_ids        = [] # keep this list always empty as this caf module doesn't work and uses local-exec

  default_tags_enabled = false
  extra_tags           = local.tags
}

resource "azurerm_servicebus_namespace_network_rule_set" "this" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  namespace_id                  = each.value
  default_action                = "Deny"
  public_network_access_enabled = true
  trusted_services_allowed      = true
  ip_rules                      = var.servicebus_whitelist_ip
}

resource "azurerm_private_endpoint" "this" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }

  name                = "${var.stack}-endpoint"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = "${var.stack}-endpoint-namespace"
    private_connection_resource_id = each.value
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }

  tags = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                       = "${each.key}-diagnostic-setting"
  target_resource_id         = each.value
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_metric_alert" "cpu_greather_than_90" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-cpu-greather-than-90-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "NamespaceCpuUsage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }
}


resource "azurerm_monitor_metric_alert" "cpu_greather_than_70" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-cpu-greather-than-70-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "NamespaceCpuUsage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 70
  }
}

resource "azurerm_monitor_metric_alert" "server_error" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-server-error-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "ServerErrors"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 1
  }
}

resource "azurerm_monitor_metric_alert" "abandoned_messages" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-abandoned-messages-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "AbandonMessage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 1
  }
}

resource "azurerm_monitor_metric_alert" "incoming_requests" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-incoming-requests-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 3

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "IncomingRequests"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "successful_requests" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-successful-requests-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 3

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "SuccessfulRequests"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "user_errors" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-user-error-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 1

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "UserErrors"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "throttled_request" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-throttled-request-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 2

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "ThrottledRequests"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "incoming_messages" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-incoming-messages-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 2

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "IncomingMessages"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "scheduled_messages" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-scheduled-messages-alert"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 2

  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.ServiceBus/namespaces"
    metric_name       = "IncomingMessages"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "Active_messages_sev2" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-Active-messages-alert-sev2"
  description         = "Alert when Count of active messages in a Queue crosses 500"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 2
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "ActiveMessages"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 500
  }
}

resource "azurerm_monitor_metric_alert" "Active_messages_sev1" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  name                = "${each.key}-Active-messages-alert-sev1"
  description         = "Alert when Count of active messages in a Queue crosses 1000"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "ActiveMessages"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1000
  }
}





