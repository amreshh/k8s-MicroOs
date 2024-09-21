variable "microos_image" {
  type        = string
  description = "openSUSE MicroOS image"
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
