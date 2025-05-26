hub_peer_name      = "hub_prod"
hub_vnet_name      = "oss_hub_vnet"
hub_resource_group = "oss_hub"

spoke_peer_name      = "prod_hub"
spoke_vnet_name      = "iskan_prod_vnet"
spoke_resource_group = "iskan_prod"

allow_virtual_network_access = true
allow_forwarded_traffic      = true
allow_gateway_transit        = true