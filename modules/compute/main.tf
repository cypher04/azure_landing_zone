resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic-1"
  location            = var.location
  resource_group_name = var.connectivity_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids["Shared_services"]
    private_ip_address_allocation = "Dynamic"
  }
  
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "vm-1"
  resource_group_name   = var.connectivity_resource_group_name
  location              = var.location
  size                  = "Standard_D4_v5"
  admin_username        = var.vm_admin_username
  admin_password        = var.vm_admin_password
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}