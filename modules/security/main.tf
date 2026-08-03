


// private endpoint for keyvault, storage account, sql database

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  name                = "keyvault-private-endpoint"
  location            = var.location
  resource_group_name = var.security_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = var.keyvault_id
    is_manual_connection          = false
    subresource_names             = ["vault"]
  }
}


// private endpoint for storage account
resource "azurerm_private_endpoint" "logs_storage_account_private_endpoint" {
  name                = "logs-storage-pe"
  location            = var.location
  resource_group_name = var.security_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]
    private_service_connection {
        name                           = "logs-storage-account-connection"
        private_connection_resource_id = var.logs_storage_account_id
        is_manual_connection          = false
        subresource_names             = ["blob"]
    }
}

// private endpoint for diagnostic storage account
resource "azurerm_private_endpoint" "diagnostics_storage_account_private_endpoint" {
  name                = "diagnostics-storage-pe"
  location            = var.location
  resource_group_name = var.security_resource_group_name
  subnet_id           = var.subnet_ids["Shared_services"]
    private_service_connection {
        name                           = "diagnostics-storage-account-connection"
        private_connection_resource_id = var.Diagnostics_storage_account_id
        is_manual_connection          = false
        subresource_names             = ["blob"]
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


