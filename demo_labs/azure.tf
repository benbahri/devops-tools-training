provider "azurerm" {
subscription_id = "70a4aa3c-ae75-45f5-baf6-bedf7812d45f"
client_id = "7a9cbcee-1d59-47fd-9fbe-f2540785d79d"
client_secret = "IytzVwBKmgN02Lpw4s2l1XX1l8CDr5OGr."
tenant_id = "dbd6664d-4eb9-46eb-99d8-5c43ba153c61"
features {}
}

resource "azurerm_virtual_network" "main" {
name                = "network-metis"
resource_group_name = "Terraform"
location            = "westeurope"
address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
name                    = "testsubnet"
resource_group_name     = "Terraform"
virtual_network_name    = "${azurerm_virtual_network.main.name}"
address_prefix          = "10.0.1.0/24"
}

resource "azurerm_network_interface" "main" {
name                = "vm-01-nic"
location            = "westeurope"
resource_group_name = "Terraform"

    ip_configuration {
    name                          = "ip-vm-01"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    }
}

resource "azurerm_virtual_machine" "main" {
name                                = "vm-01"
location                            = "westeurope"
resource_group_name                 = "Terraform"
network_interface_ids               = ["${azurerm_network_interface.main.id}"]
vm_size                             = "Standard_DS1_v2"
delete_os_disk_on_termination       = true
delete_data_disks_on_termination    = true

    storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
    }

    storage_os_disk {
    name              = "vm-01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    }

    os_profile {
    computer_name  = "vm-01"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    }

    os_profile_linux_config {
    disable_password_authentication = false
    }
}
