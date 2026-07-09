terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
}

provider "azurerm" {
    features {}
}

provider "azurerm" {
    alias = "Connectivity"
    features {}
    subscription_id = var.connectivity_subscription_id
}

provider "azurerm" {
    alias = "Security"
    features {}
    subscription_id = var.security_subscription_id
}

provider "azurerm" {
    alias = "Management"
    features {}
    subscription_id = var.management_subscription_id
}

provider "azurerm" {
    alias = "Identity"
    features {}
    subscription_id = var.identity_subscription_id
}

provider "azurerm" {
    alias = "landingzone1"
    features {}
    subscription_id = var.landing_zone_1_subscription_id
}
