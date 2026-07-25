
// resource group for the landing zone
resource "azurerm_resource_group" "landing_zone_rg" {
    provider = azurerm
    name     = var.resource_group_name
  location = var.location
}


// resource group for the connectivity resources
resource "azurerm_resource_group" "connectivity_rg" {
    provider = azurerm.Connectivity
    name     = var.connectivity_resource_group_name
    location = var.location
}

// resource group for the security resources
resource "azurerm_resource_group" "security_rg" {
    provider = azurerm.Security
    name     = var.security_resource_group_name
    location = var.location
}

// 

data "azurerm_client_config" "current" {

}


// import identity resources

# import {
#   id = "/providers/Microsoft.Management/managementGroups/identity/subscriptions/<identity_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.identity_subscription
# }

// import security resources

# import  {
#   id = "/providers/Microsoft.Management/managementGroups/security/subscriptions/<security_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.security_subscription
# }

// import management resources

# import {
#     id = "/providers/Microsoft.Management/managementGroups/management/subscriptions/<management_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.management_subscription
# }

// import dev resources

# import {
#     id = "/providers/Microsoft.Management/managementGroups/dev/subscriptions/<dev_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.dev_subscription
# }

// import connectivity resources

# import {
#     id = "/providers/Microsoft.Management/managementGroups/connectivity/subscriptions/<connectivity_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.connectivity_subscription
# }

# import {
#   id = "/subscriptions/<connectivity_subscription_id>/resourceGroups/landingzone-dev-connectivity-rg"
#   to = azurerm_resource_group.connectivity_rg
# }

# import {
#   id = "/subscriptions/<security_subscription_id>/resourceGroups/landingzone-dev-security-rg"
#   to = module.policy.azurerm_resource_group.security_rg
# }

// landing zone resource group import
# import {
#   id = "/subscriptions/<identity_subscription_id>/resourceGroups/landingzone-dev-rg"
#   to = azurerm_resource_group.landing_zone_rg
# }


// policy import
# import {
#     id = "/subscriptions/<security_subscription_id>/providers/Microsoft.Authorization/policyDefinitions/location-restriction-policy"
#   to = module.policy.azurerm_policy_definition.location_restriction_policy
# }

# import {
#     id = "/subscriptions/<security_subscription_id>/providers/Microsoft.Authorization/policyDefinitions/nsg-restriction-policy"
#     to = module.policy.azurerm_policy_definition.nsg_restriction_policy
# }



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
    firewall_private_ip = module.networking.firewall_private_ip
    firewall_policy_id = module.policy.firewall_policy_id
    azure_firewall_pip_id = module.networking.azure_firewall_pip_id
    subnet_ids = module.networking.subnet_ids


    # depends_on = [module.security]

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
    hub_vnet_name = module.networking.hub_vnet_name

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
    azure_firewall_pip_id = module.networking.azure_firewall_pip_id
    azure_firewall_public_ip_address = module.networking.azure_firewall_public_ip_address
    landing_zone_rg = azurerm_resource_group.landing_zone_rg.id
    management_group_ids = module.management.management_group_ids
    landing_zone_rg_id = azurerm_resource_group.landing_zone_rg.id

}


module "keyvault" {
    source = "../../modules/keyvault"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = var.security_resource_group_name
    keyvault_secret_names = var.keyvault_secret_names
    keyvault_secret_value = var.keyvault_secret_value
    keyvault_certificate_names = var.keyvault_certificate_names
    keyvault_certificate_contents = var.keyvault_certificate_contents
    keyvault_certificate_password = var.keyvault_certificate_password
    keyvault_key_names = var.keyvault_key_names
}