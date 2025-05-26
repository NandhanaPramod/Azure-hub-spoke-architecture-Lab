hub_peer_name      = "hub_qa"
hub_vnet_name      = "oss_hub_vnet"
hub_resource_group = "oss_hub"

spoke_peer_name      = "qa_hub"
spoke_vnet_name      = "oss_qa_vnet"
spoke_resource_group = "oss_qa"

allow_virtual_network_access = true
allow_forwarded_traffic      = true
allow_gateway_transit        = true