resource "azurerm_resource_group" "security_rg" {
  name     = var.security_resource_group_name
  location = var.location
}


// location restriction policy
resource "azurerm_policy_definition" "location_restriction_policy" {
  name         = "location-restriction-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Location Restriction Policy"
  description  = "This policy restricts the allowed locations for resources."

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "equals": ${jsonencode(var.location)}
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE

}

// vm size restriction policy
# resource "azurerm_policy_definition" "vm_size_restriction_policy" {
#   name         = "vm-size-restriction-policy"
#   policy_type  = "Custom"
#   mode         = "All"
#   display_name = "VM Size Restriction Policy"
#   description  = "This policy restricts the allowed VM sizes."

#   policy_rule = <<POLICY_RULE
# {
#     "if": {
#         "not": {
#             "field": "Microsoft.Compute/virtualMachines/sku.name",
#             "in": "[parameters('allowedVMSizes')]"
#         }
#     },
#     "then": {
#         "effect": "deny"
#     }
# }
# POLICY_RULE

#   parameters = <<PARAMETERS
# {
#     "allowedVMSizes": {
#         "type": "Array",
#         "metadata": {
#             "displayName": "Allowed VM Sizes",
#             "description": "The list of allowed VM sizes."
#         }
#     }
# }
# PARAMETERS

# }

resource "azurerm_policy_definition" "vm_size_restriction_policy" {
  name         = "vm-size-restriction-policy"
  management_group_id = var.management_group_ids["landing_zone"]
  policy_type  = "Custom"
  mode         = "All"
  display_name = "VM Size Restriction Policy"
  description  = "This policy restricts the allowed VM sizes."

  policy_rule = <<POLICY_RULE
{
    "if": {
        "not": {
            "field": "Microsoft.Compute/virtualMachines/sku.name",
            "in": "[parameters('allowedVMSizes')]"
        }
    },
    "then": {
        "effect": "deny"
    }
}
POLICY_RULE 

parameters = <<PARAMETERS
{
    "allowedVMSizes": {
        "type": "Array",
        "metadata": {
            "displayName": "Allowed VM Sizes",
            "description": "The list of allowed VM sizes."
        }
    }
}
PARAMETERS
}


// network security group policy
resource "azurerm_policy_definition" "nsg_restriction_policy" {
  name         = "nsg-restriction-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "NSG Restriction Policy"
  description  = "This policy restricts the allowed network security groups."

  policy_rule = <<POLICY_RULE
{
    "if": {
        "not": {
            "field": "type",
            "in": "[parameters('allowedNSGs')]"
        }
    },
    "then": {
        "effect": "deny"
    }
}
POLICY_RULE

  parameters = <<PARAMETERS
{
    "allowedNSGs": {
        "type": "Array",
        "metadata": {
            "displayName": "Allowed NSGs",
            "description": "The list of allowed network security groups."
        }
    }
}
PARAMETERS

}


// assign the policies to Security Subscription
resource "azurerm_subscription_policy_assignment" "location_restriction_assignment" {
  name                 = "location-restriction-assignment"
  subscription_id      = "/subscriptions/${var.security_subscription_id}"
  policy_definition_id = azurerm_policy_definition.location_restriction_policy.id
}

// assign the VM size restriction policy to landing Subscription
resource "azurerm_management_group_policy_assignment" "vm_size_restriction_assignment" {
  name                 = "vm-size-restriction"
  management_group_id  = var.management_group_ids["landing_zone"]
  policy_definition_id = azurerm_policy_definition.vm_size_restriction_policy.id


  parameters = <<PARAMETERS
{
    "allowedVMSizes": {
        "value": ${jsonencode(var.vm_size)}
    }
}
PARAMETERS
}
  


// assign the NSG restriction policy to landing Subscription



// firewall policy
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = "firewall-policy"
  resource_group_name = azurerm_resource_group.security_rg.name
  location            = azurerm_resource_group.security_rg.location
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_group" {
  name                = "firewall-policy-rule-collection-group"
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id
  priority            = 100

  application_rule_collection {
    name     = "app_rule_collection1"
    priority = 500
    action   = "Deny"
    rule {
      name = "app_rule_collection1_rule1"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
      destination_fqdns = ["*.microsoft.com"]
    }
  }

  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 400
    action   = "Deny"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["10.2.0.0/16"]
      destination_ports     = ["80", "1000-2000"]
    }
  }

  network_rule_collection {
    name = "Allow-production_spoke"
    priority = 300
    action = "Allow"

    rule {
      name = "Allow-production_spoke_rule1"
      protocols = ["TCP"]
      source_addresses = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
      destination_addresses = ["*"]
      destination_ports = ["80", "443"]
    }
  }

  nat_rule_collection {
    name     = "nat_rule_collection1"
    priority = 200
    action   = "Dnat"
    rule {
      name                = "nat_rule_collection1_rule1"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["*"]
      destination_address = var.azure_firewall_public_ip_address
      destination_ports   = ["80"]
      translated_address  = "10.1.0.1"
      translated_port     = "8080"
    }
  }
}
  
