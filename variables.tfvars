application_configuration = {
  business_unit       = "ec"
  application_name    = "evd"
  environment         = "dev"
  subscription_id     = "d5a5facb-414b-4238-afdc-4412a1ac4f6b"
  resource_group_name = "dev-evdkp05-weu-rg"
 
  enit_keyvault_subscription_id = "2d65290b-c7e4-446b-b88e-885097246c97"
 
  azuread_tenant_id = "071e2e88-8ab9-41aa-b37b-53442cabf7b9"
 
  location = "westeurope"
 
  tags = {
    "applicationname" = "EVD Kritis",
    "costcenter"      = "999999"
    "department"      = "EVD-SCADA"
    "environment"     = "dev"
    "technicalowner"  = "tina.ruchel@enercon.de"
  }
 
  azurerm_virtual_machine_configuration = {}
 
  azurerm_virtual_desktop_hostpool_configuration = {
    pool_name                                       = "kp05"
    pool_type                                       = "Pooled"
    personal_desktop_assignment_type                = null
    location                                        = "westeurope"
    maximum_sessions_allowed                        = 5
    loadbalancer_type                               = "DepthFirst"
    virtual_desktop_host_pool_custom_rdp_properties = "drivestoredirect:s:;audiomode:i:1;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:0;devicestoredirect:s:;redirectcomports:i:0;redirectsmartcards:i:0;usbdevicestoredirect:s:;enablecredsspsupport:i:1;use multimon:i:1;camerastoredirect:s:"
  }
 
  azurerm_virtual_machine_global_configuration = {
    subnet_name                 = "dev-evd-kritis-weu-vnet-snet"
    subnet_virtual_network_name = "prd-evd-kritis-weu-vnet"
    subnet_resource_group_name  = "prd-evd-kritisnetwork-weu-rg"
 
    size = "Standard_D2s_v5"
  }
 
  azurerm_virtual_desktop_workspace_id = "/subscriptions/d5a5facb-414b-4238-afdc-4412a1ac4f6b/resourcegroups/dev-evd-kritis-weu-ws-rg/providers/Microsoft.DesktopVirtualization/workspaces/dev-evdkritis-weu-ws"
 
  azurerm_virtual_desktop_application_group_configuration = {
    coala_application_group = {
      name                                                           = "Kritis-COALA-App"
      location                                                       = "westeurope"
      virtual_desktop_application_group_friendly_name                = "Kritis-COALA-App"
      virtual_desktop_application_group_default_desktop_display_name = "Kritis-COALA-App"
      virtual_desktop_application_group_type                         = "RemoteApp"
      virtual_desktop_application_group_assignment                   = ["ce2d71e8-a8b0-41a1-bc54-848c8b7f2ee4"]
 
      azurerm_virtual_desktop_application_configuration = {
        SR3 = {
          friendly_name                = "COALA-ENERCON SCADA Remote"
          description                  = "COALA-ENERCON SCADA Remote"
          path                         = "C:\\Program Files (x86)\\ENERCON SCADA Remote 3\\ENERCON SCADA Remote 3.exe"
          command_line_argument_policy = "DoNotAllow"
          command_line_arguments       = ""
          show_in_portal               = false
          icon_path                    = "C:\\Program Files (x86)\\ENERCON SCADA Remote 3\\ENERCON SCADA Remote 3.exe"
          icon_index                   = 0
        }
      }
    }
    desktop_application_group = {
      name                                                           = "Kritis-COALA-Desktop"
      location                                                       = "westeurope"
      virtual_desktop_application_group_friendly_name                = "Kritis COALA Desktop"
      virtual_desktop_application_group_default_desktop_display_name = "Kritis COALA Desktop"
      virtual_desktop_application_group_type                         = "Desktop"
      virtual_desktop_application_group_assignment                   = ["ce2d71e8-a8b0-41a1-bc54-848c8b7f2ee4"]
      }
  }
 
  aad_role_assignment_vm_user_role_configuration = {
    aad_group_object_id = ["ce2d71e8-a8b0-41a1-bc54-848c8b7f2ee4"]
    role_definition     = "Virtual Machine User Login"
  }
  aad_role_assignment_smb_share_admin_group_id = ["bf5dec1b-1697-4e9b-b60b-4ad929d404c9"]
 
  azurerm_monitoring_configuration = {
    monitor_diagnostic_setting = {
      logs = [
        {
          category                 = "Error"
          enabled                  = true
          retention_policy_enabled = true
          retention_policy_days    = 30
        },
        {
          category                 = "AgentHealthStatus"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "Checkpoint"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "Connection"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "HostRegistration"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "Management"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "NetworkData"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "SessionHostManagement"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        },
        {
          category                 = "ConnectionGraphicsData"
          enabled                  = false
          retention_policy_enabled = false
          retention_policy_days    = 0
        }
      ]
 
      metrics = []
    }
  }
}
 
