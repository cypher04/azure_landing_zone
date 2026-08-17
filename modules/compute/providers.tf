terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "4.80.0"
        }
    }
}

# provider "azurerm" {
#     features {}
# }

provider "azurerm" {
    alias = "connectivity"
    features {}
    subscription_id = var.connectivity_subscription_id
}