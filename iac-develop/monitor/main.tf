resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = local.monitor_resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  location            = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_in_days
  daily_quota_gb      = var.log_analytics_daily_quota_gb

  tags = local.tags
}

resource "azurerm_log_analytics_workspace" "audit_logs" {
  name                = local.audit_log_analytics_workspace_name
  location            = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  sku                 = var.log_analytics_sku
  retention_in_days   = var.audit_log_analytics_retention_in_days
  daily_quota_gb      = var.log_analytics_daily_quota_gb

  tags = local.tags
}

resource "azurerm_application_insights" "this" {
  name                = local.app_insights_name
  location            = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  application_type    = "Node.JS"
  workspace_id        = azurerm_log_analytics_workspace.this.id
  retention_in_days   = var.app_insights_retention_in_days

  tags = local.tags
}

resource "azurerm_application_insights" "audit_logs" {
  name                = local.audit_app_insights_name
  location            = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  application_type    = "Node.JS"
  workspace_id        = azurerm_log_analytics_workspace.audit_logs.id
  retention_in_days   = var.audit_log_analytics_retention_in_days

  tags = local.tags
}

resource "azurerm_monitor_action_group" "this" {
  for_each            = { for group in var.action_groups : group.name => group }
  name                = "${var.basename}-${terraform.workspace}-${each.value.name}"
  resource_group_name = join("_", [var.basename, terraform.workspace])
  short_name          = each.value.name
  dynamic "email_receiver" {
    for_each = each.value.email_adresses
    content {
      name          = split("@", email_receiver.value)[0]
      email_address = email_receiver.value
    }
  }

  tags = local.tags
}

