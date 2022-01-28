
resource "azurerm_virtual_network" "vnetwe" {
  name                = var.VnetWE
  address_space       = ["10.10.0.0/16"]
  location            = var.Region2
  resource_group_name = var.RSG
}

resource "azurerm_subnet" "Subnetwe" {
  name                 = var.Subnetwe
  resource_group_name  = var.RSG
  virtual_network_name = var.VnetWE
  address_prefixes     = ["10.10.0.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "scaleset2" {
  name                      = var.scalesetwe
  resource_group_name       = var.RSG
  location                  = var.Region2
  sku                       = "Standard_F2"
  instances                 = 1
  computer_name_prefix      = "VMWE"
  admin_username            = "vitorreis"
  admin_password            = var.pass   

  disable_password_authentication = false
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.Subnetwe.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bppool2.id]
      }
  }
}