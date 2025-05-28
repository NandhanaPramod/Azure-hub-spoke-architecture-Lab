terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create subnet for Azure Firewall
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]  # Adjust this CIDR as needed
}

# Public IP Address for Firewall
resource "azurerm_public_ip" "this" {
  name                = "${var.firewall_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  idle_timeout_in_minutes = 4
  tags                = var.tags
}

# Azure Firewall
resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = azurerm_firewall_policy.this.id
  threat_intel_mode   = var.threat_intel_mode

  ip_configuration {
    name                 = "firewall-ip-config"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

# Firewall Policy
resource "azurerm_firewall_policy" "this" {
  name                = "${var.firewall_name}-policy"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"

  dns {
    proxy_enabled = true
    servers       = ["10.50.1.28"]
  }

  insights {
    enabled                            = true
    default_log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
    retention_in_days                  = 30
    log_analytics_workspace {
      id                = azurerm_log_analytics_workspace.this.id
      firewall_location = var.location
    }
  }

  intrusion_detection {
    mode = "Off"
  }

  tags = var.tags
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
} 