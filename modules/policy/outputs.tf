output "firewall_policy_id" {
    value = azurerm_firewall_policy.firewall_policy.id
}

output "security_resource_group_name" {
    value = azurerm_resource_group.security_rg.name
}