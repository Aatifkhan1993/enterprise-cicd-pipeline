resource "azurerm_lb" "lb" {
  for_each            = var.load_balancers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "lb-frontend-ip"
    public_ip_address_id = each.value.public_ip_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.load_balancers
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = "BackendAddressPool"
}

resource "azurerm_lb_probe" "hp" {
  for_each        = var.load_balancers
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = "http-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.load_balancers
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  name                           = "LBRule-HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb-frontend-ip"
  probe_id                       = azurerm_lb_probe.hp[each.key].id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
}