basename    = "iskan"
environment = "pp"

mssql_firewall_rules = [
  {
    name             = "iskan-pp-app-database"
    start_ip_address = "10.50.9.1"
    end_ip_address   = "10.50.9.127"
  },
  # TODO: Do we really need this?
  {
    name             = "desktop-ip"
    start_ip_address = "10.0.0.1"
    end_ip_address   = "10.0.255.254"
  }
]
