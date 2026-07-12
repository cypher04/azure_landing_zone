variable "location" {
    description = "The location where resources will be created"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group where the virtual network will be created"
    type        = string
}

variable "hub_vnet_name" {
    description = "The name of the hub virtual network"
    type        = string
}

variable "address_space" {
    description = "The address space for the hub virtual network"
    type        = map(string)
}

variable "subnet_prefixes" {
    description = "A map of subnet names to their respective address prefixes"
    type        = map(string)
}

variable "connectivity_resource_group_name" {
    description = "The name of the resource group for connectivity resources"
    type        = string
}

variable "production_spoke_vnet_name" {
    description = "Name of the production spoke virtual network"
    type        = string
}

variable "non_production_spoke_vnet_name" {
    description = "Name of the non-production spoke virtual network"
    type        = string
}

variable "data_platform_spoke_vnet_name" {
    description = "Name of the data platform spoke virtual network"
    type        = string
}

variable "firewall_private_ip" {
    description = "The private IP address of the Azure Firewall"
    type        = string
}