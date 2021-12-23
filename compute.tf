data "google_compute_image" "base" {
  family  = var.compute_image_family
  project = var.compute_image_project
}

data "google_compute_zones" "available" {
  region = var.compute_region
}

resource "google_compute_instance" "minecraft" {
  depends_on   = [null_resource.ssh_public_key]
  name         = var.global_app_name
  machine_type = var.compute_instance_size
  zone         = data.google_compute_zones.available.names[0]
  tags         = [var.global_app_name]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.base.self_link
      size  = floor(var.compute_disk_size_gb)
      type  = var.compute_disk_type
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }

  metadata = {
    ssh-keys = "${var.compute_image_name}:${file(var.connection_public_credentials_path)}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

locals {
  connection_host        = google_compute_instance.minecraft.network_interface[0].access_config[0].nat_ip
  connection_user        = var.compute_image_name
  connection_private_key = file(var.connection_credentials_path)
}

module "aptdaemon" {
  source                 = "./aptdaemon"
  connection_host        = local.connection_host
  connection_user        = local.connection_user
  connection_private_key = local.connection_private_key
}

module "minecraft" {
  source                        = "./minecraft"
  connection_host               = local.connection_host
  connection_user               = local.connection_user
  connection_private_key        = local.connection_private_key
  minecraft_property_level_type = "BIOMESOP"
  minecraft_download_url        = "http://storage.googleapis.com/minecraft-robsremix/2.0.0/RobsRemix-2.0.0-server.zip"
}

