# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "practice1_vm1" {
  name                  = "Practice1-VM1"
  location              = azurerm_resource_group.practice1-rg.location
  resource_group_name   = azurerm_resource_group.practice1-rg.name
  network_interface_ids = [azurerm_network_interface.practice1_vm1_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Practice1-VM1-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "Practice1-VM1"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
    
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.practice1_storage_account.primary_blob_endpoint
  }
}