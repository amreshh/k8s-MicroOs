resource "libvirt_network" "kubernetes_network" {
  name      = "kubernetes_network"
  mode      = "nat"
  domain    = "k8s.lab"
  addresses = ["192.168.150.0/24"]
  autostart = false

  dns {
    enabled    = true
    local_only = false
  }
}
