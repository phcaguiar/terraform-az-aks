resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.cluster_name}"
    location            = "${var.location}"
    resource_group_name = "${var.azure_resource_group}"
    dns_prefix          = "${var.dns_prefix}"

    linux_profile {
        admin_username = "${var.linux_profile_admin_username}"

        ssh_key {
        key_data = "${file("${var.linux_profile_ssh_key}")}"
        }
    }

    agent_pool_profile {
        name            = "${var.agent_pool_profile_name}"
        count           = "${var.agent_pool_profile_count}"
        vm_size         = "${var.agent_pool_profile_vm_size}"
        os_type         = "${var.agent_pool_profile_os_type}"
        os_disk_size_gb = "${var.agent_pool_profile_os_disk_size_gb}"
        max_pods        = "${var.agent_pool_profile_max_pods}"
        vnet_subnet_id  = "${var.agent_pool_profile_vnet_subnet_id}"
    }

    service_principal {
        client_id     = "${var.service_principal_client_id}"
        client_secret = "${var.service_principal_client_secret}"
    }

    network_profile {
        network_plugin = "azure"
    }

    addon_profile {
        oms_agent {
            enabled                    = true
            log_analytics_workspace_id = "${var.log_analytics_workspace_id}"
        }
    }

    tags {
        Team = "${var.tag_team}"
    }
}