data "talos_machine_configuration" "controlplanes" {
  for_each           = var.controlplanes
  cluster_name       = var.cluster_name
  machine_type       = "controlplane"
  cluster_endpoint   = "https://${each.value.name}.${var.domain}:6443"
  machine_secrets    = talos_machine_secrets.machine_secrets.machine_secrets
  talos_version      = var.talos_version
  kubernetes_version = var.kubernetes_version
  examples           = "true"
  docs               = "true"
  config_patches = [
    yamlencode(local.common_machine_config)
  ]
}

data "talos_machine_configuration" "workers" {
  for_each           = var.workers
  cluster_name       = var.cluster_name
  machine_type       = "worker"
  cluster_endpoint   = "https://${each.value.name}.${var.domain}:6443"
  machine_secrets    = talos_machine_secrets.machine_secrets.machine_secrets
  talos_version      = var.talos_version
  kubernetes_version = var.kubernetes_version
  examples           = "true"
  docs               = "true"
}

# data "talos_client_configuration" "talosconfig" {
#   for_each             = var.controlplanes
#   cluster_name         = var.cluster_name
#   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
#   endpoints            = [each.value.address]
# }

# TODO: loop better
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints = [
    "192.168.150.10",
    "192.168.150.20",
    "192.168.150.21"
  ]
}
