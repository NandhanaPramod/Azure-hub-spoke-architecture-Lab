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

# DDoS Protection Plan
resource "azurerm_network_ddos_protection_plan" "this" {
  name                = "${var.basename}-ddos-protection-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Enable DDoS Protection on the Virtual Network
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.this.id
    enable = true
  }

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }

  tags = var.tags
} 