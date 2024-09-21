module "network" {
  source = "./modules/network"
}

module "volumes" {
  source        = "./modules/volumes"
  microos_image = var.microos_image
  controlplanes = var.controlplanes
  workers       = var.workers
}

module "bootstrap" {
  source = "./modules/bootstrap"
}

module "domain" {
  source     = "./modules/domain"
  network_id = module.network.kubernetes_network.id

  # controlplane
  controlplane_ignition_id = module.bootstrap.controlplane_ignition.id
  controlplane_volumes     = module.volumes.controlplane_volumes
  controlplanes            = var.controlplanes

  # worker
  worker_ignition_id = module.bootstrap.worker_ignition.id
  worker_volumes     = module.volumes.worker_volumes
  workers            = var.workers
}
