// identity resource group

resource "azurerm_resource_group" "identity_resource_group" {
    provider = azurerm.identity
    name     = "identity-rg"
    location = var.location
}



// Azure AD group for Cloud Engineers

resource "azuread_group" "CloudEngineersGroup" {
    display_name     = "CloudEngineersGroup"
    security_enabled = true
}


// Azure AD group for Security Team
resource "azuread_group" "SecurityTeamGroup" {
    display_name     = "SecurityTeamGroup"
    security_enabled = true
}


// Azure AD group for Operations Team
resource "azuread_group" "OperationsTeamGroup" {
    display_name     = "OperationsTeamGroup"
    security_enabled = true
}


// Azure AD group for Developers Team
resource "azuread_group" "DevelopersTeamGroup" {
    display_name     = "DevelopersTeamGroup"
    security_enabled = true
}


// data for reterieving conectivity subscription details
data "azurerm_subscription" "connectivity_subscription" {
    provider        = azurerm.identity
    subscription_id = var.connectivity_subscription_id
}


// role assignment for Cloud Engineers group to a specific role in the subscription
resource "azurerm_role_assignment" "CloudEngineersRoleAssignment" {
    provider            = azurerm.identity
    scope               = "/subscriptions/${var.connectivity_subscription_id}"
    role_definition_name = "Contributor"
    principal_id        = azuread_group.CloudEngineersGroup.object_id
}

// role assignment for Security Team group to a specific role in the subscription
resource "azurerm_role_assignment" "SecurityTeamRoleAssignment" {
    provider            = azurerm.identity
    scope               = "/subscriptions/${var.security_subscription_id}"
    role_definition_name = "Security Admin"
    principal_id        = azuread_group.SecurityTeamGroup.object_id
}
// role assignment for Operations Team group to a specific role in the subscription
resource "azurerm_role_assignment" "OperationsTeamRoleAssignment" {
    provider            = azurerm.identity
    scope               = "/subscriptions/${var.management_subscription_id}"
    role_definition_name = "Reader"
    principal_id        = azuread_group.OperationsTeamGroup.object_id
}
// role assignment for Developers Team group to a specific role in the subscription
resource "azurerm_role_assignment" "DevelopersTeamRoleAssignment" {
    provider            = azurerm.identity
    scope               = "/subscriptions/${var.landing_zone_subscription_id}"
    role_definition_name = "Reader"
    principal_id        = azuread_group.DevelopersTeamGroup.object_id
}



/////// managed identity for the security team
// managed identity for the landing zone
resource "azurerm_user_assigned_identity" "automation_identity" {
    provider            = azurerm.identity
    name                = "automation-identity"
    resource_group_name = azurerm_resource_group.identity_resource_group.name
    location            = var.location
}


// managed identity for application

resource "azurerm_user_assigned_identity" "application_identity" {
    provider            = azurerm.identity
    name                = "application-identity"
    resource_group_name = azurerm_resource_group.identity_resource_group.name
    location            = var.location
}

// managed identity for monitoring
resource "azurerm_user_assigned_identity" "monitoring_identity" {
    provider            = azurerm.identity
    name                = "monitoring-identity"
    resource_group_name = azurerm_resource_group.identity_resource_group.name
    location            = var.location
}

