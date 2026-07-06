resource "azurerm_resource_group" "state_rg" {
    provider = azurerm
  name     = "${var.project_name}${var.environment}-rg"
  location = var.location
}

data "azurerm_client_config" "current" {

}

resource "azurerm_storage_account" "state_storage" {
    provider = azurerm
  name                     = "${var.project_name}state${var.environment}"
  resource_group_name      = azurerm_resource_group.state_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

    lifecycle {
        prevent_destroy = false
    }

    min_tls_version = "TLS1_2"
    https_traffic_only_enabled = true

    blob_properties {
      versioning_enabled = true

      delete_retention_policy {
        days = 30
      }
    }
}

resource "azurerm_storage_container" "state_container" {
    provider = azurerm
    name                  = "tfstate"
    storage_account_name  = azurerm_storage_account.state_storage.name
    container_access_type = "private"
    }


variable "project_name" {
  description = "name of the project"
  type = string
  default = "landingzone"
}

variable "environment" {
  description = "deployment environment (e.g., dev, prod)"
  type = string
    default = "dev"
}

variable "location" {
  description = "name of the location"
  type = string
    default = "West US"
}

