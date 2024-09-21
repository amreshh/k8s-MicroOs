variable "microos_image" {
  type        = string
  default     = "../microos/openSUSE-MicroOS.x86_64-ContainerHost-kvm-and-xen.qcow2"
  description = "MicroOS image to use"
}

variable "controlplanes" {
  type = map(object({
    name        = string
    description = string
    vcpu        = number
    memory      = number
    volume_size = number
    address     = string
    mac         = string
  }))
  default = {
    controlplane1 = {
      name        = "controlplane1"
      description = "kubernetes controlplane 1"
      vcpu        = 2
      memory      = 8  # GiB
      volume_size = 20 # GiB
      address     = "192.168.150.1"
      mac         = "AA:BB:CC:50:00:01"
    }
  }
}

variable "workers" {
  type = map(object({
    name        = string
    description = string
    vcpu        = number
    memory      = number
    volume_size = number
    address     = string
    mac         = string
  }))
  default = {
    worker1 = {
      name        = "worker1"
      description = "kubernetes worker 1"
      vcpu        = 2
      memory      = 8
      volume_size = 50
      address     = "192.168.150.10"
      mac         = "AA:BB:CC:50:00:10"
    }
    worker2 = {
      name        = "worker2"
      description = "kubernetes worker 2"
      vcpu        = 2
      memory      = 8
      volume_size = 50
      address     = "192.168.150.11"
      mac         = "AA:BB:CC:50:00:11"
    }
  }
}
