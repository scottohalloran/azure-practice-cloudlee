output "resource_group_name" {
  value = azurerm_resource_group.practice2-rg.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.practice2_vm1.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}