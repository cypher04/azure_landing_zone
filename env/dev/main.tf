
// resource group for the landing zone








// random provider to generate random values for resource names
resource "random_string" "random" {
    length  = 4
    special = false
    upper   = false
}

// 

data "azurerm_client_config" "current" {

}


// import identity resources

# import {
#   id = "/providers/Microsoft.Management/managementGroups/identity/subscriptions/<identity_subscription_id>"
#   to = module.management.azurerm_management_group_subscription_association.identity_subscription
# }

# import {
#     id = "/providers/Microsoft.Management/managementGroups/platform"
#     to = module.management.azurerm_management_group.platform
# }

# import {
#     id = "/providers/Microsoft.Management/managementGroups/landing_zone"
#     to = module.management.azurerm_management_group.landing_zone
# }

# import {
#     id = "/providers/Microsoft.Management/managementGroups/sandbox"
#     to = module.management.azurerm_management_group.sandbox
# }




// private dns zone import
# import {
#     id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-connectivity-rg/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
#     to = module.networking.azurerm_private_dns_zone.private_dns_zone_database
# }

# import {
#     id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-connectivity-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
#     to = module.networking.azurerm_private_dns_zone.diagnostics_private_dns_zone_blob
# }

# import {
#     id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-connectivity-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
#     to = module.networking.azurerm_private_dns_zone.logs_private_dns_zone_blob

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
#   id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-connectivity-rg"
#   to = azurerm_resource_group.connectivity_rg
# }

# import {
#   id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-security-rg"
#   to = azurerm_resource_group.security_rg
# }


# import {
#   id = "/subscriptions/<subscription_id>/resourceGroups/security1h2c-rg"
#   to = module.keyvault.azurerm_resource_group.security_rg
# }

# // landing zone resource group import
# import {
#   id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-rg"
#   to = azurerm_resource_group.landing_zone_rg
# }


# // import vault resources
# import {
#     id = "/subscriptions/<subscription_id>/resourceGroups/landingzone-dev-connectivity-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
#     to = module.networking.azurerm_private_dns_zone.private_dns_zone_vault
# }


# import {
#     id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyDefinitions/location-restriction-policy"
#     to = module.policy.azurerm_policy_definition.location_restriction_policy
# }

# import {
#     id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyDefinitions/https-storage-policy"
#     to = module.policy.azurerm_policy_definition.https_storage_policy
# }

# import {
#     id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyDefinitions/nsg-restriction-policy"
#     to = module.policy.azurerm_policy_definition.nsg_restriction_policy
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


# import {
#     id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyAssignments/location-restriction-assignment"
#     to = module.policy.azurerm_subscription_policy_assignment.location_restriction_assignment
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
    resource_group_name = module.management.resource_group_name
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
    resource_group_name = module.networking.connectivity_resource_group_name
    address_space = var.address_space
    subnet_prefixes = var.subnet_prefixes
    hub_vnet_name = var.hub_vnet_name
    connectivity_resource_group_name = module.networking.connectivity_resource_group_name
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
    # location = var.location
    subnet_ids = module.networking.subnet_ids
    security_subscription_id = var.security_subscription_id
    connectivity_resource_group_name = module.networking.connectivity_resource_group_name
    location = var.location
    keyvault_id = module.keyvault.keyvault_id
    Diagnostics_storage_account_id = module.storage.Diagnostics_storage_account_id
    logs_storage_account_id = module.storage.logs_storage_account_id
    diagnostics_private_dns_zone_blob_id = module.networking.diagnostics_private_dns_zone_blob_id
    logs_private_dns_zone_blob_id = module.networking.logs_private_dns_zone_blob_id
    private_dns_zone_vault_id = module.networking.private_dns_zone_vault_id

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
    security_resource_group_name = module.security.security_resource_group_name
    azure_firewall_pip_id = module.networking.azure_firewall_pip_id
    azure_firewall_public_ip_address = module.networking.azure_firewall_public_ip_address
    landing_zone_rg = module.management.resource_group_name
    management_group_ids = module.management.management_group_ids
    landing_zone_rg_id = module.management.resource_group_name

}


module "keyvault" {
    source = "../../modules/keyvault"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = module.security.security_resource_group_name
    keyvault_secret_names = var.keyvault_secret_names
    keyvault_secret_value = var.keyvault_secret_value
    keyvault_certificate_names = var.keyvault_certificate_names
    keyvault_certificate_contents = var.keyvault_certificate_contents
    keyvault_certificate_password = var.keyvault_certificate_password
    keyvault_key_names = var.keyvault_key_names
}

module "monitoring" {
    source = "../../modules/monitoring"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = module.security.security_resource_group_name
    Diagnostics_storage_account_id   = module.storage.Diagnostics_storage_account_id
    logs_storage_account_id         = module.storage.logs_storage_account_id
    keyvault_id                     = module.keyvault.keyvault_id
    firewall_id                    = module.networking.firewall_id
    hub_vnet_id                      = module.networking.hub_vnet_id
    production_spoke_vnet_id                = module.networking.production_spoke_vnet_id
    non_production_spoke_vnet_id                = module.networking.non_production_spoke_vnet_id
    data_platform_spoke_vnet_id                = module.networking.data_platform_spoke_vnet_id
}   


module "storage" {
    source = "../../modules/storage"
    providers = {
        azurerm = azurerm.Security
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = module.security.security_resource_group_name
}


module "identity" {
    source = "../../modules/identity"
    providers = {
        azurerm = azurerm.Identity
    }
    location = var.location
    security_subscription_id = var.security_subscription_id
    security_resource_group_name = module.security.security_resource_group_name
    management_subscription_id = var.management_subscription_id
    identity_subscription_id = var.identity_subscription_id
    landing_zone_subscription_id = var.landing_zone_1_subscription_id
    connectivity_subscription_id = var.connectivity_subscription_id
    tenant_id = var.tenant_id

}