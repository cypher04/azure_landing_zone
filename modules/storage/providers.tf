terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.81.0"
    }
  }
}

provider "azurerm" {
  alias   = "Security"
  features {}
  subscription_id = var.security_subscription_id

}