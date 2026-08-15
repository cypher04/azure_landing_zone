output "subnet_ids" {
    value = {
       Azure_Bastion = azurerm_subnet.AzureBastionSubnet.id
       Shared_services = azurerm_subnet.SharedServicesSubnet.id
       VPN_gateway = azurerm_subnet.GatewaySubnet.id
       Azure_firewall_id = azurerm_subnet.AzureFirewallSubnet.id
       production_spoke_subnet = azurerm_subnet.production_spoke_subnet.id
       non_production_spoke_subnet = azurerm_subnet.non_production_spoke_subnet.id
       data_platform_spoke_subnet = azurerm_subnet.data_platform_spoke_subnet.id

    }
}


output "azure_firewall_pip_id" {
    value = azurerm_public_ip.azure_firewall_public_ip.id
}

output "azure_firewall_public_ip_address" {
    value = azurerm_public_ip.azure_firewall_public_ip.ip_address
}

output "hub_vnet_name" {
    value = azurerm_virtual_network.hub_vnet.name
}

output "hub_vnet_id" {
    value = azurerm_virtual_network.hub_vnet.id
}

output "firewall_private_ip" {
    value = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
}

output "firewall_id" {
    value = azurerm_firewall.azure_firewall.id
}

output "production_spoke_vnet_id" {
    value = azurerm_virtual_network.production_spoke_vnet.id
}

output "non_production_spoke_vnet_id" {
    value = azurerm_virtual_network.non_production_spoke_vnet.id
}

output "data_platform_spoke_vnet_id" {
    value = azurerm_virtual_network.data_platform_spoke_vnet.id
}

output "diagnostics_logs_private_dns_zone_blob_id" {
    value = azurerm_private_dns_zone.diagnostics_logs_private_dns_zone_blob.id
}

output "private_dns_zone_vault_id" {
    value = azurerm_private_dns_zone.private_dns_zone_vault.id
}

output "connectivity_resource_group_name" {
    value = azurerm_resource_group.connectivity_rg.name
}