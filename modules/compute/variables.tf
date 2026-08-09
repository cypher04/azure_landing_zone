variable "landing_zone_1_subscription_id" {
    description = "The ID of the landing zone 1 subscription"
    type        = string
}

variable "location" {
    description = "The location for the resources"
    type        = string
}

variable "connectivity_resource_group_name" {
    description = "The name of the resource group for connectivity resources"
    type        = string
}

variable "subnet_ids" {
    description = "A map of subnet IDs"
    type        = map(string)
}

variable "vm_admin_username" {
    description = "The admin username for the virtual machines"
    type        = string
}

variable "vm_admin_password" {
    description = "The admin password for the virtual machines"
    type        = string
}