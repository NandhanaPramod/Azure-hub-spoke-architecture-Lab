resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = local.keyvault_resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_key_vault" "this" {
  name                       = local.keyvault_name
  location                   = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  resource_group_name        = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  sku_name                   = var.keyvault_sku
  tenant_id                  = data.azurerm_client_config.this.tenant_id
  soft_delete_retention_days = var.soft_delete_retention_days
  enable_rbac_authorization  = var.enable_rbac_authorization
  purge_protection_enabled   = var.purge_protection_enabled
  network_acls {
    bypass                     = var.allow_azure_services_bypass_firewall ? "AzureServices" : "None"
    default_action             = var.default_action
    ip_rules                   = var.allowed_ips
    virtual_network_subnet_ids = [for subnet in data.azurerm_subnet.this : subnet.id]
  }

  tags = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${local.keyvault_name}-diagnostic-setting"
  target_resource_id         = azurerm_key_vault.this.id
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

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
      enabled  = true
      retention_policy {
        days    = 0
        enabled = true
      }

    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "prod-diagnostic" {
  count                      =  var.prod_diagnostic_settings ? 1 : 0
  name                       = "${local.keyvault_name}-prod-diagnostic-setting"
  target_resource_id         = azurerm_key_vault.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.prod.id
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

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
      enabled  = true
      retention_policy {
        days    = 0
        enabled = true
      }

    }
  }
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.key_vault_admin
}

resource "azurerm_private_endpoint" "this" {
  name                = "${azurerm_key_vault.this.name}-private-endpoint"
  location            = var.location
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  subnet_id           = data.azurerm_subnet.private_link_subnet.id

  private_service_connection {
    name                           = "${azurerm_key_vault.this.name}-service-connection"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "sas-function-role" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_linux_function_app.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "key-vault-secret-access-service-principal" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.this.object_id
}

resource "azurerm_role_assignment" "key-vault-access-service-principal" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "EventGrid EventSubscription Contributor"
  principal_id         = data.azurerm_client_config.this.object_id
}

resource "azurerm_role_assignment" "function-access-service-principal" {
  provider             = azurerm.dns_zone
  scope                = data.azurerm_linux_function_app.this.id
  role_definition_name = "Website Contributor"
  principal_id         = data.azurerm_client_config.this.object_id
}

resource "azurerm_eventgrid_event_subscription" "sas-function-subscription" {
  depends_on = [
    azurerm_role_assignment.function-access-service-principal,
    azurerm_role_assignment.key-vault-access-service-principal
  ]
  count                = terraform.workspace == "hub" ? 0 : 1
  name                 = "${var.sas_rotation_function_app}-subscription"
  scope                = azurerm_key_vault.this.id
  included_event_types = ["Microsoft.KeyVault.SecretExpired"]
  subject_filter {
    subject_begins_with = var.sas_token_secret
  }
  azure_function_endpoint {
    function_id          = "${data.azurerm_linux_function_app.this.id}/functions/${var.sas_rotation_function}"
    max_events_per_batch = 1
  }
  retry_policy {
    max_delivery_attempts = 10
    event_time_to_live    = 360
  }
}

resource "azurerm_role_assignment" "certs-managed-identity" {
  for_each             = var.managed_identity_with_certs_permission
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "secrets-managed-identity" {
  for_each             = var.managed_identity_with_secrets_permission
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}