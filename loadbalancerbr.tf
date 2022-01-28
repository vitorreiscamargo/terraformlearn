resource "azurerm_resource_group" "LB1" {
  name     = "LoadBalancerBR"
  location = var.Region1
}

resource "azurerm_public_ip" "PIPLB1" {
  name                = var.PIP1
  location            = var.Region1
  resource_group_name = var.RSG
  allocation_method   = "Static"
  domain_name_label   = "brcamargo"
}

resource "azurerm_lb" "LB01" {
  name                = "LoadBalancerBR"
  location            = var.Region1
  resource_group_name = var.RSG

  frontend_ip_configuration {
    name                 = "PIPconf"
    public_ip_address_id = azurerm_public_ip.PIPLB1.id
  }
}

resource "azurerm_lb_backend_address_pool" "bppool" {
  resource_group_name = var.RSG
  loadbalancer_id     = azurerm_lb.LB01.id
  name                = "BackEndAddressPool1"
}
