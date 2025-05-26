# Locals for resource mappings
locals {
  # Resource group name logic
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : var.resource_group_name

  # Location for all resources
  location = var.location

  # Common tags for all resources
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(var.environment)
      Location     = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )

  # Security rules mapping
  dynarules = { for rule in var.security_rules : rule.name => rule }
  
  # Security groups mapping
  nsg_map = { for nsg in var.security_group : nsg.name => nsg }
  
  # Subnet mapping
  subnet_map = { for subnet in var.subnets : subnet.name => subnet }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = "${var.basename}-${var.environment}-rg"
  location = local.location
  tags     = local.tags
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.basename}-${var.environment}-vnet"
  resource_group_name = local.resource_group_name
  location            = local.location
  address_space       = var.vnet_cidr
  tags                = local.tags

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.this.id
    enable = true
  }
}

# Subnets
resource "azurerm_subnet" "subnet" {
  for_each = local.subnet_map

  name                 = each.value.name
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
}

# Network Security Groups
resource "azurerm_network_security_group" "nsg" {
  for_each = local.nsg_map

  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
}

# Security Rules
resource "azurerm_network_security_rule" "rules" {
  for_each = local.dynarules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = local.resource_group_name
  network_security_group_name = each.value.name
}

# Subnet NSG Associations
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each = local.subnet_map

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_name].id
}

# Add data source to get current tenant ID
data "azurerm_client_config" "current" {}

# Azure Firewall
resource "azurerm_firewall_policy" "this" {
  name                = var.firewall_policy.name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.firewall_policy.sku
  dns {
    servers         = var.firewall_policy.dns_servers
    proxy_enabled   = true
  }
  insights {
    enabled                            = true
    default_log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }
  tags = local.tags
}

resource "azurerm_firewall" "this" {
  name                = "${var.basename}-${var.environment}-firewall"
  resource_group_name = local.resource_group_name
  location            = local.location
  sku_name            = "AZFW_Hub"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.this.id
  tags                = local.tags

  ip_configuration {
    name                 = "firewall-ipconfig"
    subnet_id            = azurerm_subnet.subnet["firewall"].id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

# Azure Bastion
resource "azurerm_bastion_host" "this" {
  name                = var.bastion_config.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ip_configuration {
    name                 = "bastion-ipconfig"
    subnet_id            = azurerm_subnet.subnet["bastion"].id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}

# VPN Gateway
resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpn_gateway_config.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  type     = var.vpn_gateway_config.type
  vpn_type = "RouteBased"
  sku      = var.vpn_gateway_config.sku

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet["gateway"].id
  }
}

# Private DNS Zones
resource "azurerm_private_dns_zone" "this" {
  for_each = toset(var.private_dns_zones)

  name                = each.value
  resource_group_name = local.resource_group_name
  tags                = local.tags
}

# Key Vault
resource "azurerm_key_vault" "this" {
  name                        = var.key_vault_config.name
  resource_group_name         = local.resource_group_name
  location                    = local.location
  enabled_for_disk_encryption = var.key_vault_config.enabled_for_disk_encryption
  purge_protection_enabled    = var.key_vault_config.purge_protection_enabled
  sku_name                    = var.key_vault_config.sku
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  tags                        = local.tags

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

# Container Registry
resource "azurerm_container_registry" "this" {
  name                = var.container_registry_config.name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.container_registry_config.sku
  admin_enabled       = true
  tags                = local.tags
}

# Storage Account
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_config.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.storage_account_config.account_tier
  account_replication_type = var.storage_account_config.account_replication_type
  tags                     = local.tags
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_config.name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.log_analytics_config.sku
  retention_in_days   = var.log_analytics_config.retention_in_days
  tags                = local.tags
}

# Public IPs
resource "azurerm_public_ip" "firewall" {
  name                = "${var.basename}-${var.environment}-firewall-pip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_public_ip" "bastion" {
  name                = "${var.basename}-${var.environment}-bastion-pip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_public_ip" "gateway" {
  name                = "${var.basename}-${var.environment}-gateway-pip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Dynamic"
  tags                = local.tags
}

# DDoS Protection Plan
resource "azurerm_network_ddos_protection_plan" "this" {
  name                = "${var.basename}-${var.environment}-ddos"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
} 