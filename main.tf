provider "azurerm" {
  features {
    
  }
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tfstorage"
        storage_account_name = "tfspaladugu"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "eastus"
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "Public"
  dns_name_label      = "weatherapi"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "skpaladugu/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
} 



