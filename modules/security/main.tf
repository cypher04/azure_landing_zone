// resource group for security resources
resource "azurerm_resource_group" "security_rg" {
    name     = var.security_resource_group_name
    location = var.location
}



// Azure firewall 

resource "azurerm_firewall" "azure_firewall" {
    name                = "azure-firewall"
    location            = var.location
    resource_group_name = azurerm_resource_group.security_rg.name
    sku_name           = "AZFW_VNet"
    sku_tier           = "Standard"
    firewall_policy_id  = var.firewall_policy_id

    ip_configuration {
        name                 = "configuration"
        subnet_id            = var.subnet_ids["Azure_firewall"]
        public_ip_address_id = var.azure_firewall_pip_id
    }
}
