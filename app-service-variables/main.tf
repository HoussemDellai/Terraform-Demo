terraform {
  backend "azurerm" {
  #  resource_group_name  = "TerraformState"
  #  storage_account_name = "terraformstatehoussem"
  #  container_name       = "terraform-state"
  #  key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  version = ">=2.0"
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}

resource "azurerm_resource_group" "resource_group_terraform" {
  name     = "terraform_resource_group_4"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app_service_plan_terraform" {
  name                = "terraform-appserviceplan"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service_terraform" {
  name                = "app-service-terraform-houssem-4"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_terraform.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
