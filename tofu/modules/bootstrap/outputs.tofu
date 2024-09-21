output "controlplane_ignition" {
  value = libvirt_ignition.controlplane_ignition
}

output "worker_ignition" {
  value = libvirt_ignition.worker_ignition
}
