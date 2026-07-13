variable "root_management_group_subscription_id" {
  description = "The ID of the root management group subscription"
  type        = string
}

variable "connectivity_subscription_id" {
  description = "The ID of the connectivity subscription"
  type        = string
}

variable "security_subscription_id" {
  description = "The ID of the security subscription"
  type        = string
}

variable "management_subscription_id" {
  description = "The ID of the management subscription"
  type        = string
}


variable "identity_subscription_id" {
  description = "The ID of the identity subscription"
  type        = string
}

variable "landing_zone_1_subscription_id" {
  description = "The ID of the landing zone 1 subscription"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where resources will be created"
  type        = string
}