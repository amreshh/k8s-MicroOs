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
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
