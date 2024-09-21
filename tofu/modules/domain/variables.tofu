variable "network_id" {
  type        = string
  description = "Network to use"
}

variable "controlplane_ignition_id" {
  type        = string
  description = "Ignition to bootstrap controlplane"
}

variable "controlplane_volumes" {
  type = map(object({
    id   = string
    name = string
  }))
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
}

variable "worker_ignition_id" {
  type        = string
  description = "Ignition to bootstrap worker"
}

variable "worker_volumes" {
  type = map(object({
    id   = string
    name = string
  }))
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
}
