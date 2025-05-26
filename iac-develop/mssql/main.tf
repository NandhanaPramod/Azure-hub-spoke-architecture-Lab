locals {
  tags = merge(
    var.default_tags,
    {
      Environment = upper(var.environment)
      Location    = lower(var.location)
    }
  )
}

data "azurerm_resource_group" "this" {
  name = "${var.basename}_${var.environment}"
}

data "azurerm_virtual_network" "this" {
  name                = "${var.basename}_${var.environment}_vnet"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  name                 = "${var.basename}_${var.environment}_database"
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = data.azurerm_resource_group.this.name
}

resource "random_password" "this" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

module "mssql-server" {
  source  = "kumarvna/mssql-db/azurerm"
  version = "1.3.0"

  create_resource_group = false
  resource_group_name   = data.azurerm_resource_group.this.name
  location              = data.azurerm_resource_group.this.location

  # SQL Server and Database details
  # The valid service objective name for the database include S0, S1, S2, S3, P1, P2, P4, P6, P11 
  sqlserver_name               = join("-", [var.basename, var.environment, "db", "server", "01"])
  database_name                = join("", [var.basename, var.environment, "api", "db", "01"])
  sql_database_edition         = var.mssql_sql_database_edition
  sqldb_service_objective_name = var.mssql_sqldb_service_objective_name

  enable_threat_detection_policy = var.mssql_enable_threat_detection_policy
  log_retention_days             = 30

  enable_vulnerability_assessment = var.mssql_enable_vulnerability_assessment
  email_addresses_for_alerts      = var.mssql_email_addresses_for_alerts

  enable_private_endpoint = var.mssql_enable_private_endpoint
  existing_vnet_id        = data.azurerm_virtual_network.this.id
  existing_subnet_id      = data.azurerm_subnet.this.id

  admin_username = join("", [var.basename, var.environment, var.mssql_admin_username])
  admin_password = var.mssql_admin_password == null ? random_password.this.result : var.mssql_admin_password

  enable_log_monitoring = var.mssql_enable_log_monitoring

  # Firewall Rules to allow azure and external clients and specific Ip address/ranges. 
  enable_firewall_rules = var.mmsql_enable_firewall_rules
  firewall_rules        = var.mssql_firewall_rules

  # Adding additional TAG's to your Azure resources
  tags = local.tags
}
