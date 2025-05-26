locals {
  dynarules           = { for rule in var.security_rules : rule.name => rule }
  resource_group_name = var.create_resource_group ? one(azurerm_resource_group.this.*.name) : one(data.azurerm_resource_group.this.*.name)
  location            = var.create_resource_group ? one(azurerm_resource_group.this.*.location) : one(data.azurerm_resource_group.this.*.location)
  log_analytics_workspace_name = "${var.basename}-${terraform.workspace}-la-workspace"
  monitor_resource_group_name  = var.backwards_compatible ? "${var.basename}-${terraform.workspace}-monitor-rg" : join("_", [var.basename, terraform.workspace])
  tags = merge(
    var.default_tags,
    {
      Environment = upper(var.environment)
      Location    = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
}

data "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 0 : 1
  name  = "${var.basename}_${var.environment}"
}

data "azurerm_network_ddos_protection_plan" "this" {
  name                = var.ddos_name
  resource_group_name = var.ddos_resource_group

  provider = azurerm.hub
}

data "azurerm_client_config" "this" {}

data "azurerm_client_config" "hub" {
  provider = azurerm.hub
}

data "azurerm_monitor_diagnostic_categories" "vnet" {
  resource_id = azurerm_virtual_network.this.id
}

data "azurerm_monitor_diagnostic_categories" "nsg" {
  for_each            = { for sg in var.security_group : sg.name => sg }
  resource_id = azurerm_network_security_group.this[each.value.name].id
}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name  
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_network_ddos_protection_plan.this.id
  role_definition_name = "Domain Services Contributor"
  principal_id         = data.azurerm_client_config.this.object_id

  provider = azurerm.hub
}

resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = "${var.basename}_${var.environment}"
  location = var.location

  tags = local.tags
}

resource "azurerm_network_security_group" "this" {
  for_each            = { for sg in var.security_group : sg.name => sg }
  name                = "${var.basename}_${var.environment}_${each.value.name}_sg"
  location            = local.location
  resource_group_name = local.resource_group_name

  dynamic "security_rule" {
    for_each = toset([
      for rule in each.value.rule : lookup(local.dynarules, rule)
    ])

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = local.tags
}

resource "azurerm_virtual_network" "this" {
  depends_on          = [azurerm_role_assignment.this]
  name                = "${var.basename}_${var.environment}_vnet"
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.vnet_cidr

  ddos_protection_plan {
    id     = data.azurerm_network_ddos_protection_plan.this.id
    enable = true
  }

  tags = local.tags
}

resource "azurerm_subnet" "this" {
  for_each = {
    for e in slice(var.vnet_subnets, 0, length(var.vnet_subnets)) :
    e.name => e
  }

  name                 = "${var.basename}_${var.environment}_${each.value.name}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  service_endpoints = each.value.service_endpoints
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = {
    for e in slice(var.vnet_subnets, 0, length(var.vnet_subnets)) :
    e.name => e
    if e.security_group != null
  }

  subnet_id                 = azurerm_subnet.this[each.value.name].id
  network_security_group_id = azurerm_network_security_group.this[each.value.security_group].id

  depends_on = [azurerm_network_security_group.this, azurerm_subnet.this]
}

resource "azurerm_route_table" "this" {
  name                = "${var.basename}_${var.environment}_routing"
  location            = local.location
  resource_group_name = local.resource_group_name

  dynamic "route" {
    for_each = var.routes
    content {
      name                   = route.value.name_prefix != "" ? join("-", concat([route.value.name_prefix, var.environment], route.value.name_postfix)) : join("-", concat([var.basename, var.environment], route.value.name_postfix))
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  tags = local.tags
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = {
    for e in slice(var.vnet_subnets, 0, length(var.vnet_subnets)) :
    e.name => e
    if e.route_table != null
  }

  subnet_id      = azurerm_subnet.this[each.key].id
  route_table_id = azurerm_route_table.this.id
}

resource "azurerm_monitor_diagnostic_setting" "vnet" {
  name = "${var.basename}-${var.environment}-vnet-diagnostic-settings"
  target_resource_id = azurerm_virtual_network.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.vnet.logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.vnet.metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "nsg" {
  for_each            = { for sg in var.security_group : sg.name => sg }
  name = "${var.basename}-${var.environment}-${each.value.name}-nsg-diagnostic-settings"
  target_resource_id = azurerm_network_security_group.this[each.value.name].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.nsg[each.value.name].logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.nsg[each.value.name].metrics
    content {
      category = metric.value
    }
  }
}

