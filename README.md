# Practice 1
Creates the following resources:
1 resource group called Practice1-RG
1 VNET called Practice1-VNET that is in Practice1-RG
1 subnet called Practice1-Subnet1 that is in Practice1-VNET
1 VM called Practice1-VM1 that is in Practice1-RG
1 network interface called Practice1-VM1-NIC that is attached to Practice1-VM1
1 public IP called Practice1-PublicIP1 that is attached to Practice1-VM1-NIC

To SSH to the VM
Create the private key file
terraform output -raw tls_private_key > id_rsa
Set its permissions
chmod 400 id_rsa
ssh -i id_rsa adminuser@<publicipaddress>