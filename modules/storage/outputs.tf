output "Diagnostics_storage_account_id" {
  value = azurerm_storage_account.DiagnosticsStorageAccount.id
}

output "logs_storage_account_id" {
  value = azurerm_storage_account.LogsStorageAccount.id
}