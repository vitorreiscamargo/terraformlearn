terraform {
  
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate25265"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        access_key           = "###################"
    }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RSG" {
  name     = var.RSG
  location = var.Region1
}

resource "azurerm_virtual_network" "vnetbr" {
  name                = var.VnetBR
  address_space       = ["10.0.0.0/16"]
  location            = var.Region1
  resource_group_name = var.RSG
}

resource "azurerm_subnet" "Subnetbr" {
  name                 = var.Subnetbr
  resource_group_name  = var.RSG
  virtual_network_name = var.VnetBR
  address_prefixes     = ["10.0.10.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                      = var.scalesetbr
  resource_group_name       = var.RSG
  location                  = var.Region1
  sku                       = "Standard_F2"
  instances                 = 1
  computer_name_prefix      = "VMBR"
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
      subnet_id = azurerm_subnet.Subnetbr.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bppool.id]
      }
  }
}
