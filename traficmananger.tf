resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_traffic_manager_profile" "trafficmanager" {
  name                   = random_id.server.hex
  resource_group_name    = var.RSG
  traffic_routing_method = "Performance"


  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
} 

resource "azurerm_traffic_manager_endpoint" "endpoint1" {
  name                = "endpoint1"
  resource_group_name = var.RSG
  profile_name        = azurerm_traffic_manager_profile.trafficmanager.name
  type                = "azureEndpoints"
  target_resource_id  = azurerm_public_ip.PIPLB1.id
}

resource "azurerm_traffic_manager_endpoint" "endpoint2" {
  name                = "endpoint2"
  resource_group_name = var.RSG
  profile_name        = azurerm_traffic_manager_profile.trafficmanager.name
  type                = "azureEndpoints"
  target_resource_id  = azurerm_public_ip.PIPLB2.id
}