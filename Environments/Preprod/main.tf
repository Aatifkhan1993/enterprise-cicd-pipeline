
module "resource_group" {
  source ="../../module/azurerm_resource_group"
  rgs=var.rgs
}

module "virtual_network" {
    source="../../module/azurerm_virtual_network"
    vnets = var.vnets
}

module "subnet" {
  source = "../../module/azurerm_subnet"
  subnets = var.subnets
}

module "public_ips" {
  source     = "../../Module/azurerm_public_ip"
  public_ips = var.public_ips
  depends_on = [module.resource_group]
}

module "vm" {
  source = "../../Module/azurerm_virtual_machine"

  vms            = var.vms
  admin_password = var.admin_password

  subnet_ids = {
    "vm1" = module.subnet.subnet_ids["subnet1"]
    "vm2" = module.subnet.subnet_ids["subnet2"]
  }

  depends_on = [module.subnet, module.public_ips]
}

module "network_security_group" {
  source                  = "../../Module/azurerm_network_security_group"
  nsgs                    = var.nsgs
  depends_on              = [module.resource_group, module.virtual_network]
}

module "vnet_peering" {
  source                      = "../../Module/azurerm_virtual_network_peering"
  vnet_peerings               = var.vnet_peerings
  depends_on                  = [module.virtual_network]
}

module "bastion" {
  source     = "../../Module/azurerm_Bastion"
  bastions   = var.bastions
  depends_on = [module.subnet, module.public_ips]
}

module "load_balancer" {
  source         = "../../Module/azurerm_load_balancer"
  load_balancers = var.load_balancers
  depends_on     = [module.public_ips]
}