terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}
  # backend "azurerm" {
  #   resource_group_name  = "aatif-rg"
  #   storage_account_name = "aatifstorage"
  #   container_name       = "tfstate"
  #   key                  = "resource_group.tfstate"
  # }
#}

provider "azurerm" {
  features {}
  subscription_id = "f571aa99-7d30-41b0-b690-0be824893194"
}