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
variable "landing_zone_1_subscription_id" {
    description = "The subscription ID for the landing zone resources."
    type        = string
}

variable "vm_size" {
    description = "The allowed VM size for the landing zone."
    type        = string
}

variable "azure_firewall_pip_id" {
    description = "The ID of the Azure Firewall Public IP."
    type        = string
}

variable "azure_firewall_public_ip_address" {
    description = "The Public IP of the Azure Firewall."
    type        = string
}

variable "landing_zone_rg" {
    description = "The resource group ID for the landing zone."
    type        = string
}

variable "management_group_ids" {
    description = "The management group ID for the landing zone."
    type        = map(string)
}