resource "azurerm_recovery_services_vault" "vault" {
  name                = "${var.basename}-${var.environment}-recovery-vault"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "Standard"
  soft_delete_enabled = true

  tags = local.tags
}

resource "azurerm_backup_policy_vm" "this" {
  name                = "Custom-recovery-vault-policy"
  resource_group_name = data.azurerm_resource_group.this.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  timezone = "Arabian Standard Time"

  backup {
    frequency = "Daily"
    time      = "02:00"
  }

  retention_daily {
    count = 10
  }

  retention_weekly {
    count    = 12
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.basename}-${var.environment}-rsv-diagnostic-setting"
  target_resource_id         = azurerm_recovery_services_vault.vault.id
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