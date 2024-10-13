module "network" {
  source = "./modules/network"
  domain = var.domain
}

module "volumes" {
  source            = "./modules/volumes"
  talos_linux_image = var.talos_linux_image
  controlplanes     = var.controlplanes
  workers           = var.workers
}

module "domain" {
  source     = "./modules/domain"
  network_id = module.network.kubernetes_network.id

  # controlplane
  controlplane_volumes = module.volumes.controlplane_volumes
  controlplanes        = var.controlplanes

  # worker
  worker_volumes = module.volumes.worker_volumes
  workers        = var.workers
}

module "cluster" {
  source             = "./modules/cluster"
  talos_version      = var.talos_version
  kubernetes_version = var.kubernetes_version
  domain             = var.domain
  cluster_name       = var.cluster_name
  controlplanes      = var.controlplanes
  workers            = var.workers
}
