#data "azurerm_resource_group" "rg" {
  #name = "aatif-rg"
#}

#data "azurerm_virtual_network" "vnet" {
  #name                = "vnet-prod"
  #resource_group_name = data.azurerm_resource_group.rg.name
#}

data "azurerm_public_ip" "public_ip" {
  for_each            = { for k, v in var.vms : k => v if k == "vm1" } # 👈 SIRF vm1 KE LIYE
  name                = "pip-aatif-frontend-vm"
  resource_group_name = "aatif-rg"
}