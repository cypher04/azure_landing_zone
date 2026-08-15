
variable "connectivity_resource_group_name" {
    description = "The name of the resource group for security resources"
    type        = string
}

variable "security_subscription_id" {
    description = "The ID of the security subscription"
    type        = string
}

variable "subnet_ids" {
    description = "The ID of the subnet for the private endpoint"
    type        = map(string)
}

variable "location" {
    description = "The location for the resources"
    type        = string
}

variable "keyvault_id" {
    description = "The ID of the Key Vault"
    type        = string
}

variable "Diagnostics_storage_account_id" {
    description = "The ID of the Diagnostic Storage Account"
    type        = string
}

variable "logs_storage_account_id" {
    description = "The ID of the Logs Storage Account"
    type        = string
}




variable "private_dns_zone_vault_id" {
    description = "The ID of the Private DNS Zone for Key Vault"
    type        = string
}

variable "diagnostics_logs_private_dns_zone_blob_id" {
    description = "The ID of the Diagnostics and Logs Storage Account"
    type        = string
}
