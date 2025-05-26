resource "azurerm_storage_account" "this" {
  for_each                          = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                              = local.storage_account_name[each.value.name_suffix]
  resource_group_name               = local.resource_group_name
  location                          = var.location
  account_kind                      = each.value.account_kind
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  access_tier                       = each.value.access_tier
  nfsv3_enabled                     = each.value.nfsv3_enabled
  is_hns_enabled                    = each.value.is_hns_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  dynamic "network_rules" {
    for_each = length(each.value.allowed_services) == 0 && length(each.value.subnet_names) == 0 ? [] : [1]
    content {
      default_action             = "Deny"
      bypass                     = length(each.value.allowed_services) == 0 ? ["None"] : each.value.allowed_services
      virtual_network_subnet_ids = [for subnet in each.value.subnet_names : data.azurerm_subnet.this["${each.value.name_suffix}-${subnet}"].id]
      ip_rules                   = each.value.allowed_ips
    }
  }
  dynamic "static_website" {
    for_each = each.value.static_website_enabled == true ? [1] : []
    content {
      index_document = each.value.static_website_index_document
    }
  }
  tags = local.tags
}

resource "azurerm_storage_container" "this" {
  for_each              = { for container in local.containers : "${container.name_suffix}-${container.container_name}" => container }
  name                  = each.value.container_name
  storage_account_name  = azurerm_storage_account.this[each.value.name_suffix].name
  container_access_type = each.value.container_access_type
}

resource "azurerm_private_endpoint" "this" {
  for_each            = { for zone in local.private_dns_zone : "${zone.name_suffix}-${zone.private_dns_zone}" => zone }
  name                = each.value.subresource_name != "blob" ? "${azurerm_storage_account.this[each.value.name_suffix].name}-${each.value.subresource_name}-private-endpoint" : "${azurerm_storage_account.this[each.value.name_suffix].name}-private-endpoint"
  location            = var.location
  resource_group_name = local.resource_group_name
  subnet_id           = data.azurerm_subnet.this["${each.value.name_suffix}-${each.value.private_endpoint_subnet}"].id

  private_service_connection {
    name                           = "${azurerm_storage_account.this[each.value.name_suffix].name}-service-connection"
    private_connection_resource_id = azurerm_storage_account.this[each.value.name_suffix].id
    is_manual_connection           = false
    subresource_names              = [each.value.subresource_name]
  }

  private_dns_zone_group {
    name                 = each.value.private_dns_zone
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this["${each.value.name_suffix}-${each.value.private_dns_zone}"].id]
  }
}

resource "azurerm_storage_share" "this" {
  depends_on           = [azurerm_private_endpoint.this]
  for_each             = { for file_share in local.file_shares : "${file_share.name_suffix}-${file_share.file_share_name}" => file_share }
  name                 = each.value.file_share_name
  storage_account_name = azurerm_storage_account.this[each.value.name_suffix].name
  quota                = each.value.quota
}

resource "azurerm_role_assignment" "sas-function-role" {
  for_each             = toset([for sa in var.storage_accounts : sa.name_suffix if sa.name_suffix == "media"])
  scope                = azurerm_storage_account.this[each.key].id
  role_definition_name = "Storage Account Contributor"
  principal_id         = data.azurerm_linux_function_app.this.identity[0].principal_id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each                   = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                       = "${var.basename}-${terraform.workspace}-sa-diagnostic-settings"
  target_resource_id         = data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}


resource "azurerm_monitor_diagnostic_setting" "blob" {
  for_each                   = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                       = "${var.basename}-${terraform.workspace}-sa-diagnostic-settings-blob"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/blobServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.blob[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.blob[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "queue" {
  for_each                   = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                       = "${var.basename}-${terraform.workspace}-sa-diagnostic-settings-queue"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/queueServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.queue[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.queue[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "table" {
  for_each                   = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                       = "${var.basename}-${terraform.workspace}-sa-diagnostic-settings-table"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/tableServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.table[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.table[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "file" {
  for_each                   = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                       = "${var.basename}-${terraform.workspace}-sa-diagnostic-settings-file"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/fileServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.file[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.file[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "prod-diagnostic" {
  for_each                   = var.prod_diagnostic_settings ? { for sa in var.storage_accounts : sa.name_suffix => sa } : {}
  name                       = "${var.basename}-${terraform.workspace}-sa-prod-diagnostic-settings"
  target_resource_id         = data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id
  dynamic "log" {
    for_each =  data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].logs 
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "prod-blob" {
  for_each                   = var.prod_diagnostic_settings ? { for sa in var.storage_accounts : sa.name_suffix => sa } : {}
  name                       = "${var.basename}-${terraform.workspace}-sa-prod-diagnostic-settings-blob"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/blobServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.blob[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.blob[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "prod-queue" {
  for_each                   = var.prod_diagnostic_settings ? { for sa in var.storage_accounts : sa.name_suffix => sa } : {}
  name                       = "${var.basename}-${terraform.workspace}-sa-prod-diagnostic-settings-queue"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/queueServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.queue[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.queue[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "prod-table" {
  for_each                   = var.prod_diagnostic_settings ? { for sa in var.storage_accounts : sa.name_suffix => sa } : {}
  name                       = "${var.basename}-${terraform.workspace}-sa-prod-diagnostic-settings-table"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/tableServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.table[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.table[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "prod-file" {
  for_each                   = var.prod_diagnostic_settings ? { for sa in var.storage_accounts : sa.name_suffix => sa } : {}
  name                       = "${var.basename}-${terraform.workspace}-sa-prod-diagnostic-settings-file"
  target_resource_id         = "${data.azurerm_monitor_diagnostic_categories.this[each.value.name_suffix].id}/fileServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.file[each.value.name_suffix].logs
    content {
      category = log.value
    }
  }

   dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.file[each.value.name_suffix].metrics
    content {
      category = metric.value
    }
  }

}


resource "azurerm_monitor_metric_alert" "availability" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-availability-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 0
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100
  }
}

resource "azurerm_monitor_metric_alert" "egress" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-egress-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 3
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Storage/storageAccounts"
    metric_name       = "Egress"
    aggregation       = "Average"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "ingress" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-ingress-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 3
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Storage/storageAccounts"
    metric_name       = "Ingress"
    aggregation       = "Average"
    operator          = "GreaterThan"
    alert_sensitivity = "High"
  }
}

resource "azurerm_monitor_metric_alert" "used_capacity" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-used-capacity-10gb-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 2
  frequency           = "PT1H"
  window_size         = "PT6H"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "UsedCapacity"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 10 * 1024 * 1024 * 1024
  }
}

resource "azurerm_monitor_metric_alert" "E2E_latency" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-E2E-latency-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 1
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "SuccessE2ELatency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5000
  }
}

resource "azurerm_monitor_metric_alert" "transaction" {
  for_each            = { for sa in var.storage_accounts : sa.name_suffix => sa }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name_suffix}-sa-transaction-alert"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_storage_account.this[each.value.name_suffix].id]
  severity            = 3
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  dynamic_criteria {
    metric_namespace  = "Microsoft.Storage/storageAccounts"
    metric_name       = "Transactions"
    aggregation       = "Total"
    operator          = "GreaterThan"
    alert_sensitivity = "Medium"
  }
}


