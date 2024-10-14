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

# TODO: loop better / only controlplane serves talos api
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints = [
    var.controlplanes.controlplane1.address
  ]
}

# TODO: will be deprecated
data "talos_cluster_kubeconfig" "kubeconfig" {
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.controlplanes.controlplane1.address
  depends_on = [
    talos_machine_bootstrap.talos
  ]
}
