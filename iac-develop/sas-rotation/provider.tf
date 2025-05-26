terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.40"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 1.2"
    }
  }
  required_version = ">=1.2.5"
}

provider "azurerm" {
  features {}
}

provider "azapi" {}