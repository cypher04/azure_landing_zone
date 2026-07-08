resource "azurerm_resource_group" "landing_zone_rg" {
    provider = azurerm
    name     = var.resource_group_name
  location = var.location
  
}

data "azurerm_client_config" "current" {

}


module "management" {
    source = "../../modules/management"
    # providers = {
    #     azurerm = azurerm
    # }
    providers = {
        azurerm = azurerm.Connectivity
    }
    connectivity_subscription_id = var.connectivity_subscription_id
    security_subscription_id = var.security_subscription_id
    root_management_group_subscription_id = var.root_management_group_subscription_id
}

module "networking" {
    source = "../../modules/networking"
    providers = {
        azurerm = azurerm.Connectivity
    }
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = var.address_space
    subnet_prefixes = var.subnet_prefixes
    hub_vnet_name = var.hub_vnet_name
}