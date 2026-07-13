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
    location = var.location
    resource_group_name = var.resource_group_name
    connectivity_subscription_id = var.connectivity_subscription_id
    security_subscription_id = var.security_subscription_id
    root_management_group_subscription_id = var.root_management_group_subscription_id
    management_subscription_id = var.management_subscription_id
    identity_subscription_id = var.identity_subscription_id
    landing_zone_1_subscription_id = var.landing_zone_1_subscription_id
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
    production_spoke_vnet_name = var.production_spoke_vnet_name
    non_production_spoke_vnet_name = var.non_production_spoke_vnet_name
    data_platform_spoke_vnet_name = var.data_platform_spoke_vnet_name
    firewall_private_ip = module.security.firewall_private_ip

}

module "security" {
    source = "../../modules/security"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    subnet_ids = module.networking.subnet_ids
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = var.security_resource_group_name
    azure_firewall_pip_id = module.networking.azure_firewall_pip_id
    firewall_policy_id = module.policy.firewall_policy_id

}


module "policy" {
    source = "../../modules/policy"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    landing_zone_1_subscription_id = var.landing_zone_1_subscription_id
    vm_size = var.vm_size
    security_resource_group_name = var.security_resource_group_name

}