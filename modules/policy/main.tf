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
            "in": [parameters('allowedLocations')]
        }
    },
    "then": {
        "effect": "deny"
  
}
POLICY_RULE


parameters = <<PARAMETERS
{

    "allowedLocations": {
        "type": "Array",
        "metadata": {
        "displayName": "Allowed Locations",
        "description": "The list of allowed locations for resources."
        }
    }
  
}
PARAMETERS

}

// vm size restriction policy
resource "azurerm_policy_definition" "vm_size_restriction_policy" {
  name         = "vm-size-restriction-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "VM Size Restriction Policy"
  description  = "This policy restricts the allowed VM sizes."

  policy_rule = <<POLICY_RULE
{
    "if": {
        "not": {
            "field": "type",
            "in": [parameters('allowedVMSizes')]
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
            "in": [parameters('allowedNSGs')]
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


// assi
