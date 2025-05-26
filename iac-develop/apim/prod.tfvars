environment = "prod"
basename    = "iskan"

apim_name = "apim"

# used as tags for resources..
businessowner = "it"
serviceclass  = "prod" # (non-prod/prod)
client        = "adha"
project       = "iskan"

publisher_name       = "Ryan Loots"
publisher_email      = "ryan.loots@publicssapient.com"
sku_name             = "Premium_1"
virtual_network_type = "Internal"

needsSubscription = false

# needs to be updated with prod values
named_values = {
  "gis-endpoint"      = "http://10.50.17.220"
  "gis-endpoint-blue" = "http://10.50.39.220"
}

ratelimit        = "1000"
ratelimitrenewal = "30"

action_group = "iskan-prod-infra-alerts"
