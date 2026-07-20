variable "security_subscription_id" {
    description = "The subscription ID for the security resources."
    type        = string
}

variable "location" {
    description = "The location for the security resources."
    type        = string
}

variable "security_resource_group_name" {
    description = "The name of the resource group for security resources."
    type        = string
}

variable "keyvault_secret_names" {
    description = "Map of keyvault secret names"
    type        = map(string)
}

variable "keyvault_secret_value"{
        description = "Value of the keyvault secret"
        type        = string
    }

variable "keyvault_certificate_names" {
    description = "Map of keyvault certificate names"
    type        = map(string)
}

variable "keyvault_certificate_contents" {
    description = "Contents of the keyvault certificates"
    type        = string
}

variable "keyvault_certificate_password" {
    description = "Password for the keyvault certificates"
    type        = string
}
variable "keyvault_key_names" {
    description = "Map of keyvault key names"
    type        = map(string)
}