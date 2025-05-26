terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.37.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
  required_version = ">= 1.2.5"
}
