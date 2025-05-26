environment          = "qa"
backwards_compatible = true
apim_name            = "apim"

# used as tags for resources
businessowner = "it"
serviceclass  = "non-prod" # (non-prod/prod)
client        = "adha"
project       = "iskan"

publisher_name       = "Ryan Loots"
publisher_email      = "ryan.loots@publicssapient.com"
sku_name             = "Developer_1"
virtual_network_type = "Internal"

needsSubscription = false

named_values = {
  "gis-endpoint" = "http://10.50.32.110"
}

ratelimit        = "15000"
ratelimitrenewal = "30"

action_group = "oss-qa-infra-alerts"