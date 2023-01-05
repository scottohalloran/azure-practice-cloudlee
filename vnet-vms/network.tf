
resource "azurerm_resource_group" "practice2-rg" {
  location = var.resource_group_location
  name     = "Practice2-RG"
  }

# Create virtual network
resource "azurerm_virtual_network" "practice2-vnet" {
  name                = "Practice2-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name
}

# Create subnets
resource "azurerm_subnet" "practice2-subnet1" {
  name                 = "Practice2-Subnet1"
  resource_group_name  = azurerm_resource_group.practice2-rg.name
  virtual_network_name = azurerm_virtual_network.practice2-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "practice2-subnet2" {
  name                 = "Practice2-Subnet2"
  resource_group_name  = azurerm_resource_group.practice2-rg.name
  virtual_network_name = azurerm_virtual_network.practice2-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


# Create Network Security Groups
resource "azurerm_network_security_group" "practice2_nsg1" {
  name                = "Practice2-NSG1"
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name
}

resource "azurerm_network_security_group" "practice2_nsg1" {
  name                = "Practice2-NSG2"
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name
}

# Create network interfaces
resource "azurerm_network_interface" "practice2_vm1_nic" {
  name                = "Practice2-VM1-NIC"
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name

  ip_configuration {
    name                          = "Practice2-VM1-NIC-Configuration"
    subnet_id                     = azurerm_subnet.practice2-subnet1.id
    private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "practice2_vm2_nic" {
  name                = "Practice2-VM2-NIC"
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name

  ip_configuration {
    name                          = "Practice2-VM2-NIC-Configuration"
    subnet_id                     = azurerm_subnet.practice2-subnet1.id
    private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "practice2_vm3_nic" {
  name                = "Practice2-VM3-NIC"
  location            = azurerm_resource_group.practice2-rg.location
  resource_group_name = azurerm_resource_group.practice2-rg.name

  ip_configuration {
    name                          = "Practice2-VM3-NIC-Configuration"
    subnet_id                     = azurerm_subnet.practice2-subnet2.id
    private_ip_address_allocation = "Dynamic"
    }
}

# Connect the security groups to the subnets
resource ""azurerm_subnet_network_security_group_association"" "practice2_sga1" {
 subnet_id     = azurerm_network_security_group.practice2-subnet1.id
  network_security_group_id = azurerm_network_security_group.practice2_nsg1.id
}
resource ""azurerm_subnet_network_security_group_association"" "practice2_sga2" {
 subnet_id     = azurerm_network_security_group.practice2-subnet2.id
  network_security_group_id = azurerm_network_security_group.practice2_nsg2.id
}

