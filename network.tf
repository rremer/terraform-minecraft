data "http" "public_ipv4" {
  url = "${var.connection_public_ipv4_api_url}"
}

resource "google_compute_firewall" "app" {
  name    = "${var.global_app_name}-app"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["${module.minecraft.game_port}"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.global_app_name}"]
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.global_app_name}-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${trimspace(data.http.public_ipv4.body)}"]
  target_tags   = ["${var.global_app_name}"]
}
