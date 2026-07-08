// backend configuration for Terraform state
terraform {
  backend "azurerm" {
    resource_group_name  = "landingzonedev-rg"
    storage_account_name = "landingzonestatedev"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}