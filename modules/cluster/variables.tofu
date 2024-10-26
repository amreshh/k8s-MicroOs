variable "talos_version" {
  type        = string
  description = "Talos version"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version to provision"
}

variable "domain" {
  type        = string
  description = "Network domain"
}

variable "cilium_version" {
  type        = string
  description = "Cilium version to provision"
}

variable "cluster_name" {
  type        = string
  description = "Name of the kubernetes cluster"
}

variable "controlplanes" {
  type = map(object({
    machine_type = string
    name         = string
    description  = string
    vcpu         = number
    memory       = number
    volume_size  = number
    address      = string
    mac          = string
  }))
}

variable "workers" {
  type = map(object({
    machine_type = string
    name         = string
    description  = string
    vcpu         = number
    memory       = number
    volume_size  = number
    address      = string
    mac          = string
  }))
}
