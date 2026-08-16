variable "rgs" {
  type = map(any)
}

variable "vnets" {
  type = map(any)
}

variable "subnets" {
  type = map(any)
}

variable "vms" {
  type = map(any)
}

variable "public_ips" {
  type = map(any)
}

variable "nsgs" {
  type = map(any)
}

variable "vnet_peerings" {
  type = map(any)
}

variable "subnet_nsg_associations" {
  type = map(any)
}

#variable "subnet_ids" {
  #type = map(any)
  # Remove this block if it is completely unused
#}

variable "bastions" {
  type = map(any)
}

#variable "app_gateways" {
  #type = map(any)
  # Remove this block if it is completely unused
#}

variable "load_balancers" {
  type = map(any)
}

variable "admin_password" {
  type        = string
  sensitive   = true
}