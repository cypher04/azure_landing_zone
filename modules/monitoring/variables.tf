variable "security_subscription_id" {
  description = "The subscription ID for the security resources."
  type        = string
}

variable "security_resource_group_name" {
  description = "The name of the resource group for security resources."
  type        = string
}

variable "location" {
  description = "The location for the security resources."
  type        = string
}

variable "Diagnostics_storage_account_id" {
  description = "The ID of the diagnostics storage account."
  type        = string
}

variable "logs_storage_account_id" {
  description = "The ID of the logs storage account."
  type        = string
}

variable "keyvault_id" {
  description = "The ID of the Key Vault."
  type        = string
}


variable "firewall_id" {
  description = "The ID of the Azure Firewall."
  type        = string
}

variable "hub_vnet_id" {
  description = "The ID of the Hub Virtual Network."
  type        = string
}

variable "production_spoke_vnet_id" {
  description = "The ID of the Production Spoke Virtual Network."
  type        = string
}

variable "non_production_spoke_vnet_id" {
  description = "The ID of the Non-Production Spoke Virtual Network."
  type        = string
}

variable "data_platform_spoke_vnet_id" {
  description = "The ID of the Data Platform Spoke Virtual Network."
  type        = string
}