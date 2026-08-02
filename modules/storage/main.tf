// Diagnostics Storage Account

resource "azurerm_storage_account" "DiagnosticsStorageAccount" {
  name                     = "diagnostics${random_string.random.result}"
  resource_group_name      = var.security_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "DiagnosticsStorageContainer" {
  name                  = "diagnostics${random_string.random.result}"
  storage_account_id  = azurerm_storage_account.DiagnosticsStorageAccount.id
  container_access_type = "private"
}

// random string for storage account name with lowercase letters only
resource "random_string" "random" {
  length  = 4
  special = false
  lower   = true
}

// Logs Storage Account

resource "azurerm_storage_account" "LogsStorageAccount" {
  name                     = "logs${random_string.random.result}"
  resource_group_name      = var.security_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "LogsStorageContainer" {
  name                  = "logs${random_string.random.result}"
  storage_account_id  = azurerm_storage_account.LogsStorageAccount.id
  container_access_type = "private"
}

