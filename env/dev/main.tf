

data "azurerm_client_config" "current" {

}


module "management" {
    source = "../../modules/management"
    # providers = {
    #     azurerm = azurerm
    # }
    providers = {
        azurerm = azurerm.Management
    }
    connectivity_subscription_id = var.connectivity_subscription_id
    security_subscription_id = var.security_subscription_id
    root_management_group_subscription_id = var.root_management_group_subscription_id
    management_subscription_id = var.management_subscription_id
    identity_subscription_id = var.identity_subscription_id
    landing_zone_1_subscription_id = var.landing_zone_1_subscription_id
    location = var.location
    resource_group_name = var.resource_group_name
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
    connectivity_resource_group_name = var.connectivity_resource_group_name
}

module "security" {
    source = "../../modules/security"
    # providers = {
    #     azurerm = azurerm.Security
    # }
    security_subscription_id = var.security_subscription_id
    
}


module "compute" {
    source = "../../modules/compute"
    providers = {
        azurerm = azurerm.landingzone1
    }
    landing_zone_1_subscription_id = var.landing_zone_1_subscription_id
}