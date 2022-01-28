
resource "azurerm_public_ip" "PIPLB2" {
  name                = var.PIP2
  location            = var.Region2
  resource_group_name = var.RSG
  allocation_method   = "Static"
    domain_name_label   = "wecamargo"
}

resource "azurerm_lb" "LB02" {
  name                = "LoadBalancerWE"
  location            = var.Region2
  resource_group_name = var.RSG

  frontend_ip_configuration {
    name                 = "PIPconf"
    public_ip_address_id = azurerm_public_ip.PIPLB2.id
  }
}

resource "azurerm_lb_backend_address_pool" "bppool2" {
  resource_group_name = var.RSG
  loadbalancer_id     = azurerm_lb.LB02.id
  name                = "BackEndAddressPool2"
}
