
resource "azurerm_resource_group" "practice1-rg" {
  location = var.resource_group_location
  name     = "Practice1-RG"
  }

# Create virtual network
resource "azurerm_virtual_network" "practice1-vnet" {
  name                = "Practice1-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.practice1-rg.location
  resource_group_name = azurerm_resource_group.practice1-rg.name
}

# Create subnet
resource "azurerm_subnet" "practice1-subnet1" {
  name                 = "Practice1-Subnet1"
  resource_group_name  = azurerm_resource_group.practice1-rg.name
  virtual_network_name = azurerm_virtual_network.practice1-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "practice1_public_ip1" {
  name                = "Practice1-PublicIP1"
  location            = azurerm_resource_group.practice1-rg.location
  resource_group_name = azurerm_resource_group.practice1-rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "practice1_nsg1" {
  name                = "Practice1-NSG1"
  location            = azurerm_resource_group.practice1-rg.location
  resource_group_name = azurerm_resource_group.practice1-rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interfaces
resource "azurerm_network_interface" "practice1_vm1_nic" {
  name                = "Practice1-VM1-NIC"
  location            = azurerm_resource_group.practice1-rg.location
  resource_group_name = azurerm_resource_group.practice1-rg.name

  ip_configuration {
    name                          = "Practice1-VM1-NIC-Configuration"
    subnet_id                     = azurerm_subnet.practice1-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.practice1_public_ip1.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "practice1_sga" {
  network_interface_id      = azurerm_network_interface.practice1_vm1_nic.id
  network_security_group_id = azurerm_network_security_group.practice1_nsg1.id
}