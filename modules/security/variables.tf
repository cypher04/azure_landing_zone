variable "security_subscription_id" {
    description = "The ID of the security subscription"
    type        = string
}

variable "security_resource_group_name" {
    description = "The name of the resource group where security resources will be created"
    type        = string
}

variable "location" {
    description = "The location where resources will be created"
    type        = string
}

variable "subnet_ids" {
    description = "A map of subnet names to their respective IDs"
    type        = map(string)
}

variable "azure_firewall_pip_id" {
    description = "The ID of the public IP address for the Azure Firewall"
    type        = string
}