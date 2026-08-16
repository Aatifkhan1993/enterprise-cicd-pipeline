variable "vms" {
 type = map(any)
}
variable "subnet_ids" {
type = map(any)
}

variable "admin_password" {
  type      = string
  sensitive = true
}