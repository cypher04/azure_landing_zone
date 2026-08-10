resource "azurerm_log_analytics_workspace" "LogAnalyticsWorkspace" {
  name                = "loganalytics${random_string.random.result}"
  location            = var.location
  resource_group_name = var.security_resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  
}

resource "random_string" "random" {
  length  = 4
  special = false
}


// Diagnostics settings for the storage accounts
resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingStorageAccount" {
  name                       = "diagnostic-setting-storage-account"
  target_resource_id         = var.Diagnostics_storage_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  enabled_log {
    category = "AuditEvent"
  }

    enabled_metric {
        category = "AllMetrics"
    }

}


resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingLogsStorageAccount" {
  name                       = "diagnostic-setting-logs-storage-account"
  target_resource_id         = var.logs_storage_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

 enabled_log {
    category = "StorageRead"
  }

    enabled_metric {
        category = "AllMetrics"
    }

}

// Diagnostic settings for the Key Vault

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingKeyVault" {
  name                       = "diagnostic-setting-keyvault"
  target_resource_id         = var.keyvault_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  enabled_log {
    category = "AuditEvent"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}

// Diagnostic settings for firewall

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingFirewall" {
  name                       = "diagnostic-setting-firewall"
  target_resource_id         = var.firewall_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  enabled_log {
    category = "AzureFirewallApplicationRule"
  }

  enabled_log {
    category = "AzureFirewallNetworkRule"
  }

  enabled_log {
    category = "AzureFirewallDnsProxy"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}


// Diagnostic settings for vnets

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingVnets" {
  name                       = "diagnostic-setting-vnets"
  target_resource_id         = var.hub_vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  # enabled_log {
  #   category = "NetworkSecurityGroupEvent"
  # }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingVnetsProduction" {
  name                       = "diagnostic-setting-vnets-production"
  target_resource_id         = var.production_spoke_vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  # enabled_log {
  #   category = "NetworkSecurityGroupEvent"
  # }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingVnetsNonProduction" {
  name                       = "diagnostic-setting-vnets-non-production"
  target_resource_id         = var.non_production_spoke_vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  # enabled_log {
  #   category = "NetworkSecurityGroupEvent"
  # }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}

resource "azurerm_monitor_diagnostic_setting" "DiagnosticSettingVnetsDataPlatform" {
  name                       = "diagnostic-setting-vnets-data-platform"
  target_resource_id         = var.data_platform_spoke_vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LogAnalyticsWorkspace.id

  # enabled_log {
  #   category = "NetworkSecurityGroupEvent"
  # }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }

    enabled_metric {
        category = "AllMetrics"
    }
}

///////////// Monitor Alerts 

resource "azurerm_monitor_action_group" "MonitorActionGroup" {
  name                = "monitor-action-group-${random_string.random.result}"
  resource_group_name = var.security_resource_group_name
  short_name          = "monitorAG"

  webhook_receiver {
    name        = "webhook-receiver"
    service_uri = "https://example.com/webhook"
  }
}

// Alerts for high cpu usage on virtual machines
resource "azurerm_monitor_metric_alert" "HighCpuUsageAlert" {
  name                = "high-cpu-usage-alert-${random_string.random.result}"
  resource_group_name = var.security_resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert for high CPU usage on virtual machines"


    criteria {
        metric_namespace = "Microsoft.Compute/virtualMachines"
        metric_name      = "Percentage CPU"
        aggregation      = "Average"
        operator         = "GreaterThan"
        threshold        = 80
    }



    action {
        action_group_id = azurerm_monitor_action_group.MonitorActionGroup.id

        # webhook_properties = {
        #     from = "terraform"
        # }
    }

}

// Alerts for failed login attempts on virtual machines
resource "azurerm_monitor_activity_log_alert" "FailedLoginAttemptsAlert" {
  name                = "failed-login-attempts-alert-${random_string.random.result}"
  resource_group_name = var.security_resource_group_name
  scopes              = [var.vm_id]
  description         = "Alert for failed login attempts on virtual machines"
  location            = var.location
  
    criteria {
        category = "Administrative"
        operation_name = "Microsoft.Compute/virtualMachines/login/action"
        status = "Failed"
        resource_id = var.vm_id
    }

    action {
        action_group_id = azurerm_monitor_action_group.MonitorActionGroup.id

        # webhook_properties = {
        #     from = "terraform"
        # }
    }
}


// Alertts for firewall denied connections
resource "azurerm_monitor_activity_log_alert" "FirewallDeniedConnectionsAlert" {
  name                = "firewall-denied-connections-alert-${random_string.random.result}"
  resource_group_name = var.security_resource_group_name
  scopes              = [var.firewall_id]
  description         = "Alert for denied connections on Azure Firewall"
  location            = var.location

    criteria {
        category = "Security"
        operation_name = "Microsoft.Network/azureFirewalls/deny/action"
        status = "Failed"
        resource_id = var.firewall_id
    }

    action {
        action_group_id = azurerm_monitor_action_group.MonitorActionGroup.id

        webhook_properties = {
            from = "terraform"
        }
    }
}