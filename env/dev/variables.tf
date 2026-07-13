variable "root_management_group_subscription_id" {
    description = "Root management group subscription ID"
    type        = string
}

variable "connectivity_subscription_id" {
    description = "Connectivity subscription ID"
    type        = string
}

variable "security_subscription_id" {
    description = "Security subscription ID"
    type        = string
}

variable "project_name" {
    description = "Name of the project"
    type        = string

}

variable "environment" {
    description = "Deployment environment (e.g., dev, prod)"
    type        = string
}

variable "location" {
    description = "Name of the location"
    type        = string
}

variable "subnet_prefixes" {
    description = "Map of subnet names to their CIDR prefixes"
    type        = map(string)
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "address_space" {
    description = "Map of address spaces for different virtual networks"
    type        = map(string)
}

variable "hub_vnet_name" {
    description = "Name of the hub virtual network"
    type        = string
}

variable "backend_resource_group_name" {
    description = "Resource group name for the backend storage account"
    type        = string
}

variable "backend_storage_account_name" {
    description = "Storage account name for the backend"
    type        = string
}

variable "backend_container_name" {
    description = "Container name for the backend"
    type        = string
}

variable "backend_key" {
    description = "Key for the backend state file"
    type        = string
}

variable "management_subscription_id" {
    description = "Management subscription ID"
    type        = string
}

variable "identity_subscription_id" {
    description = "Identity subscription ID"
    type        = string
}

variable "landing_zone_1_subscription_id" {
    description = "Landing Zone 1 subscription ID"
    type        = string
}

variable "connectivity_resource_group_name" {
    description = "Name of the connectivity resource group"
    type        = string
}

variable "production_spoke_vnet_name" {
    description = "Name of the production spoke virtual network"
    type        = string
}

variable "non_production_spoke_vnet_name" {
    description = "Name of the second spoke virtual network"
    type        = string
}

variable "data_platform_spoke_vnet_name" {
    description = "Name of the third spoke virtual network"
    type        = string
}

variable "security_resource_group_name" {
    description = "Name of the security resource group"
    type        = string
}

variable "vm_size" {
    description = "Size of the virtual machines"
    type        = string
}
