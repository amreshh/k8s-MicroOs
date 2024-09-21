resource "libvirt_domain" "controlplanes" {
  for_each = var.controlplanes

  name            = each.value.name
  description     = each.value.description
  vcpu            = each.value.vcpu
  memory          = each.value.memory * 1024
  running         = true
  coreos_ignition = var.controlplane_ignition_id

  disk {
    volume_id = var.controlplane_volumes[each.value.name].id
    scsi      = false
  }

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_id     = var.network_id
    hostname       = each.value.name
    addresses      = [each.value.address]
    mac            = each.value.mac
    wait_for_lease = true
  }
}

resource "libvirt_domain" "workers" {
  for_each = var.workers

  name            = each.value.name
  description     = each.value.description
  vcpu            = each.value.vcpu
  memory          = each.value.memory * 1024
  running         = true
  coreos_ignition = var.worker_ignition_id

  disk {
    volume_id = var.worker_volumes[each.value.name].id
    scsi      = false
  }

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_id     = var.network_id
    hostname       = each.value.name
    addresses      = [each.value.address]
    mac            = each.value.mac
    wait_for_lease = true
  }
}
