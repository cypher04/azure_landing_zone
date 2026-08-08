terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }

     azuread = {
      source  = "hashicorp/azuread"
      version = "3.9.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.14.0"
    }
  }
}

provider "azurerm" {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
}

provider "azurerm" {
    alias = "Identity"
    features {}
    subscription_id = var.identity_subscription_id
}



provider "azurerm" {
    alias = "Connectivity"
    features {}
    subscription_id = var.connectivity_subscription_id
}

provider "azurerm" {
    alias = "Security"
    features {

      resource_group {
        prevent_deletion_if_contains_resources = false
      }
      
    }
    subscription_id = var.security_subscription_id
}


provider "azurerm" {
  alias = "identity"
  features {}
  subscription_id = var.identity_subscription_id
}

provider "random" {

}

provider "time" {

}

provider "azuread" {

    tenant_id = var.tenant_id
}
