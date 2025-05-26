resource "azurerm_redis_cache" "this" {
  name                          = "${var.basename}-${terraform.workspace}-redis"
  location                      = var.location
  resource_group_name           = local.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  enable_non_ssl_port           = var.enable_non_ssl_port
  public_network_access_enabled = var.public_network_access_enabled
  redis_version                 = var.redis_version
  tags                          = local.tags
  redis_configuration {
    enable_authentication = var.enable_authentication
  }
  patch_schedule {
    day_of_week    = var.patch_schedule.day_of_week
    start_hour_utc = var.patch_schedule.start_hour_utc
  }
}

resource "azurerm_private_endpoint" "this" {
  name                = "${azurerm_redis_cache.this.name}-private-endpoint"
  location            = var.location
  resource_group_name = local.resource_group_name
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = "${azurerm_redis_cache.this.name}-service-connection"
    private_connection_resource_id = azurerm_redis_cache.this.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }

  tags = local.tags
}


resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.basename}-${terraform.workspace}-redis-diagnostic-settings"
  target_resource_id         = azurerm_redis_cache.this.id
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

# Create a metric alert for redis server load 60%
resource "azurerm_monitor_metric_alert" "redis-server-load-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-server-load-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  severity            = 2
  description         = "Alert triggered when Redis server load exceeds 60% threshold"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "serverLoad"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 60

  }
}

# Create a metric alert for redis server load 90%
resource "azurerm_monitor_metric_alert" "redis-server-load-alerts" {
  name                = "${var.basename}-${terraform.workspace}-redis-serverload"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  severity            = 1
  description         = "Alert triggered when Redis server load exceeds 90% threshold"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "serverLoad"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

}

# Create a metric alert for Redis cache hits
resource "azurerm_monitor_metric_alert" "redis-cache-hits-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-cache-hits-alert"
  resource_group_name = local.resource_group_name
  description         = "Alert when Redis Cache hits exceed a threshold"
  severity            = 3
  scopes              = [azurerm_redis_cache.this.id]
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "cachehits"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}


# Create a metric alert for Redis cache reads
resource "azurerm_monitor_metric_alert" "redis-cache-read-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-cache-read-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  severity            = 3
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "cacheRead"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 600000
  }
}


# Create a metric alert for Redis expired keys
resource "azurerm_monitor_metric_alert" "redis-cache-expired-keys-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-cache-expired-keys-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  description         = "Alert when Redis Cache expired keys count exceeds a threshold"
  severity            = 2
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "expiredkeys"
    aggregation      = "Total"
    operator         = "GreaterThan"
    alert_sensitivity = "High"
  }
}

# Create a metric alert for cache misses
resource "azurerm_monitor_metric_alert" "redis-cache-misses-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-cache-misses-alert"
  description         = "Alert when cache misses reach a threshold in Redis cache"
  severity            = 3
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "cachemisses"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}


# Create a metric alert for Connected Clients
resource "azurerm_monitor_metric_alert" "connected-clients" {
  name                = "${var.basename}-${terraform.workspace}-redis-client-alert"
  description         = "Alert when connected clients reach a threshold in Redis cache"
  severity            = 3
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "connectedclients"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

# Create a metric alert for Connection created per second
resource "azurerm_monitor_metric_alert" "redis-conn-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-connection-create-alert"
  description         = "Alert when connections created per second exceed a threshold in Redis cache"
  severity            = 3
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "allConnectionsCreatedPerSecond"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}
#
# Create a metric alert for Connection closed alert
resource "azurerm_monitor_metric_alert" "redis-conn-closed-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-connection-closed-alert"
  description         = "Alert when connections closed per second exceed a threshold in Redis cache"
  severity            = 3
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "allConnectionsClosedPerSecond"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

## Create a metric alert for redis operation alert
resource "azurerm_monitor_metric_alert" "redis-ops-alert" {
  name                = "${var.basename}-${terraform.workspace}-redis-operation-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_redis_cache.this.id]
  description         = "Alert when operationsPerSecond exceed a threshold in Redis cache"
  enabled             = true
  severity            = 3
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }

  dynamic_criteria {
    metric_namespace  = "Microsoft.Cache/redis"
    metric_name       = "operationsPerSecond"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

