data "azurerm_resource_group" "this" {
  name = "${var.basename}_${var.environment}"
}

data "azurerm_subnet" "this" {
  name                 = join("_", [var.basename, var.environment, "api"])
  virtual_network_name = join("_", [var.basename, var.environment, "vnet"])
  resource_group_name  = data.azurerm_resource_group.this.name
}

data "azurerm_application_insights" "this" {
  name                = join("-", [var.basename, var.environment, "app", "insights"])
  resource_group_name = var.basename == "iskan" ? data.azurerm_resource_group.this.name : join("-", [var.basename, var.environment, "monitor", "rg"])
}

resource "azurerm_api_management" "apim" {
  location             = data.azurerm_resource_group.this.location
  name                 = join("-", [var.project, var.environment, var.apim_name])
  publisher_email      = var.publisher_email
  publisher_name       = var.publisher_name
  resource_group_name  = data.azurerm_resource_group.this.name
  sku_name             = var.sku_name
  virtual_network_type = var.virtual_network_type

  identity {
    type = "SystemAssigned"
  }

  protocols {
    enable_http2 = true
  }

  sign_up {
    enabled = true

    terms_of_service {
      consent_required = false
      enabled          = false
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type == "Internal" ? [1] : []
    content {
      subnet_id = data.azurerm_subnet.this.id
    }
  }

  lifecycle {
    ignore_changes = [hostname_configuration]
  }

  tags = local.tags
}

resource "azurerm_api_management_product" "product" {
  for_each = {
    for apim_product in var.apim_product : apim_product.product_id => apim_product
  }
  product_id            = each.value.product_id
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.this.name
  display_name          = each.value.display_name
  subscriptions_limit   = each.value.subscriptions_limit
  subscription_required = each.value.subscription_required
  approval_required     = each.value.approval_required
  published             = each.value.published

  depends_on = [azurerm_api_management.apim]
}

resource "azurerm_api_management_product_policy" "product_policy" {
  for_each = {
    for apim_product in var.apim_product : apim_product.product_id => apim_product
    if apim_product.product_policy_content != ""
  }
  product_id          = azurerm_api_management_product.product[each.value.product_id].product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.this.name
  xml_content = templatefile("${each.value.product_policy_content}", {
    ratelimit        = var.ratelimit
    ratelimitrenewal = var.ratelimitrenewal
    allowedIPs       = join(",", var.allowedIPs)
  })
}

resource "azurerm_api_management_logger" "logger" {
  name                = "${var.project}-${var.environment}-logger"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.this.name
  resource_id         = data.azurerm_application_insights.this.id

  application_insights {
    instrumentation_key = data.azurerm_application_insights.this.instrumentation_key
  }
}

resource "azurerm_api_management_named_value" "this" {
  for_each            = var.named_values
  name                = each.key
  resource_group_name = data.azurerm_resource_group.this.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = each.key
  value               = each.value

  tags = values(local.tags)
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.basename}-${var.environment}-diagnostic-setting"
  target_resource_id         = azurerm_api_management.apim.id
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

resource "azurerm_api_management_subscription" "this" {
  for_each            = { for subscription in var.subscriptions : subscription.name => subscription }
  api_management_name = azurerm_api_management.apim.name
  display_name        = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
  product_id          = azurerm_api_management_product.product[each.value.product_id].id
  subscription_id     = lower("${azurerm_api_management_product.product[each.value.product_id].display_name}-${each.value.name}")
  allow_tracing       = each.value.allow_tracing
  state               = "active"
}

resource "azurerm_private_dns_a_record" "this" {
  provider            = azurerm.dns_zone
  name                = azurerm_api_management.apim.name
  resource_group_name = var.private_dns_zone_rg
  zone_name           = var.private_dns_zone
  ttl                 = 3600
  records             = azurerm_api_management.apim.private_ip_addresses
}