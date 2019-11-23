####################################################
#----------   main.tf   ----------------------

resource "random_string" "random" {
  length  = 6
  upper   = false
  special = false
}

resource "random_password" "password" {
  length  = 12
  special = true
}

resource "azurerm_resource_group" "test" {
  name     = "${random_string.random.result}-resources"
  location = var.location

  tags = var.tags
}

resource "azurerm_app_service_plan" "test" {
  name                = "${random_string.random.result}-app-service-plan"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  #  use_32_bit_worker_process = true

  sku {
    tier = "Free"  ##  Can only use Free Tier if use_32...
    size = "F1"    ##  is set is the Site_Config of the App Service
  }

  tags = var.tags
}

resource "azurerm_app_service" "test" {
  name                = "${random_string.random.result}-app-service"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.test.id

  site_config {
    dotnet_framework_version  = "v4.0"
    scm_type                  = "LocalGit"
    use_32_bit_worker_process = true  ##  Required for Free Tier-F1
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.test.fully_qualified_domain_name} Database=${azurerm_sql_database.test.name};User ID=${azurerm_sql_server.test.administrator_login};Password=${azurerm_sql_server.test.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }

  tags = var.tags
}

resource "azurerm_sql_server" "test" {
  name                         = "${random_string.random.result}-sqlserver"
  resource_group_name          = azurerm_resource_group.test.name
  location                     = azurerm_resource_group.test.location
  version                      = "12.0"
  administrator_login          = random_string.random.result
  administrator_login_password = random_password.password.result

  tags = var.tags
}

resource "azurerm_sql_database" "test" {
  name                = "${random_string.random.result}-sqldatabase"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  server_name         = azurerm_sql_server.test.name

  tags = var.tags
}
