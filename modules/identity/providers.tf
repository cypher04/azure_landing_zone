terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 4.80.0"
        }

        azuread = {
        source  = "hashicorp/azuread"
        version = "3.9.0"
    }
    }
}

provider "azurerm" {
    alias = "identity"
    features {}
    subscription_id = var.identity_subscription_id
}

provider "azuread" {

    tenant_id = data.azurerm_subscription.connectivity_subscription.tenant_id
}