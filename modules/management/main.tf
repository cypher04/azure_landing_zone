resource "azurerm_resource_group" "landing_zone_rg" {
    
    name     = var.resource_group_name
  location = var.location
  
}

// management group for the platform, Corp and Sandbox



// management group for the platform
resource "azurerm_management_group" "platform" {
    # provider        = azurerm
    name            = "platform"
    display_name    = "Platform"
    # parent_management_group_id = var.root_management_group_subscription_id
}

//mamagement group for the Landing Zone
resource "azurerm_management_group" "landing_zone" {
    # provider        = azurerm
    name            = "landing_zone"
    display_name    = "Landing Zone"
    # parent_management_group_id = var.root_management_group_subscription_id
}

// management group for the Sandbox
resource "azurerm_management_group" "sandbox" {
    # provider        = azurerm
    name            = "sandbox"
    display_name    = "Sandbox"
    # parent_management_group_id = var.root_management_group_subscription_id
}

///////////////////////////
// management group for platform children
resource "azurerm_management_group" "identity" {
    # provider        = azurerm
    name            = "identity"
    display_name    = "Identity"
    # parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "security" {
    # provider        = azurerm.security
    name            = "security"
    display_name    = "Security"
    # parent_management_group_id = azurerm_management_group.platform.id
}


resource "azurerm_management_group" "management" {
    # provider        = azurerm
    name            = "management"
    display_name    = "Management"
    # parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "connectivity" {
    name            = "connectivity"
    display_name    = "Connectivity"
    # parent_management_group_id = azurerm_management_group.platform.id
}

//////////////////////////
// Management group for Landing Zone children
resource "azurerm_management_group" "corp" {
    name            = "corp"
    display_name    = "Corp"
    # parent_management_group_id = azurerm_management_group.landing_zone.id
}

resource "azurerm_management_group" "online" {
    # provider        = azurerm
    name            = "online"
    display_name    = "Online"
    # parent_management_group_id = azurerm_management_group.landing_zone.id
}


///////////////////////
// Management group for Sandbox children
resource "azurerm_management_group" "dev" {
    # provider        = azurerm
    name            = "dev"
    display_name    = "Dev"
    # parent_management_group_id = azurerm_management_group.sandbox.id
}


// Attach subscription to the management groups

resource "azurerm_management_group_subscription_association" "identity_subscription" {
    management_group_id = azurerm_management_group.identity.id
    subscription_id     = "/subscriptions/${var.identity_subscription_id}"
}

resource "azurerm_management_group_subscription_association" "security_subscription" {
    management_group_id = azurerm_management_group.security.id
    subscription_id     = "/subscriptions/${var.security_subscription_id}"
}

resource "azurerm_management_group_subscription_association" "management_subscription" {
    management_group_id = azurerm_management_group.management.id
    subscription_id     = "/subscriptions/${var.management_subscription_id}"
}

resource "azurerm_management_group_subscription_association" "apps_subscription" {
    management_group_id = azurerm_management_group.corp.id
    subscription_id     = "/subscriptions/${var.landing_zone_1_subscription_id}"
}

resource "azurerm_management_group_subscription_association" "dev_subscription" {
    management_group_id = azurerm_management_group.corp.id
    subscription_id     = "/subscriptions/${var.landing_zone_1_subscription_id}"
}

resource "azurerm_management_group_subscription_association" "connectivity_subscription" {
    management_group_id = azurerm_management_group.connectivity.id
    subscription_id     = "/subscriptions/${var.connectivity_subscription_id}"
}




