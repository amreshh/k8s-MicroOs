# size = convert GiB to Bytes
resource "libvirt_volume" "talos_linux" {
  name   = "talos_linux.qcow2"
  pool   = "default"
  source = var.talos_linux_image
}

resource "libvirt_volume" "controlplanes" {
  for_each = var.controlplanes

  name           = "${each.value.name}.qcow2"
  pool           = "default"
  size           = each.value.volume_size * 1073741824
  base_volume_id = libvirt_volume.talos_linux.id

}

resource "libvirt_volume" "workers" {
  for_each = var.workers

  name           = "${each.value.name}.qcow2"
  pool           = "default"
  size           = each.value.volume_size * 1073741824
  base_volume_id = libvirt_volume.talos_linux.id

}
