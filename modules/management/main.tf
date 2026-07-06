// management group for the platform, Corp and Sandbox



// management group for the platform
resource "azurerm_management_group" "platform" {
    name            = "platform"
    display_name    = "Platform"
    parent_management_group_id = var.root_management_group_subscription_id
}

//mamagement group for the Landing Zone
resource "azurerm_management_group" "landing_zone" {
    name            = "landing_zone"
    display_name    = "Landing Zone"
    parent_management_group_id = var.root_management_group_subscription_id
}

// management group for the Sandbox
resource "azurerm_management_group" "sandbox" {
    name            = "sandbox"
    display_name    = "Sandbox"
    parent_management_group_id = var.root_management_group_subscription_id
}

///////////////////////////
// management group for platform children
resource "azurerm_management_group" "identity" {
    name            = "identity"
    display_name    = "Identity"
    parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "security" {
    name            = "security"
    display_name    = "Security"
    parent_management_group_id = azurerm_management_group.platform.id
}


resource "azurerm_management_group" "management" {
    name            = "management"
    display_name    = "Management"
    parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "connectivity" {
    name            = "connectivity"
    display_name    = "Connectivity"
    parent_management_group_id = azurerm_management_group.platform.id
}

//////////////////////////
// Management group for Landing Zone children
resource "azurerm_management_group" "corp" {
    name            = "corp"
    display_name    = "Corp"
    parent_management_group_id = azurerm_management_group.landing_zone.id
}

resource "azurerm_management_group" "online" {
    name            = "online"
    display_name    = "Online"
    parent_management_group_id = azurerm_management_group.landing_zone.id
}


///////////////////////
// Management group for Sandbox children
resource "azurerm_management_group" "dev" {
    name            = "dev"
    display_name    = "Dev"
    parent_management_group_id = azurerm_management_group.sandbox.id
}


// Attach subscription to the management groups

resource "azurerm_management_group_subscription_association" "platform_subscription" {
  management_group_id = azurerm_management_group.platform.id
  subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "landing_zone_subscription" {
    management_group_id = azurerm_management_group.landing_zone.id
    subscription_id     = var.root_management_group_subscription_id
    }

resource "azurerm_management_group_subscription_association" "sandbox_subscription" {
    management_group_id = azurerm_management_group.sandbox.id
    subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "identity_subscription" {
    management_group_id = azurerm_management_group.identity.id
    subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "security_subscription" {
    management_group_id = azurerm_management_group.security.id
    subscription_id     = var.security_subscription_id
}

resource "azurerm_management_group_subscription_association" "management_subscription" {
    management_group_id = azurerm_management_group.management.id
    subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "apps_subscription" {
    management_group_id = azurerm_management_group.corp.id
    subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "dev_subscription" {
    management_group_id = azurerm_management_group.dev.id
    subscription_id     = var.root_management_group_subscription_id
}

resource "azurerm_management_group_subscription_association" "connectivity_subscription" {
    management_group_id = azurerm_management_group.connectivity.id
    subscription_id     = var.connectivity_subscription_id
}




