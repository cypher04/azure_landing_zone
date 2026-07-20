resource "azurerm_resource_group" "security" {
    name     = var.security_resource_group_name
    location = var.location
}

data "azurerm_client_config" "current" {}

resource "random_string" "example" {
  length  = 4
  special = false
}

resource "azurerm_key_vault" "landing_zone_kv" {
    name                        = "landing-zone-kv-${random_string.example.result}"
    location                    = var.location
    resource_group_name         = var.security_resource_group_name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    sku_name                    = "standard"
    purge_protection_enabled    = true
    soft_delete_retention_days  = 90
    
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
    
        key_permissions = [
        "Get",
        "List",
        "Create",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
        "Import",
        "GetRotationPolicy",
        "SetRotationPolicy",
        ]
    
        secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
        ]

        certificate_permissions = [
        "Create",
        "Delete",
        "DeleteIssuers",
        "Get",
        "GetIssuers",
        "Import",
        "List",
        "ListIssuers",
        "ManageContacts",
        "ManageIssuers",
        "SetIssuers",
        "Update",
        ]
    }

    depends_on = [time_sleep.wait_for_rg]
}

// delay creation of keyvault until the resource group is created
resource "time_sleep" "wait_for_rg" {
    depends_on = [azurerm_resource_group.security]

    create_duration = "30s"
}







// keyvault secrets
resource "azurerm_key_vault_secret" "example" {
    name         = var.keyvault_secret_names["secret1"]
    value        = var.keyvault_secret_value
    key_vault_id = azurerm_key_vault.landing_zone_kv.id
}

// keyvault certificates
# resource "azurerm_key_vault_certificate" "example" {
#     name         = var.keyvault_certificate_names["cert1"]
#     key_vault_id = azurerm_key_vault.landing_zone_kv.id
#     certificate {
#         contents = filebase64(var.keyvault_certificate_contents)
#         password = var.keyvault_certificate_password
#     }
# }

// keyvault keys
resource "azurerm_key_vault_key" "example" {
    name         = var.keyvault_key_names["key1"]
    key_vault_id = azurerm_key_vault.landing_zone_kv.id
    key_type     = "RSA"
    key_size     = 2048

    key_opts = [
        "decrypt",
        "encrypt",
        "sign",
        "verify",
        "wrapKey",
        "unwrapKey"
    ]

    rotation_policy {
        automatic {
            time_before_expiry = "P30D"
        }

        expire_after = "P90D"
        notify_before_expiry = "P29D"
    }
}