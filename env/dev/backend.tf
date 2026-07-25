// backend configuration for Terraform state
terraform {
  backend "azurerm" {
    resource_group_name  = "landingzonedev-rg2"
    storage_account_name = "landingzonestatedev2"
    container_name       = "tfstate2"
    key                  = "terraform.tfstate"
  }
}