
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
}

provider "azurerm" {
    alias = "Management"
    features {}
    subscription_id = var.management_subscription_id
} 