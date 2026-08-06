
// resource group for the security resources
resource "azurerm_resource_group" "security_rg" {
    provider = azurerm.Security
    name     = "security${random_string.random.result}-rg"
    location = var.location
}


resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}


// private endpoint for keyvault, storage account, sql database

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  name                = "keyvault-private-endpoint"
  location            = var.location
  resource_group_name = var.connectivity_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = var.keyvault_id
    is_manual_connection          = false
    subresource_names             = ["vault"]
  }


  private_dns_zone_group {
    name = "keyvault-dns-zone-group"
    private_dns_zone_ids   = [var.private_dns_zone_vault_id]

  }
  
}


// private endpoint for storage account
resource "azurerm_private_endpoint" "logs_storage_account_private_endpoint" {
  name                = "logs-storage-pe"
  location            = var.location
  resource_group_name = var.connectivity_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]
    private_service_connection {
        name                           = "logs-storage-account-connection"
        private_connection_resource_id = var.logs_storage_account_id
        is_manual_connection          = false
        subresource_names             = ["blob"]
    }

     private_dns_zone_group {
        name = "logs-storage-account-dns-zone-group"
        private_dns_zone_ids   = [var.logs_private_dns_zone_blob_id]
    }
}

// private endpoint for diagnostic storage account
resource "azurerm_private_endpoint" "diagnostics_storage_account_private_endpoint" {
  name                = "diagnostics-storage-pe"
  location            = var.location
  resource_group_name = var.connectivity_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]
    private_service_connection {
        name                           = "diagnostics-storage-account-connection"
        private_connection_resource_id = var.Diagnostics_storage_account_id
        is_manual_connection          = false
        subresource_names             = ["blob"]
    }

    private_dns_zone_group {
        name = "diagnostics-storage-account-dns-zone-group"
        private_dns_zone_ids   = [var.diagnostics_private_dns_zone_blob_id]
    }
}


# // private endpoint for sql database
# resource "azurerm_private_endpoint" "sql_database_private_endpoint" {
#   name                = "sql-database-private-endpoint"
#   location            = var.location
#   resource_group_name = var.security_resource_group_name
#   subnet_id           = var.subnet_ids["Shared_services"]
#     private_service_connection {
#         name                           = "sql-database-connection"
#         private_connection_resource_id = var.sql_database_id
#         is_manual_connection          = false
#         subresource_names             = ["sqlServer"]
#     }
# }


