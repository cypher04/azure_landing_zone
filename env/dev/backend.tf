// backend configuration for Terraform state
terraform {
  backend "azurerm" {
    resource_group_name  = "ALZdev-rg"
    storage_account_name = "ALZstatedev"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}