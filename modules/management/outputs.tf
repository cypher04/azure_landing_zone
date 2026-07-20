output "management_group_ids" {
    value = {
        platform = azurerm_management_group.platform.id
        connectivity = azurerm_management_group.connectivity.id
        landing_zone = azurerm_management_group.landing_zone.id
        corp = azurerm_management_group.corp.id
        online = azurerm_management_group.online.id
        dev = azurerm_management_group.dev.id
    }
}