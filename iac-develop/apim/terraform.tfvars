apim_product = [
  {
    product_id             = "iskan-default"
    display_name           = "Iskan-Default"
    subscriptions_limit    = "0"
    subscription_required  = false
    approval_required      = false
    published              = true
    product_policy_content = "generic/iskan-default-policy.xml"
  },
  {
    product_id             = "third-parties"
    display_name           = "Third-Parties"
    subscriptions_limit    = "0"
    subscription_required  = true
    approval_required      = false
    published              = true
    product_policy_content = "generic/third-parties-policy.xml"
  },
  {
    product_id             = "sse-api"
    display_name           = "SSE-API"
    subscriptions_limit    = "0"
    subscription_required  = false
    approval_required      = false
    published              = true
    product_policy_content = "generic/sse-api-policy.xml"
  },
  {
    product_id             = "outbound"
    display_name           = "Outbound"
    subscriptions_limit    = "0"
    subscription_required  = false
    approval_required      = false
    published              = true
    product_policy_content = "generic/outbound-policy.xml"
  },
  {
    product_id             = "cid-api"
    display_name           = "CID-API"
    subscriptions_limit    = "0"
    subscription_required  = false
    approval_required      = false
    published              = true
    product_policy_content = "generic/cid-api-policy.xml"
  }
]

allowedIPs = [
  "80.227.101.131",
  "10.95",
  "10.94",
  "10.92",
  "192.168.19",
  "10.201.13"
]

subscriptions = [
  {
    name          = "OSS"
    product_id    = "third-parties"
    allow_tracing = false
  },
  {
    name          = "TAMM"
    product_id    = "third-parties"
    allow_tracing = false
  },
  {
    name          = "DHP-UI"
    product_id    = "third-parties"
    allow_tracing = false
  },
  {
    name          = "DEV"
    product_id    = "third-parties"
    allow_tracing = false
  },
  {
    name          = "CID"
    product_id    = "cid-api"
    allow_tracing = false
  }
]
private_dns_zone_rg = "oss_hub"
private_dns_zone    = "azure-api.net"