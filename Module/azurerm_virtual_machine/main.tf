resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "aatif"
    subnet_id                 = var.subnet_ids[each.key]
    public_ip_address_id = lookup(data.azurerm_public_ip.public_ip, each.key, null) != null ? data.azurerm_public_ip.public_ip[each.key].id : null
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = each.value.vm_size
  admin_username                  = "aamohamm"
  admin_password = var.admin_password
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]
os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
