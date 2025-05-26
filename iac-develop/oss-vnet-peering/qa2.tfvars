hub_peer_name      = "hub_qa2"
hub_vnet_name      = "oss_hub_vnet"
hub_resource_group = "oss_hub"

spoke_peer_name      = "qa2_hub"
spoke_vnet_name      = "iskan_qa2_vnet"
spoke_resource_group = "iskan_qa2"

allow_virtual_network_access = true
allow_forwarded_traffic      = true
allow_gateway_transit        = true