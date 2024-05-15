[9:16 AM] Nivetha R-EXTERNAL
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
 
[9:17 AM] Nivetha R-EXTERNAL
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.20.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "=0.7.2"
    }
  }
  backend "azurerm" {}
}
 
provider "azurerm" {
  features {}
}
 
provider "azurerm" {
  alias                      = "enit_keyvault"
  subscription_id            = var.application_configuration.enit_keyvault_subscription_id
  skip_provider_registration = true
  features {}
}
 
provider "azuread" {
  tenant_id = var.application_configuration.azuread_tenant_id
}
 
data "azurerm_resource_group" "app_rg" {
  name = var.application_configuration.resource_group_name
}
 
data "azurerm_key_vault" "enit_key_vault" {
  provider            = azurerm.enit_keyvault
  name                = "ec-prd-enit-weu-kv"
  resource_group_name = "prd-keyvault-weu-rg"
}
 
data "azurerm_key_vault_secret" "ad_join_username" {
  provider     = azurerm.enit_keyvault
  name         = "tec-wvd-adjoinadmin-ad-login"
  key_vault_id = data.azurerm_key_vault.enit_key_vault.id
}
 
data "azurerm_key_vault_secret" "ad_join_password" {
  provider     = azurerm.enit_keyvault
  name         = "tec-wvd-adjoinadmin-ad-password"
  key_vault_id = data.azurerm_key_vault.enit_key_vault.id
}
 
module "azurerm_evd_hostpool" {
  source = "git::https://Enercon@dev.azure.com/Enercon/Cloud%20Infrastructure/_git/terraform-module-azurerm-evd-hostpool?ref=v1.0.3"
 
  resource_group = data.azurerm_resource_group.app_rg
 
  application_configuration                      = var.application_configuration
  azurerm_virtual_desktop_hostpool_configuration = var.application_configuration.azurerm_virtual_desktop_hostpool_configuration
}
 
module "azurerm_evd_application" {
  source = "git::https://Enercon@dev.azure.com/Enercon/Cloud%20Infrastructure/_git/terraform-module-azurerm-evd-application?ref=v0.0.3"
 
  for_each = { for application_group, config in lookup(var.application_configuration, "azurerm_virtual_desktop_application_group_configuration", {}) : application_group => config }
 
  resource_group                       = data.azurerm_resource_group.app_rg
  azurerm_virtual_desktop_host_pool_id = module.azurerm_evd_hostpool.hostpool_id
  azurerm_virtual_desktop_workspace_id = var.application_configuration.azurerm_virtual_desktop_workspace_id
 
  application_configuration                               = var.application_configuration
  azurerm_virtual_desktop_hostpool_configuration          = var.application_configuration.azurerm_virtual_desktop_hostpool_configuration
  azurerm_virtual_desktop_application_group_configuration = each.value
}
 
module "azurerm_virtual_machine" {
  source = "git::https://Enercon@dev.azure.com/Enercon/Cloud%20Infrastructure/_git/terraform-module-azurerm-virtual-machine?ref=v2.0.3"
 
 
  for_each       = { for virtual_machine, config in var.azurerm_virtual_machine_configuration : virtual_machine => config }
  resource_group = data.azurerm_resource_group.app_rg
  vm_name        = each.key
 
  application_configuration                    = var.application_configuration
  azurerm_virtual_machine_global_configuration = var.application_configuration.azurerm_virtual_machine_global_configuration
  azurerm_virtual_machine_configuration        = each.value
}
 
resource "azurerm_virtual_machine_extension" "ad_join" {
  for_each = module.azurerm_virtual_machine
  depends_on = [
    azurerm_virtual_machine_extension.avd
  ]
 
  name                 = "JsonADDomainExtension"
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  virtual_machine_id   = module.azurerm_virtual_machine[each.key].windows_virtual_machine_id[0]
 
  settings = <<SETTINGS
{
"Name"   : "enercon.de",
"OUPath" : "OU=Admins,OU=Kritis,OU=DEV,OU=VDI-EVD,OU=Clients,OU=Computers,OU=Accounts1,DC=enercon,DC=de",
"User"   : "ENERCON1\\${data.azurerm_key_vault_secret.ad_join_username.value}",
"Restart": "true",
"Options": "3"
}
SETTINGS
 
  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${data.azurerm_key_vault_secret.ad_join_password.value}"
}
PROTECTED_SETTINGS
 
  tags = lookup(var.azurerm_virtual_machine_configuration, "tags", var.application_configuration.tags)
}
 
resource "azurerm_virtual_machine_extension" "avd" {
  for_each = module.azurerm_virtual_machine
 
  name                 = "Microsoft.PowerShell.DSC"
  publisher            = "Microsoft.PowerShell"
  type                 = "DSC"
  type_handler_version = "2.73"
  virtual_machine_id   = module.azurerm_virtual_machine[each.key].windows_virtual_machine_id[0]
  settings             = <<SETTINGS
  {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_6-1-2021.zip",
      "ConfigurationFunction": "Configuration.ps1\\AddSessionHost",
      "Properties" : {
        "hostPoolName" : "${module.azurerm_evd_hostpool.hostpool_name}",
        "aadJoin": true
      }
  }
SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
  {
    "properties": {
      "registrationInfoToken": "${module.azurerm_evd_hostpool.pool_registration_token}"
    }
  }
PROTECTED_SETTINGS
 
  lifecycle {
    ignore_changes = [
      # Ignore changes to protected_settings, because it is only needed on the first time of deployment
      protected_settings,
    ]
  }
 
  tags = lookup(var.azurerm_virtual_machine_configuration, "tags", var.application_configuration.tags)
}
 
resource "azurerm_role_assignment" "virtual_machine_user" {
  for_each = toset(var.application_configuration.aad_role_assignment_vm_user_role_configuration.aad_group_object_id)
 
  scope                = data.azurerm_resource_group.app_rg.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = each.value
}
 
 
module "azurerm_monitoring" {
  source = "git::https://Enercon@dev.azure.com/Enercon/Cloud%20Infrastructure/_git/terraform-module-azurerm-monitoring?ref=v1.0.1"
 
  resource_group     = data.azurerm_resource_group.app_rg
  target_resource_id = module.azurerm_evd_hostpool.hostpool_id
 
  azurerm_monitoring_scope         = var.application_configuration.azurerm_virtual_desktop_hostpool_configuration.pool_name
  azurerm_monitoring_configuration = var.application_configuration.azurerm_monitoring_configuration
  application_configuration        = var.application_configuration
}
 
data "azurerm_subnet" "this" {
  name                 = var.application_configuration.azurerm_virtual_machine_global_configuration.subnet_name
  resource_group_name  = var.application_configuration.azurerm_virtual_machine_global_configuration.subnet_resource_group_name
  virtual_network_name = var.application_configuration.azurerm_virtual_machine_global_configuration.subnet_virtual_network_name
}
