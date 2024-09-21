output "controlplane_volumes" {
  value = libvirt_volume.controlplanes
}

output "worker_volumes" {
  value = libvirt_volume.workers
}
