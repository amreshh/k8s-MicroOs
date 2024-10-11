locals {
  common_machine_config = {
    machine = {
      certSANs = [
        "192.168.150.10",
        "192.168.150.20",
        "192.168.150.21",
        "controlplane1.k8s.lab"
    ] }
  }
}

resource "talos_machine_secrets" "machine_secrets" {
  talos_version = var.talos_version
}

resource "talos_machine_configuration_apply" "controlplane" {
  for_each                    = data.talos_machine_configuration.controlplanes
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = each.value.machine_configuration
  endpoint                    = var.controlplanes[each.key].address
  node                        = var.controlplanes[each.key].address
  config_patches = [
    yamlencode({
      machine = {
        install = {
          disk = "/dev/vda"
        }
      }
    })
  ]
}

resource "talos_machine_configuration_apply" "workers" {
  for_each                    = data.talos_machine_configuration.workers
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = each.value.machine_configuration
  endpoint                    = var.workers[each.key].address
  node                        = var.workers[each.key].address
  config_patches = [
    yamlencode({
      machine = {
        install = {
          disk = "/dev/vda"
        }
      }
    })
  ]
}

resource "talos_machine_bootstrap" "talos" {
  for_each             = var.controlplanes
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoint             = each.value.address
  node                 = each.value.address
}


# resource "talos_cluster_kubeconfig" "kubeconfig" {
#   for_each             = var.controlplanes
#   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
#   endpoint             = each.value.address
#   node                 = each.value.address
#   depends_on = [
#     talos_machine_bootstrap.talos
#   ]
# }

# TODO: combine kubeconfig in loop
resource "talos_cluster_kubeconfig" "kubeconfig" {
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoint             = "192.168.150.10"
  node                 = "192.168.150.10"
  depends_on = [
    talos_machine_bootstrap.talos
  ]
}
