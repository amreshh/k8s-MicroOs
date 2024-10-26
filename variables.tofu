variable "talos_linux_image" {
  type        = string
  default     = "metal-amd64.qcow2"
  description = "Talos Linux Image"
}

variable "talos_version" {
  type        = string
  default     = "1.8.0"
  description = "Talos version"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.31.1"
  description = "Kubernetes version to provision"
}

variable "cilium_version" {
  type        = string
  default     = "1.16.2"
  description = "Cilium version to provision"
}

variable "domain" {
  type        = string
  default     = "k8s.local"
  description = "Network domain"
}

variable "cluster_name" {
  type        = string
  default     = "talos"
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
  default = {
    controlplane1 = {
      machine_type = "controlplane"
      name         = "controlplane1"
      description  = "kubernetes controlplane 1"
      vcpu         = 2
      memory       = 8  # GiB
      volume_size  = 20 # GiB
      address      = "192.168.150.10"
      mac          = "AA:BB:CC:50:00:10"
    }
  }
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
  default = {
    worker1 = {
      machine_type = "worker"
      name         = "worker1"
      description  = "kubernetes worker 1"
      vcpu         = 2
      memory       = 8
      volume_size  = 50
      address      = "192.168.150.20"
      mac          = "AA:BB:CC:50:00:20"
    }
    worker2 = {
      machine_type = "worker"
      name         = "worker2"
      description  = "kubernetes worker 2"
      vcpu         = 2
      memory       = 8
      volume_size  = 50
      address      = "192.168.150.21"
      mac          = "AA:BB:CC:50:00:21"
    }
  }
}
