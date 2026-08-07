variable "identity_subscription_id" {
    description = "The subscription ID for the identity provider."
    type        = string
}

variable "security_resource_group_name" {
    description = "The name of the resource group for security resources."
    type        = string
}

variable "landing_zone_subscription_id" {
    description = "The subscription ID for the landing zone."
    type        = string
}

variable "connectivity_subscription_id" {
    description = "The subscription ID for the connectivity resources."
    type        = string
}

variable "management_subscription_id" {
    description = "The subscription ID for the management resources."
    type        = string
}

variable "security_subscription_id" {
    description = "The subscription ID for the security resources."
    type        = string
}

variable "location" {
    description = "The location for the resources."
    type        = string
}

variable "tenant_id" {
    description = "The tenant ID for the Azure AD provider."
    type        = string
}

