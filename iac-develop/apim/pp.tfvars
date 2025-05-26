environment = "pp"
basename    = "iskan"

apim_name = "apim"

# used as tags for resources
businessowner = "it"
serviceclass  = "non-prod" # (non-prod/prod)
client        = "adha"
project       = "iskan"

publisher_name       = "Ryan Loots"
publisher_email      = "ryan.loots@publicssapient.com"
sku_name             = "Premium_1"
virtual_network_type = "Internal"

needsSubscription = false

# needs to be updated with pp values
named_values = {
  "gis-endpoint"      = "http://10.50.13.226"
  "gis-endpoint-blue" = "http://10.50.36.152"
}

ratelimit        = "15000"
ratelimitrenewal = "30"

action_group = "iskan-pp-infra-alerts"