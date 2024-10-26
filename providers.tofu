terraform {
  required_version = "~>1.8 "

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "helm" {
  kubernetes {
    host                   = "https://controlplane1.k8s.local:6443" # TODO: Make this dynamic
    cluster_ca_certificate = base64decode(module.cluster.kubeconfig.kubernetes_client_configuration.ca_certificate)
    client_certificate     = base64decode(module.cluster.kubeconfig.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(module.cluster.kubeconfig.kubernetes_client_configuration.client_key)
  }
}
