
resource "azurerm_resource_group" "connectivity_rg" {
    name     = var.connectivity_resource_group_name
    location = var.location
  
}


// Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
    name                = var.hub_vnet_name
    address_space       = [var.address_space["hub_vnet_address_space"]]
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

// Subnets for the Hub Virtual Network
resource "azurerm_subnet" "AzureFirewallSubnet" {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = [var.subnet_prefixes["Azure_firewall"]]
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = [var.subnet_prefixes["VPN_gateway"]]
}

resource "azurerm_subnet" "AzureBastionSubnet" {
    name                 = "AzureBastionSubnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = [var.subnet_prefixes["Azure_Bastion"]]
}

resource "azurerm_subnet" "SharedServicesSubnet" {
    name                 = "SharedServicesSubnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = [var.subnet_prefixes["Shared_services"]]
}

///////// Subnets for the spoke virtual networks
resource "azurerm_subnet" "production_spoke_subnet" {
    name                 = "production-spoke-subnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.production_spoke_vnet.name
    address_prefixes     = [var.subnet_prefixes["production_spoke_subnet"]]
}

resource "azurerm_subnet" "non_production_spoke_subnet" {
    name                 = "non-production-spoke-subnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.non_production_spoke_vnet.name
    address_prefixes     = [var.subnet_prefixes["non_production_spoke_subnet"]]
}

resource "azurerm_subnet" "data_platform_spoke_subnet" {
    name                 = "data-platform-spoke-subnet"
    resource_group_name  = azurerm_resource_group.connectivity_rg.name
    virtual_network_name = azurerm_virtual_network.data_platform_spoke_vnet.name
    address_prefixes     = [var.subnet_prefixes["data_platform_spoke_subnet"]]
}



//spoke virtual networks
resource "azurerm_virtual_network" "production_spoke_vnet" {
    name                = var.production_spoke_vnet_name
    address_space       = [var.address_space["production_spoke_vnet_address_space"]]
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

resource "azurerm_virtual_network" "non_production_spoke_vnet" {
    name                = var.non_production_spoke_vnet_name
    address_space       = [var.address_space["non_production_spoke_vnet_address_space"]]
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

resource "azurerm_virtual_network" "data_platform_spoke_vnet" {
    name                = var.data_platform_spoke_vnet_name
    address_space       = [var.address_space["data_platform_spoke_vnet_address_space"]]
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

// peering between hub and spoke virtual networks
resource "azurerm_virtual_network_peering" "hub_to_production_spoke" {
    name                      = "hub-to-production-spoke"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.production_spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "production_spoke_to_hub" {
    name                      = "production-spoke-to-hub"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.production_spoke_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

// Add similar peering resources for non-production and data platform spokes

resource "azurerm_virtual_network_peering" "hub_to_non_production_spoke" {
    name                      = "hub-to-non-production-spoke"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.non_production_spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "non_production_spoke_to_hub" {
    name                      = "non-production-spoke-to-hub"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.non_production_spoke_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

// Peering for data platform spoke
resource "azurerm_virtual_network_peering" "hub_to_data_platform_spoke" {
    name                      = "hub-to-data-platform-spoke"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.data_platform_spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "data_platform_spoke_to_hub" {
    name                      = "data-platform-spoke-to-hub"
    resource_group_name       = azurerm_resource_group.connectivity_rg.name
    virtual_network_name      = azurerm_virtual_network.data_platform_spoke_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

// public IP for Azure Firewall
resource "azurerm_public_ip" "azure_firewall_public_ip" {
    name                = "azure-firewall-public-ip"
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
    allocation_method   = "Static"
  
}


////////// route spoke traffic to Azure Firewall
resource "azurerm_route_table" "production_spoke_route_table" {
    name                = "production-spoke-route-table"
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

resource "azurerm_route" "production_spoke_route" {
    name                   = "production-spoke-route"
    resource_group_name    = azurerm_resource_group.connectivity_rg.name
    route_table_name       = azurerm_route_table.production_spoke_route_table.name
    address_prefix         = "0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
      depends_on = [ var.firewall_private_ip ]
}

resource "azurerm_subnet_route_table_association" "production_spoke_route_table_association" {
    subnet_id      = azurerm_subnet.production_spoke_subnet.id
    route_table_id = azurerm_route_table.production_spoke_route_table.id
}

// Add route tables and routes for non-production 
resource "azurerm_route_table" "non_production_spoke_route_table" {
    name                = "non-production-spoke-route-table"
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}

resource "azurerm_route" "non_production_spoke_route" {
    name                   = "non-production-spoke-route"
    resource_group_name    = azurerm_resource_group.connectivity_rg.name
    route_table_name       = azurerm_route_table.non_production_spoke_route_table.name
    address_prefix         = "0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
      depends_on = [ var.firewall_private_ip ]
}

resource "azurerm_subnet_route_table_association" "non_production_spoke_route_table_association" {
    subnet_id      = azurerm_subnet.non_production_spoke_subnet.id
    route_table_id = azurerm_route_table.non_production_spoke_route_table.id
}

// Route table and route for data platform spoke
resource "azurerm_route_table" "data_platform_spoke_route_table" {
    name                = "data-platform-spoke-route-table"
    location            = var.location
    resource_group_name = azurerm_resource_group.connectivity_rg.name
}
resource "azurerm_route" "data_platform_spoke_route" {
    name                   = "data-platform-spoke-route"
    resource_group_name    = azurerm_resource_group.connectivity_rg.name
    route_table_name       = azurerm_route_table.data_platform_spoke_route_table.name
    address_prefix         = "0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip

    depends_on = [ var.firewall_private_ip ]
}

resource "azurerm_subnet_route_table_association" "data_platform_spoke_route_table_association" {
    subnet_id      = azurerm_subnet.data_platform_spoke_subnet.id
    route_table_id = azurerm_route_table.data_platform_spoke_route_table.id
}
