variable "location" {
  description = "Location of cluster, if not defined it will be read from the resource-group"
  type        = string
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
}

variable "mssql_sql_database_edition" {
  type        = string
  default     = "Standard"
  description = "Sql database edition"
}

variable "mssql_sqldb_service_objective_name" {
  type        = string
  default     = "S1"
  description = "Mssql database service objective name"
}

variable "mssql_enable_threat_detection_policy" {
  type        = bool
  default     = true
  description = "Enable Thread detection policy"
}

# TODO
# maybe add log_retention_days as param

variable "mssql_enable_vulnerability_assessment" {
  type        = bool
  default     = false
  description = "Enable vulnerability assessment"
}

variable "mssql_email_addresses_for_alerts" {
  type = list(string)
  default = [
    "ryan.loots@publicssapient.com",
    "euglupul@publicisgroupe.net",
    "sourabh.sharma@publicissapient.com"
  ]
  description = "Email addresses for alerts"
}

variable "mssql_enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Enable private endpoint"
}

variable "mssql_admin_username" {
  type        = string
  default     = "sqladmin"
  description = "The value passed through this var will be computed. Basename and ENV will be added as prefixes"
}

variable "mssql_admin_password" {
  type        = string
  default     = null
  description = "Admin username password"
}


variable "mssql_enable_log_monitoring" {
  type        = bool
  default     = true
  description = "Enable log monitor"
}

variable "mmsql_enable_firewall_rules" {
  type        = bool
  default     = true
  description = "Enable firewall rules"
}

variable "mssql_firewall_rules" {
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default     = null
  description = "Firewall rules to be added in case they are enabled"
}

variable "default_tags" {
  type    = map(string)
  default = {}
}