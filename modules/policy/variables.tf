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