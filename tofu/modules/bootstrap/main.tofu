resource "libvirt_ignition" "controlplane_ignition" {
  name    = "controlplane.ign"
  pool    = "default"
  content = "../microos/ignition/controlplane.ign"
}

# resource "libvirt_combustion" "controlplane_combustion" {
#   name    = "bootstrap.sh"
#   pool    = "default"
#   content = "../microos/combustion/bootstrap.sh"
# }

resource "libvirt_ignition" "worker_ignition" {
  name    = "worker.ign"
  pool    = "default"
  content = "../microos/ignition/worker.ign"
}
