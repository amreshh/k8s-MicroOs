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
    yamlencode(local.common_machine_config)
  ]
}

resource "talos_machine_configuration_apply" "workers" {
  for_each                    = data.talos_machine_configuration.workers
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = each.value.machine_configuration
  endpoint                    = var.workers[each.key].address
  node                        = var.workers[each.key].address
  config_patches = [
    yamlencode(local.common_machine_config)
  ]
}

resource "talos_machine_bootstrap" "talos" {
  for_each             = var.controlplanes
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoint             = each.value.address
  node                 = each.value.address
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoint             = var.controlplanes.controlplane1.address
  node                 = var.controlplanes.controlplane1.address
}

resource "time_sleep" "wait_for_cluster" {
  create_duration = "2m"
  depends_on = [
    talos_machine_bootstrap.talos
  ]
}

resource "helm_release" "cilium" {
  name            = "cilium"
  repository      = "https://helm.cilium.io/"
  version         = var.cilium_version
  chart           = "cilium"
  namespace       = "kube-system"
  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "ipam.mode"
    value = "kubernetes"
  }
  set {
    name  = "kubeProxyReplacement"
    value = "true"
  }
  set {
    name  = "securityContext.capabilities.ciliumAgent"
    value = "{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}"
  }
  set {
    name  = "securityContext.capabilities.cleanCiliumState"
    value = "{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}"
  }
  set {
    name  = "cgroup.autoMount.enabled"
    value = "false"
  }
  set {
    name  = "cgroup.hostRoot"
    value = "/sys/fs/cgroup"
  }
  set {
    name  = "k8sServiceHost"
    value = "localhost"
  }
  set {
    name  = "k8sServicePort"
    value = "7445"
  }

  depends_on = [
    time_sleep.wait_for_cluster
  ]
}

resource "local_file" "kubeconfig_file" {
  content         = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  filename        = "/root/.kube/config"
  file_permission = "0711"
}

resource "local_file" "talosconfig_file" {
  content  = data.talos_client_configuration.talosconfig.talos_config
  filename = "/root/.talos/config"
}
