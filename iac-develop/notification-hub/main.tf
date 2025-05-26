data "azurerm_resource_group" "this" {
  name = "${var.basename}_${var.environment}"
}

locals {
  tags = merge(
    var.default_tags,
    {
      Environment = upper(terraform.workspace)
      Location    = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
}

resource "azurerm_notification_hub_namespace" "this" {
  name                = "${var.basename}-${var.environment}-notificationhub-ns"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location # Notification hub's namespace is not available in "uaenorth"
  namespace_type      = "NotificationHub"

  sku_name = "Standard"
  tags     = local.tags
}

resource "azurerm_notification_hub" "this" {
  name                = "${var.basename}-${var.environment}-notificationhub"
  namespace_name      = azurerm_notification_hub_namespace.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location # Notification hub's namespace is not available in "uaenorth"

  gcm_credential {
    api_key = var.google_api_key
  }

  apns_credential {
    application_mode = var.application_mode
    bundle_id        = var.bundle_id
    key_id           = var.key_id
    team_id          = var.team_id
    token            = var.token
  }
  tags = local.tags
}