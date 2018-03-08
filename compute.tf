data "google_compute_image" "base" {
  family  = "${var.compute_image_family}"
  project = "${var.compute_image_project}"
}

data "google_compute_zones" "available" {
  region = "${var.compute_region}"
}

resource "google_compute_instance" "minecraft" {
  depends_on   = ["null_resource.ssh_public_key"]
  name         = "${var.global_app_name}"
  machine_type = "${var.compute_instance_size}"
  zone         = "${data.google_compute_zones.available.names.0}"
  tags         = ["${var.global_app_name}"]

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.base.self_link}"
    }
  }

  attached_disk {
    source = "${google_compute_disk.persistent.self_link}"
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }

  metadata {
    ssh-keys = "${var.compute_image_name}:${file("${var.connection_public_credentials_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

module "aptdaemon" {
  source                 = "./aptdaemon"
  connection_host        = "${google_compute_instance.minecraft.network_interface.0.access_config.0.assigned_nat_ip}"
  connection_user        = "${var.compute_image_name}"
  connection_private_key = "${file("${var.connection_credentials_path}")}"
}

module "minecraft" {
  source                 = "./minecraft"
  connection_host        = "${google_compute_instance.minecraft.network_interface.0.access_config.0.assigned_nat_ip}"
  connection_user        = "${var.compute_image_name}"
  connection_private_key = "${file("${var.connection_credentials_path}")}"
}
