locals {
  nodes = merge(var.controlplanes, var.workers)
  common_machine_config = {
    machine = {
      certSANs = [
        for node in local.nodes : node.address
      ]
      install = {
        disk = "/dev/vda"
      }
    }
  }
}
