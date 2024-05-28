terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}


  #backend "azurerm" {
   # resource_group_name  = "sample"
 #   storage_account_name = "ltbackendstorage"
  #  container_name       = "tfstate"
  #  key                  = "springpetclinic.tfstate"
  #}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
