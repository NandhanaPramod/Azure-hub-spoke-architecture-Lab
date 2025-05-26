terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.25.0"
    }
  }
  required_version = ">=1.2.5"
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}

  alias           = "dns_zone"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
}

provider "azurerm" {
  features {}

  alias           = "prod"
  client_id       = var.prod_client_id
  client_secret   = var.prod_client_secret
  subscription_id = var.prod_subscription_id
}