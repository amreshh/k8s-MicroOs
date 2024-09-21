# size = convert GiB to Bytes
resource "libvirt_volume" "opensuse_microos" {
  name   = "opensuse_microos.qcow2"
  pool   = "default"
  source = var.microos_image
}

resource "libvirt_volume" "controlplanes" {
  for_each = var.controlplanes

  name           = "${each.value.name}.qcow2"
  pool           = "default"
  size           = each.value.volume_size * 1073741824
  base_volume_id = libvirt_volume.opensuse_microos.id

}

resource "libvirt_volume" "workers" {
  for_each = var.workers

  name           = "${each.value.name}.qcow2"
  pool           = "default"
  size           = each.value.volume_size * 1073741824
  base_volume_id = libvirt_volume.opensuse_microos.id

}
