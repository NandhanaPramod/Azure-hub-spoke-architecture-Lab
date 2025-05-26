terraform {
  # more info on experimental feature: https://github.com/hashicorp/terraform/issues/30750#issuecomment-1150475431
  # experiments = [module_variable_optional_attrs]

  # terraform required version
  required_version = ">= 1.2.5"

  # terraform required providers and versions
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.24.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "oss_hub"
    storage_account_name = "osstfstatehub"
    container_name       = "osstfstatehubcontainer"
    key                  = "appgw.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}

  alias           = "prod"
  client_id       = var.prod_client_id
  client_secret   = var.prod_client_secret
  subscription_id = var.prod_subscription_id
}


