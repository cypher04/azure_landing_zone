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
    alias = "landingzone1"
    features {}
    subscription_id = var.landing_zone_1_subscription_id
}