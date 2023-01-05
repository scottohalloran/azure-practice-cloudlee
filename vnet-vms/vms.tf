# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "practice2_vm1" {
  name                  = "Practice2-VM1"
  location              = azurerm_resource_group.practice2-rg.location
  resource_group_name   = azurerm_resource_group.practice2-rg.name
  network_interface_ids = [azurerm_network_interface.practice2_vm1_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Practice2-VM1-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "Practice2-VM1"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
    
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.practice2_storage_account.primary_blob_endpoint
  }
}

resource "azurerm_linux_virtual_machine" "practice2_vm2" {
  name                  = "Practice2-VM2"
  location              = azurerm_resource_group.practice2-rg.location
  resource_group_name   = azurerm_resource_group.practice2-rg.name
  network_interface_ids = [azurerm_network_interface.practice2_vm2_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Practice2-VM2-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "Practice2-VM2"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
    
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.practice2_storage_account.primary_blob_endpoint
  }
}

resource "azurerm_linux_virtual_machine" "practice2_vm3" {
  name                  = "Practice2-VM3"
  location              = azurerm_resource_group.practice2-rg.location
  resource_group_name   = azurerm_resource_group.practice2-rg.name
  network_interface_ids = [azurerm_network_interface.practice2_vm3_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Practice2-VM3-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "Practice2-VM3"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
    
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.practice2_storage_account.primary_blob_endpoint
  }
}