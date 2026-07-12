output "subnet_ids" {
    value = {
       Azure_Bastion = azurerm_subnet.AzureBastionSubnet.id
       Shared_services = azurerm_subnet.SharedServicesSubnet.id
       VPN_gateway = azurerm_subnet.GatewaySubnet.id
       Azure_firewall = azurerm_subnet.AzureFirewallSubnet.id
       production_spoke_subnet = azurerm_subnet.production_spoke_subnet.id
       non_production_spoke_subnet = azurerm_subnet.non_production_spoke_subnet.id
       data_platform_spoke_subnet = azurerm_subnet.data_platform_spoke_subnet.id

    }
}


output "azure_firewall_pip_id" {
    value = azurerm_public_ip.azure_firewall_public_ip.id
}